class mysql::config ($masterip=""){

    File{
        ensure => present,
        owner  => "root",
        group  => "root",
        mode   => "0644",
    }
	file {
        "/etc/my.cnf":
		content => template("mysql/my.cnf.erb");
#		notify  => Class["mysql::service"];

        "/var/log/mysqld.slow.log":
        owner   => "mysql",
        group   => "mysql",
        mode    => "0666",
        require => Class["mysql::install"];

        "/etc/logrotate.d/mysql":
        source  => "puppet:///modules/mysql/mysql.logrotate";

        "/crooz":
        mode   => "0777",
        ensure  => "directory";
	}
}
