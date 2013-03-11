class solr::config (
  $tomcat_webapps = $solr::params::tomcat_webapps,
  $user           = $solr::params::user,
  $group          = $solr::params::group,
  $version        = $solr::params::solr_version,
  $solr_base      = $solr::params::solr_base,
  $solr_home      = $solr::params::solr_home,
  $solrconfig_xml = $solr::params::solrconfig_xml,
  $solr_xml       = $solr::params::solr_xml,


) inherits solr::params {

}

