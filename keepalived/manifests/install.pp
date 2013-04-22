class keepalived::install {
	package { "keepalived":
        name    => ["ipvsadm", "keepalived"],
        ensure  => present,
	}
}
