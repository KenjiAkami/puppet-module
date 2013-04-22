define apache::vhost( $port=80, 
                      $docroot, 
                      $template='apache/virtualhost.conf.erb', 
                      $ver='',
                      $serveraliases = '' ) {
    include apache

    if $ver != '' {
        $_ver = "_v${ver}"
    }    

    file {"/etc/httpd/conf.d/virtualhost_${name}${_ver}.conf":
            content => template($template),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            require => Class["apache::install"],
    }
}
