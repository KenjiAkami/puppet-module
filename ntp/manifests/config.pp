class ntp::config {
    $require = Class["ntp::install"]
    File {
		owner => "root",
		group => "root",
		mode => "0644",
    }

	file { 
        "/etc/ntp.conf":
		source => "puppet:///modules/ntp/ntp.conf",
		notify => Class["ntp::service"];

#        "/etc/ntp/step-tickers":
#		source => "puppet:///modules/ntp/step-tickers";
#		notify => Class["ntp::service"];
	}
}


