class hobbit::config {
	user { "hobbit":
		ensure      => present,
		comment     => "hobbit user",
		gid         => "hobbit",
        managehome  => "true",
		shell       => "/bin/bash",
		require     => Group["hobbit"],
	}

    group { "hobbit":
		ensure      => present,
    }

    File {
		ensure      => present,
		owner       => "hobbit",
		group       => "hobbit",
		mode        => "0755",
    }

	file {  
        "/home/hobbit/hobbit_client":
		source      => "puppet:///modules/hobbit/hobbit_client",
        recurse     => "true";

        "/var/log/messages":
		owner       => "root",
		group       => "root",
        mode        => "0666";

        "/home/hobbit/hobbit_client/client/etc/clientlaunch.cfg":
        source      => "puppet:///modules/hobbit/clientlaunch.cfg.${hobbitconf}";
	}
}
