class memcached::config {
	file {  "/etc/sysconfig/memcached":
		ensure => present,
		owner => "root",
		group => "root",
		mode => "0644",
		source => "puppet:///modules/memcached/memcached",
		require => Class["memcached::install"],
	}
}
