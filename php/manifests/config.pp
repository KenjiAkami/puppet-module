class php::config {
    $require = Class["php::install"]

    File {
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => 0644,
    }

    file { 
		"/etc/php.ini":
		source  => "puppet:///modules/php/php.ini";
    }
}
