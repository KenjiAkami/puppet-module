class cachenameserver::config {
    File {
		ensure => present,
		owner => "root",
		group => "root",
		mode => "0644",
    }
    $dnsserverlist = [ '158.205.229.244', '158.205.237.131']
	file {  
        "/etc/named.conf":
        content => template("cachenameserver/named.conf.erb"),
		require => Class["cachenameserver::install"],
		notify => Class["cachenameserver::service"];

#        "/etc/resolv.conf":
#        content => template("cachenameserver/resolv.conf.erb");
	}
}
