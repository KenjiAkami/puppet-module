class zabbix::install {
#	user {"zabbix":
#		ensure		=> present,
#		home		=> "/var/lib/zabbix",
#		shell		=> "/sbin/nologin",
#	}

	package { "zabbix":
		name    => [ "zabbix-agent", ],
		ensure  => "installed",
#		require => User["zabbix"],
		require => Class["yumrepo"],
		notify  => Class["zabbix::config"],
	}

}
