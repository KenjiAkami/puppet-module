class bashrc::config {
	File {
		owner	=> "root",
		group	=> "root",
		mode	=> "0644",
	}

	file {  
		"/etc/bashrc":
		ensure	=> present,
		source	=> "puppet:///modules/bashrc/bashrc";

        "/etc/DIR_COLORS.256dark":
        ensure  => present,
        source  => "puppet:///modules/bashrc/dircolors.256dark";
	}
}
