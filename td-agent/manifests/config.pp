define td-agent::config($srvlist=[],
                        $template='td-agent/td-agent.conf.erb', ){
    include td-agent
    $_filename = inline_template('<%= name.split(".")[0] %>') 

    File {
        ensure  => "present",
        owner   => "root",
        group   => "root",
        mode    => "0644",
    }

    file {
        "/etc/td-agent/conf.d/":
        require => Class["td-agent::install"],
        ensure => "directory";

        "/etc/td-agent/td-agent.conf":
        require => Class["td-agent::install"],
        notify => Class["td-agent::service"],
        content => template($template);

        "/etc/td-agent/conf.d/${_filename}.conf":
        require => File["/etc/td-agent/conf.d"],
        notify => Class["td-agent::service"],
        content => template("td-agent/contents.conf.erb");
    }
    
    cron { "td-agent":
        command => "for i in `ls /var/log/httpd/*access_log.link|sed s/.link//`;do test -L \$i.link && ln -f -s \$i.$(date +\%Y\%m\%d) \$i.link;done",
        user    => "root",
        hour    => "0",
        minute  => "0",
    }
}
