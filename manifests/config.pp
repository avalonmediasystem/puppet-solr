class solr::config (
  $tomcat_webapps      = $solr::params::tomcat_webapps,
  $tomcat_webapps_conf = $solr::params::tomcat_webapps_conf,
  $user                = $solr::params::user,
  $group               = $solr::params::group,
  $version             = $solr::params::solr_version,
  $solr_base           = $solr::params::solr_base,
  $solr_home           = $solr::params::solr_home,
  $solr_conf           = "$solr::params::solr_home/conf",
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
  #    file { 'solr_conf':
  #      ensure  => directory,
  #      owner   => $user,
  #      group   => $group,
  #      require => File['solr_conf_avalon'],
  #      path    => "$solr_home/avalon/conf/",
  #    }
  #
  ##TODO parameterize
  file { 'solr_collection1':
    ensure  => directory,
    owner   => $user,
    group   => $group,
    path    => "$solr_home/collection1",
    require => File["$solr_home"],
  }

  file { 'solr_avalon':
    ensure  => directory,
    owner   => $user,
    group   => $group,
    path    => "$solr_home/avalon",
    require => File["$solr_home"],
  }
  
  file { 'solr_conf_collection1':
    ensure  => directory,
    path    => "$solr_home/collection1/conf",
    source  => 'puppet:///local/solr/collection1/conf',
    owner   => $solr::params::user,
    group   => $solr::params::group,
    recurse => true,
    require => [File['solr_collection1'],File['solr_current']],
    notify  => Service['tomcat'],
  }
  #  file { 'solr_conf_avalon':
  #    ensure  => directory,
  #    path    => "$solr_home/avalon/conf",
  #    source  => 'puppet:///local/solr/avalon/conf',
  #    owner   => $solr::params::user,
  #    group   => $solr::params::group,
  #    recurse => true,
  #    require => [File['solr_collection1'],File['solr_current']],
  #    notify  => Service['tomcat'],
  #  }
  ##TODO parameterize
}

