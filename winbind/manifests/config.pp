class winbind::config {
	$require = Class["winbind::install"]
	File {
		owner	=> "root",
		group	=> "root",
		mode	=> "0644",
	}

	file {  
        "/home/CROOZ":
        ensure => directory;

        "/var/opslog":
		mode	=> "0777",
        ensure => directory;

		"/usr/bin/scriptreplay":
		ensure	=> present,
		mode	=> "0755",
		source	=> "puppet:///modules/winbind/scriptreplay";

		"/etc/nsswitch.conf":
		ensure	=> present,
		source	=> "puppet:///modules/winbind/nsswitch.conf";

		"/etc/pam.d/system-auth":
		ensure	=> present,
		source	=> "puppet:///modules/winbind/system-auth";

		"/etc/profile":
		ensure	=> present,
		source	=> "puppet:///modules/winbind/profile";

		"/etc/krb5.conf":
		ensure	=> present,
		source	=> "puppet:///modules/winbind/krb5.conf",
        notify => Service["winbind"];

        "/etc/samba/smb.conf":
        content => template("winbind/smb.conf.erb"),
        notify => Service["smb"];
	}
}
