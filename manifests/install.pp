class solr::install (
   
) inherits solr::params {

  staging::file { "solr-$solr::params::solr_version.tgz":
    source  => "http://www.gtlib.gatech.edu/pub/apache/lucene/solr/$solr::params::solr_version/solr-$solr::params::solr_version.tgz",
    timeout => 1200,
    subdir  => solr,
  }

  staging::extract { "solr-$solr::params::solr_version.tgz":
    target  => '/usr/local/tomcat',
    creates => '/usr/local/tomcat/solr-4.1.0',
    require => Staging::File["solr-$solr::params::solr_version.tgz"],
  }

  exec { 'copy_solr_war':
    command => "cp /usr/local/tomcat/solr-$solr::params::solr_version/dist/solr-$solr::params::solr_version.war $solr::params::tomcat_webapps",
    path    => ['/usr/bin/','/bin/'],
    creates => "$solr::params::tomcat_webapps/solr-$solr::params::solr_version.war",
    require => Staging::Extract["solr-$solr::params::solr_version.tgz"],
  }

  file { 'solr_current':
    ensure  => link,
    path    => "$solr::params::tomcat_webapps/solr",
    target  => "$solr::params::tomcat_webapps/solr-$solr::params::solr_version/",
    owner   => $solr::params::user,
    group   => $solr::params::group,
    require => Exec['copy_solr_war'],
  }


}

