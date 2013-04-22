class routing::config {
	File {
			ensure => present,
			owner => 'root',
			group => 'root',
			mode => 0600,
	}
    file { "routing":
        path => "/etc/sysconfig/static-routes",
            source => $network_bond1 ? {
				'172.16.0.0' => "puppet:///modules/routing/static-routes.172.16",
				'172.24.0.0' => "puppet:///modules/routing/static-routes.172.24",
				'172.25.0.0' => "puppet:///modules/routing/static-routes.172.25",
				default		 => undef,
		    },
#        notify => Class["routing::service"];
	}
}
