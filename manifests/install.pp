class solr::install (
  
  $solr           = $solr::params::solr_version,
  $tomcat_webapps = $solr::params::tomcat_webapps,
)  inherits solr::params {

  staging::file { "solr-$solr.tgz":
    source  => "http://www.gtlib.gatech.edu/pub/apache/lucene/solr/$solr/solr-$solr.tgz",
    timeout => 1200,
    subdir  => solr,
    ##TODO Should probably go into a tomcat module specific to our tomcat package
    require => Package['tomcat'],
  }

  staging::extract { "solr-$solr.tgz":
    target  => '/usr/local/tomcat',
    creates => '/usr/local/tomcat/solr-4.1.0',
    require => Staging::File["solr-$solr.tgz"],
  }

  exec { 'copy_solr_war':
    command => "cp /usr/local/tomcat/solr-$solr/dist/solr-$solr.war $tomcat_webapps",
    path    => ['/usr/bin/','/bin/'],
    creates => "$tomcat_webapps/solr-$solr.war",
    require => Staging::Extract["solr-$solr.tgz"],
  }

  file { 'solr_current':
    ensure  => link,
    path    => "$tomcat_webapps/solr",
    target  => "$tomcat_webapps/solr-$solr/",
    owner   => $solr::params::user,
    group   => $solr::params::group,
    require => Exec['copy_solr_war'],
  }


}

