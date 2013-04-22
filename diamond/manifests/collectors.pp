define diamond::collectors {
	$require = Class["diamond::config"]
    include diamond
	File {
		owner		=> "root",
		group		=> "root",
		mode		=> "0644",
	}

	file { 
        "/etc/diamond/collectors/${name}.conf":
        source      => "puppet:///modules/diamond/collectors/${name}.conf",
        notify      => Class["diamond::service"];
	}
}
