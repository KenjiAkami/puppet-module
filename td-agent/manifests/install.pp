class td-agent::install {
    package { "td-agent":
        name    => [ "td-agent" ],
        ensure  => installed,
        require => [Class["yumrepo"],],
    }
}
