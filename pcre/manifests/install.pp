class pcre::install {
    package { "pcre":
        name    => [ "pcre", "pcre-devel",],
        ensure  => "installed",
        require => Class["yumrepo"],
    }
}
