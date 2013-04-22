class resolv::config ($dnslist=["172.24.5.81", "172.18.1.138", "158.205.229.244", "158.205.237.131",]) {
	file { "/etc/resolv.conf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => 0644,
        content => template("resolv/resolv.conf.erb"),
	}
}

