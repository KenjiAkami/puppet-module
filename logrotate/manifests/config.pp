class logrotate::config {
	File {
		owner	=> "root",
		group	=> "root",
		mode	=> "0777",
	}
	file { 
        "/var/data":
		ensure	=> "directory";

        "/var/log/venus":
		ensure	=> "directory";

        "/etc/logrotate.d/venus":
		mode	=> "0644",
		source	=> "puppet:///modules/logrotate/venus";
	}
}
