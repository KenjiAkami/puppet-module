class pear(
    $package = $pear::params::package
) inherits pear::params {

 # Install the PEAR package.
    package { $package:
        ensure  => installed,
        require =>  Exec["Console_Getopt"],
    }

    exec { "Console_Getopt":
        command => "/usr/bin/pear upgrade --force  Console_Getopt",
        unless  => "/usr/bin/pear list|grep Console_Getopt|grep 1.3.1 >/dev/null"
    }
}
