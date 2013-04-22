class sudoer::config {
	file { "/etc/sudoers":
		owner    => "root",
		group    => "root",
		mode     => "0440",
		source   => $operatingsystemrelease ? {
            '5.4'   =>  "puppet:///modules/sudoer/sudoers.5.4",
            '5.7'   =>  "puppet:///modules/sudoer/sudoers.5.7",
            '6.3'   =>  "puppet:///modules/sudoer/sudoers.6",
            default =>  undef,
        },
		require => Class["sudoer::install"],
	}
}
