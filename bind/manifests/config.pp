define bind::config ($masterip="",
                     $slaveip=[],){
    include bind
    File {
		ensure => present,
		owner => "named",
		group => "named",
		mode => "0640",
    }
	file {  
        "/var/named/chroot/etc/named.conf":
        content => template("bind/named.conf.erb"),
		require => Class["bind::install"],
		notify => Class["bind::service"];

        "/var/named/chroot/var/named/named.ca":
        source  => "puppet:///modules/bind/named.ca";

        "/etc//sysconfig/named":
        source  => "puppet:///modules/bind/named.sysconfig",
		notify => Class["bind::service"];
	}
}
