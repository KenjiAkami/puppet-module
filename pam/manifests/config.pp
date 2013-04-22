class pam::config {
	File {
		owner   => "root",
		group   => "root",
		mode    => 644,
	}

	file { 
	    "/etc/pam.d/login":
		ensure => present,
		source => "puppet:///modules/pam/login";
	}
}
