class bind::install {
	package { "bind":
        name    => ["caching-nameserver", "bind", "bind-chroot",],
		ensure  => installed;
	}
}
