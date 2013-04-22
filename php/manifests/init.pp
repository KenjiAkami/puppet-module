class php {
	include php::install, php::config
}

class php::redis {
    package { "php-redis":
        ensure  => "installed",
        require => Class["yumrepo"],
    }
}
