class solr::install (
  
  $solr           = $solr::params::solr_version,
  $tomcat_webapps = $solr::params::tomcat_webapps,
)  inherits solr::params {
  include solr::config

  staging::file { "solr-$solr.tgz":
    source  => "http://www.gtlib.gatech.edu/pub/apache/lucene/solr/$solr/solr-$solr.tgz",
    timeout => 1200,
    subdir  => solr,
    ##TODO Should probably go into a tomcat module specific to our tomcat package
    require => Class['tomcat'],
    notify  => Service['tomcat'],
  }

  staging::extract { "solr-$solr.tgz":
    target  => '/usr/local/tomcat',
    creates => "/usr/local/tomcat/solr-$solr",
    require => Staging::File["solr-$solr.tgz"],
  }

    file { "/usr/local/tomcat/solr-$solr":
      ensure  => directory,
      owner   => tomcat7,
      group   => tomcat,
      recurse => true,
      require => Staging::Extract["solr-$solr.tgz"],
    }

  exec { 'copy_solr_war':
    command => "cp /usr/local/tomcat/solr-$solr/dist/solr-$solr.war /usr/local/solr/solr.war",
    path    => ['/usr/bin/','/bin/'],
    creates => "/usr/local/solr/solr.war",
    require => Staging::Extract["solr-$solr.tgz"],
  }

  file { 'copy_solr_libs':
    ensure  => directory,
    recurse => true,
    owner   => tomcat7,
    group   => tomcat,
    source  => 'puppet:///local/solr/lib',
    path    => '/usr/local/solr/lib',
    require => File["$solr::config::solr_home"],
  }

  file { 'copy_solr_contrib':
    path    => '/usr/local/solr/lib/contrib',
    ensure  => directory,
    recurse => true,
    owner   => tomcat7,
    group   => tomcat,
    source  => 'puppet:///local/solr/contrib',
    require => File["$solr::config::solr_home"],
  }

#  file { 'solr_current':
#    ensure  => link,
#    path    => "$tomcat_webapps/solr",
#    target  => "$tomcat_webapps/solr-$solr/",
#    owner   => $solr::params::user,
#    group   => $solr::params::group,
#    require => [Exec['copy_solr_war'],Class['tomcat::service']],
#    
#  }


}

