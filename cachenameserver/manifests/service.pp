class cachenameserver::service {
	service { "cachenameserverd":
        name        => "named",
		ensure      => running,
		enable      => true,
		hasstatus   => true,
		hasrestart  => true,
		require     => Class["cachenameserver::config"],
	}
}
