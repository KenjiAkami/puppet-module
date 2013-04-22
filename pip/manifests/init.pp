class pip {
    package { "psutil":
        ensure  => "latest",
        provider => pip,
    }
}
