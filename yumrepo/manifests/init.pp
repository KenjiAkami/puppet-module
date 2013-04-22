class yumrepo {
	File {
		owner   => "root",
		group   => "root",
		mode    => "0644",
	}

	file {
		"/etc/yum.repos.d/centos5.x-local.repo":
		source  => "puppet:///modules/yumrepo/centos5.x-local.repo";

		"/etc/yum.repos.d/crooz.repo":
		source  => "puppet:///modules/yumrepo/crooz.repo";

		"/etc/yum.repos.d/puppetlabs.repo":
		source  => "puppet:///modules/yumrepo/puppetlabs.repo";

		"/etc/yum.repos.d/epel.repo":
		source  => "puppet:///modules/yumrepo/epel.repo";

        "/etc/yum.repos.d/CentOS-Base.repo":
        ensure  => absent;

        "/etc/yum.repos.d/CentOS-Media.repo":
        ensure  => absent;
	}
}
