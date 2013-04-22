class redis::config ($masterip="") { 
	FIle {
		ensure => present,
		owner  => "root",
		group  => "root",
		mode   => "0644",
	}
	file { 
        "/crooz":
		mode   => "0777",
        ensure  => "directory";

        "/crooz/redis":
		mode   => "0777",
        ensure  => "directory";

		"/etc/redis.conf":
		content => template("redis/redis.conf.erb"),
		require => Class["redis::install"];
	}

    augeas { "redis-sysctl":
        context => "/files/etc/sysctl.conf",
        changes => [
            "set vm.overcommit_memory 1",
        ],
    }
}
