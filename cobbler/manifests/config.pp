class cobbler::config {
	file { "cobbler":
		ensure		=> directory,
		recurse		=> true,
		path		=> "/etc/cobbler",
		source		=> "puppet:///modules/cobbler/cobbler",
		owner		=> "root",
		group		=> "root",
		require 	=> Class["cobbler::install"],
		notify		=> Class["cobbler::service"],
	}
}
