class solr::params {
  $solr_version         = '4.1.0'
  $tomcat_webapps       = '/usr/local/tomcat/webapps'
  $user                 = 'tomcat'
  $group                = 'tomcat'
  $solr_home            = '/usr/share/solr'
  $server_host          = $::fqdn
  $tomcat_http_port     = '8080'
  $tomcat_https_port    = '8443'
  $java_version         = '1.7.0'
  $tomcat_shutdown_port = '8005'
  $solr_context         = 'solr'

}
