class winbind::install {
	Package {
		ensure => present,
	}

	package {
		"samba":
		name   => ["samba-swat", "samba-common", "samba", "samba-client"];

		"krb5":
		name   => ["krb5-auth-dialog", "krb5-libs", "krb5-devel", "pam_krb5", "krb5-workstation"];

		"xinetd":
	}
}
