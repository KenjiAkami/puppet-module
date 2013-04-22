class diamond::install {
    $require = Class["yumrepo"]
	package { "init-diamond":
		name    => [ "Python", "psutil", "python-configobj","mock",],
		ensure  => "installed",
	}

    package { 
        "diamond":
		ensure  => "latest",
        require => Package["init-diamond"],
		notify  => Class["diamond::config"];

        "python-redis":
        require => Package["init-diamond"],
		ensure  => "latest";
        
        "MySQL-python":
        require => Package["init-diamond"],
		ensure  => "latest";
    }

}
