class td-agent::service {
	service {"td-agent":
		ensure => running,
		enable => true,
	}
}
