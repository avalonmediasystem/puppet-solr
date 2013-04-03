class solr::contrib (
	$solr = $solr::params::solr_version
) inherits solr::params {
	File { 
    owner   => tomcat7,
    group   => tomcat,
		require => [Staging::Extract["solr-$solr.tgz"],File[$solr_home]]
	}

	file { "$solr_home/lib/solr-analysis-extras-$solr.jar":
		ensure => present,
		source => "${staging::path}/solr/solr-$solr/dist/solr-analysis-extras-$solr.jar"
	}

	file { "$solr_home/lib/solr-clustering-$solr.jar":
		ensure => present,
		source => "${staging::path}/solr/solr-$solr/dist/solr-clustering-$solr.jar"
	}

	file { "$solr_home/lib/solr-langid-$solr.jar":
		ensure => present,
		source => "${staging::path}/solr/solr-$solr/dist/solr-langid-$solr.jar"
	}

	file { "$solr_home/lib/contrib/analysis-extras":
		ensure  => present,
		recurse => true,
		source  => "${staging::path}/solr/solr-$solr/contrib/analysis-extras"
	}

	file { "$solr_home/lib/contrib/clustering":
		ensure  => present,
		recurse => true,
		source  => "${staging::path}/solr/solr-$solr/contrib/clustering"
	}

	file { "$solr_home/lib/contrib/langid":
		ensure  => present,
		recurse => true,
		source  => "${staging::path}/solr/solr-$solr/contrib/langid"
	}
}