class hostsallowdeny::config {
	File {
		ensure	=> present,
		owner	=> "root",
		group	=> "root",
		mode	=> "0644",
	}

	file { 
		"/etc/hosts.allow":
		source	=> "puppet:///modules/hostsallowdeny/hosts.allow";

		"/etc/hosts.deny":
		source	=> "puppet:///modules/hostsallowdeny/hosts.deny";
	}
}
