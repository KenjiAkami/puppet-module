class mcollective::config {
    FIle {
		ensure => present,
		owner  => "root",
		group  => "root",
		mode   => "0640",
    }

	file { 
        "/etc/mcollective/server.cfg":
        source => "puppet:///modules/mcollective/server.cfg",
        notify => Class["mcollective::service"],
        require => Class["mcollective::install"],
	}
}
