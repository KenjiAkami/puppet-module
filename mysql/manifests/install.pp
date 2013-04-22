class mysql::install {
    package { "mysql-server":
        name    => [ "MySQL-server-community.x86_64", "MySQL-client-community.x86_64", "MySQL-devel-community.x86_64", "MySQL-shared-compat.x86_64", "maatkit",],
        ensure  => installed,
        require => [File["/etc/my.cnf"],Class["yumrepo"],],
    }
}
