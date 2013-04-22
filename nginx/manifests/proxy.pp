define nginx::proxy($port=80, 
                    $upname) {
    $require = Class["nginx::install"]
    include nginx
    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }
    file {
        "/etc/nginx/conf.d/${name}.conf":
        content => template("nginx/proxy.conf.erb");

#        "/etc/nginx/conf.d/upstream.conf":
#        content => template("nginx/upstream.conf.erb");
    }
}
