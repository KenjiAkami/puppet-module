class redis26::config ($masterip="") { 
    $require = Class["redis26::install"]
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
		content => template("redis26/redis.conf.erb");

        "/etc/init.d/redis":
        mode    => "0755",
        source  => "puppet:///modules/redis26/redis";

        "/etc/ld.so.conf.d/usr_local_lib.conf":
        mode    => "0644",
        source  => "puppet:///modules/redis26/usr_local_lib.conf";

        "/var/log/redis":
        owner  => "redis",
        group  => "redis",
        mode   => "0755",
        ensure  => "directory";
    }

    augeas { "redis-sysctl":
        context => "/files/etc/sysctl.conf",
        changes => [
            "set vm.overcommit_memory 1",
        ],
    }
}
