class redis26::install {
	package { "redis-2.6.10-1":
		ensure => present,
        require => Class["yumrepo"];
	}

    user { "redis":
        ensure => present,
        comment => "Redis user",
        uid => "10002",
        gid => "10002",
        shell => "/bin/false",
        require => Group["redis"],
    }

    group { "redis":
        ensure => present,
        gid => "10002"
    }   
}
