class solr::config (
  $tomcat_webapps      = $solr::params::tomcat_webapps,
  $tomcat_webapps_conf = $solr::params::tomcat_webapps_conf,
  $user                = $solr::params::user,
  $group               = $solr::params::group,
  $version             = $solr::params::solr_version,
  $solr_base           = $solr::params::solr_base,
  $solr_home           = $solr::params::solr_home,
  #  $solr_conf           = "$solr::params::solr_home/conf",
  $solr_xml            = $solr::params::solr_xml,


) inherits solr::params {

  file { 'solr.xml':
    ensure  => file,
    owner   => $user,
    group   => $group,
    content => template('solr/solr.xml.erb'),
    path    => "$tomcat_webapps_conf/solr.xml",
    require => Class['solr::install'],
    notify  => Service['tomcat'],
  }
  
  file { "$solr_home":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => File['solr.xml'],
  }
  ##TODO parameterize
  #  file { 'solr_conf':
  #    ensure  => directory,
  #    owner   => $user,
  #    group   => $group,
  #    require => File[$solr_home],
  #    path    => "$solr_home/conf",
  #  }
  #
  ##TODO parameterize
  file { 'solr_conf_avalon':
    ensure  => directory,
    path    => "$solr_home/avalon",
    source  => 'puppet:///modules/solr/avalon',
    owner   => $solr::params::user,
    group   => $solr::params::group,
    recurse => true,
    require => File["$solr_home"],
    notify  => Service['tomcat'],
  }
  ##TODO parameterize
  file { 'solr_conf_collection1':
    ensure  => directory,
    path    => "$solr_home/collection1",
    source  => 'puppet:///modules/solr/collection1',
    owner   => $solr::params::user,
    group   => $solr::params::group,
    recurse => true,
    require => File["$solr_home"],
    notify  => Service['tomcat'],
  }

}

