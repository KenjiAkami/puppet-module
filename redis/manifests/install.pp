class redis::install {
#	package { "redis-2.4.10-1.el5":
	package { "redis":
		ensure => "2.4.10-1.el5",
#		ensure => present,
        require => Class["yumrepo"];
	}
}
