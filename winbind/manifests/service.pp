class winbind::service {
	service {"winbind":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
	}

	service {"smb":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
	}
}
