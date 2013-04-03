class solr::install (
  
  $solr           = $solr::params::solr_version,
  $tomcat_webapps = $solr::params::tomcat_webapps,
)  inherits solr::params {
  include solr::config
  include staging

  staging::file { "solr-$solr.tgz":
    source  => "http://www.gtlib.gatech.edu/pub/apache/lucene/solr/$solr/solr-$solr.tgz",
    timeout => 1200,
    subdir  => solr,
    ##TODO Should probably go into a tomcat module specific to our tomcat package
    require => Class['tomcat'],
    notify  => Service['tomcat'],
  }

  staging::extract { "solr-$solr.tgz":
    target  => "${staging::path}/solr",
    creates => "${staging::path}/solr/solr-$solr",
    require => Staging::File["solr-$solr.tgz"],
  }

  file { "$solr_home/solr.war":
    source  => "${staging::path}/solr/solr-$solr/dist/solr-$solr.war",
    owner   => tomcat7,
    group   => tomcat,
    require => [Staging::Extract["solr-$solr.tgz"],File[$solr_home]],
  }

  class { 'solr::contrib':
    solr    => $solr,
    require => [Staging::Extract["solr-$solr.tgz"],File[$solr_home]],
  }
}

