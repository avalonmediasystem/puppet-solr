class solr::params {
  $solr_version         = '4.1.0'
  $tomcat_webapps       = '/usr/local/tomcat/webapps'
  $tomcat_webapps_conf  = '/usr/local/tomcat/conf/Catalina/localhost/'
  $tomcat_root          = '/usr/local/tomcat'
  $user                 = 'tomcat7'
  $group                = 'tomcat'
  $solr_home            = '/usr/local/solr'
  $server_host          = $::fqdn
  $tomcat_http_port     = '8080'
  $tomcat_https_port    = '8443'
  $java_version         = '1.7.0'
  $tomcat_shutdown_port = '8005'
  $solr_context         = 'solr'

}
