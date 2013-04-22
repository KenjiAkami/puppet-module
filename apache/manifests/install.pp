class apache::install {
    package { "apache":
        name    => [ "httpd", "httpd-devel.x86_64", "mod_ssl", "distcache", "mod_extract_forwarded",],
        ensure  => "installed",
        require => [Class["yumrepo"], Class["php"],],
    }
}
