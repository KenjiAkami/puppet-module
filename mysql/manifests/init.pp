class mysql {
	include mysql::install
}

class mysql::client {
#    package { 'mysql':
#        ensure => absent,
#    }
    package { "mysql-client":
        name    => ["MySQL-client-community", "MySQL-devel-community", "perl-DBD-MySQL", "perl-DBI",],
        ensure  => installed,
        require => [Class["yumrepo"],]
    }
}
