class mcollective::install {
    $require = Class["yumrepo"]
	package { "mcollective":
#		name   => ["mcollective-common", "mcollective-client", "rubygem-stomp", "mcollective"],
		name   => ["rubygem-stomp", "mcollective", "mcollective-common",],
		ensure => installed;
   }
}
