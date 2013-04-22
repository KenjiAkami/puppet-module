class routing::service {
	service { "network":
#		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
		require => Class["routing::config"],
	}
}
