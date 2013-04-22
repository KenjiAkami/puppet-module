class crontab::install {
    if $lsbmajdistrelease == 6 {
        package { "cronie-noanacron":
            ensure => present,
        }

        package { "cronie-anacron":
            ensure => absent,
        }
    }
}
