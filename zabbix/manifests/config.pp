class zabbix::config {
	$require = Class["zabbix::install"]

	File {
		owner		=> "root",
		group		=> "root",
		mode		=> "0644",
	}

	file { 
		"/etc/zabbix/zabbix_agentd.conf":
		content		=> template("zabbix/zabbix_agentd.conf.erb"),
		notify		=> Class["zabbix::service"];

		"/etc/zabbix/zabbix_agentd.d":
        recurse     => "true",
		source		=> "puppet:///modules/zabbix/zabbix_agentd.d",
		notify		=> Class["zabbix::service"];

		"/etc/zabbix/helper":
        recurse     => "true",
        owner       => "zabbix",
        group       => "zabbix",
		source		=> "puppet:///modules/zabbix/helper",
		notify		=> Class["zabbix::service"];

		"/etc/zabbix/bmc":
        recurse     => "true",
        owner       => "zabbix",
        group       => "zabbix",
		source		=> "puppet:///modules/zabbix/bmc",
		notify		=> Class["zabbix::service"];

        "/etc/zabbix/zabbix_agent.conf":
        ensure      => absent;

        "/etc/zabbix/zabbix_agentd.d/userparameter_examples.conf":
        ensure      => absent;

        "/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf":
        ensure      => absent;
	}
}
