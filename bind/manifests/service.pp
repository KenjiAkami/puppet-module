class bind::service {
	service { "bind":
        name        => "named",
		ensure      => running,
		enable      => true,
		hasstatus   => true,
		hasrestart  => true,
	}
}
