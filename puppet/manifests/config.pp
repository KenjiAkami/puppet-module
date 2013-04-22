class puppet::config {
#	$require = Class["puppet::install"]
#    $notify = Class["puppet::service"]
	FIle {
        ensure => present,
		owner  => "root",
		group  => "root",
		mode   => "0644",
	}

	file {  
        "/etc/puppet/auth.conf":
		source => "puppet:///modules/puppet/auth.conf",
		notify => Class["puppet::service"];

        "/etc/puppet/namespaceauth.conf":
		source => "puppet:///modules/puppet/namespaceauth.conf",
		notify => Class["puppet::service"];

        "/etc/puppet/puppet.conf":
		source => "puppet:///modules/puppet/puppet.conf",
		notify => Class["puppet::service"];
	}
}
