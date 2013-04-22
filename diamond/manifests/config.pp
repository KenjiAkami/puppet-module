class diamond::config {
	$require = Class["diamond::install"]

	File {
		owner		=> "root",
		group		=> "root",
		mode		=> "0644",
	}

	file { 
		"/etc/diamond/diamond.conf":
        source      => "puppet:///modules/diamond/diamond.conf",
        notify      => Class["diamond::service"];

		"/etc/init.d/diamond":
        mode        => "0755",
        source      => "puppet:///modules/diamond/diamond.init.d",
        notify      => Class["diamond::service"];

        "/etc/diamond/collectors/IPMISensorCollector.conf":
        source      => "puppet:///modules/diamond/collectors/IPMISensorCollector.conf";

        "/etc/diamond/collectors/NetworkCollector.conf":
        source      => "puppet:///modules/diamond/collectors/NetworkCollector.conf";

        "/etc/diamond/collectors/SoftInterruptCollector.conf":
        source      => "puppet:///modules/diamond/collectors/SoftInterruptCollector.conf";

        "/etc/diamond/collectors/TCPCollector.conf":
        source      => "puppet:///modules/diamond/collectors/TCPCollector.conf";
	}
}
