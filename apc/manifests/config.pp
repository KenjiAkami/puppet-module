class apc::config {
    $require = Class["apc::install"]
    File {
		owner   => "root",
		group   => "root",
		mode    => "0644",
    }

	file { 
        "/etc/php.d/apc.ini":
        source  => "puppet:///modules/apc/apc.ini";
#		notify  => Class["apache::service"];
	}
}


