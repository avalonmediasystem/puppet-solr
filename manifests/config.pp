class solr::config (
  $tomcat_webapps      = $solr::params::tomcat_webapps,
  $tomcat_webapps_conf = $solr::params::tomcat_webapps_conf,
  $user                = $solr::params::user,
  $group               = $solr::params::group,
  $version             = $solr::params::solr_version,
  $solr_base           = $solr::params::solr_base,
  $solr_home           = $solr::params::solr_home,
  $solrconfig_xml      = $solr::params::solrconfig_xml,
  $solr_xml            = $solr::params::solr_xml,


) inherits solr::params {

  file { 'solr.xml':
    ensure  => file,
    content => template('solr/solr.xml.erb'),
    path    => "$tomcat_webapps_conf/solr.xml",
    require => Class['solr::install'],
    notify  => Service['tomcat'],
  }

  #  file { 'solrconfig.xml':
  #    ensure  => file,
  #    content => template('solr/solrconfig.xml.erb'),
  #    path    => 
  #
  #
  #
}

