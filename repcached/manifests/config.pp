define repcached::config( $ip_a,
                          $ip_b
    ) {
	file {  "/etc/sysconfig/memcached":
		ensure => present,
		owner => "root",
		group => "root",
		mode => "0644",
		content => template("repcached/repcached.conf.erb"),
        require => Class["repcached::install"];
        
        "/etc/init.d/memcached":
		owner => "root",
		group => "root",
		mode => "0755",
        source  => "puppet:///modules/repcached/memcached";
	}
}
