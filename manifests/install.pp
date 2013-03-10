class solr::install inherits solr::params {

  staging::file { "solr-$solr::params::solr_version.tgz":
    source  => 'http://www.gtlib.gatech.edu/pub/apache/lucene/solr/4.1.0/solr-4.1.0.tgz',
    timeout => 1200,
    subdir  => solr,
  }

  staging::extract { "solr-$solr::params::solr_version.tgz":
    target  => '/usr/local/tomcat',
    creates => '/usr/local/tomcat/solr-4.1.0',
    require => Staging::File["solr-$solr::params::solr_version.tgz"],
  }


}

