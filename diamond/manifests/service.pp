class diamond::service {
	service { "diamond":
		ensure		=> running,
		enable		=> true,
		hasstatus	=> true,
		hasrestart	=> true,
		require		=> Class["diamond::config"],
	}
}
