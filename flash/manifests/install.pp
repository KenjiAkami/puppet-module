class flash::install {
	package { "flash":
		name    => ["swftools", "swfmill", "swfmill-devel", "flasm",],
		ensure  => installed,
        require => Class["yumrepo"],
	}
}
