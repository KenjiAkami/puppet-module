class haproxy::config { 
	FIle {
		owner  => "root",
		group  => "root",
		mode   => "0644",
	}
	file { 
		"/usr/sbin/haproxy":
		ensure => present,
		mode   => "0755",
		source => "puppet:///modules/haproxy/haproxy";

		"/etc/rsyslog.conf":
		ensure => present,
		source => "puppet:///modules/haproxy/rsyslog.conf",
		require => Class["haproxy::install"],
		notify => Service["rsyslog"];

		"/etc/logrotate.d/haproxy":
		ensure => present,
		source => "puppet:///modules/haproxy/haproxy_rotate";
	
		"/etc/haproxy/errfile":
		source => "puppet:///modules/haproxy/errfile",
		recurse	=> true,
		ensure	=> "directory";

#		"/etc/monit.d/haproxy":
#		source => "puppet:///modules/haproxy/haproxy.monit";
	}

	service { "rsyslog":
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
	}
}
