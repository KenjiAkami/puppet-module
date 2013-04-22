class imagemagick::config {
    $require = Class["imagemagick::install"]
    File {
		owner => "root",
		group => "root",
		mode => "0644",
    }

	file { 
        "/etc/php.d/imagick.ini":
		content => "extension=imagick.so";
#		notify => Class["apache::service"];
	}
}


