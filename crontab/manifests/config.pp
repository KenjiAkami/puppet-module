class crontab::config {
	File {
		owner	=> "root",
		group	=> "root",
		mode	=> "0644",
	}
    if $lsbmajdistrelease == 6 {
        file { "/etc/cron.d/dailyjobs":
            ensure	=> present,
            source	=> "puppet:///modules/crontab/dailyjobs",
            require => Class["crontab::install"],
            notify	=> Class["crontab::service"],
        }
    }

    file {  
        "/etc/cron.daily/mlocate.cron":
        ensure  => absent;

        "/etc/cron.daily/0logwatch":
        ensure  => absent;

    }

    cron { "func":
        command => "/etc/init.d/funcd restart",
        user    => "root",
        hour    => "1",
        minute  => "0",
    
    }
}
