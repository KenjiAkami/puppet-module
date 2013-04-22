class php::install {
	package { "php":
		name    => ["php", "php-devel", "php-gd", "php-mbstring", "php-mcrypt", "php-mysql", "php-ncurses", "php-pdo", "php-pear", "php-pecl-memcache", "php-soap", "php-xml", "php-xmlrpc",],
		ensure  => installed,
        require => Class["yumrepo"],
	}
}
