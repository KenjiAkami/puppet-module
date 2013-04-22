define nginx::upstream ($srvinfo = {}) {
    $require = Class["nginx::install"]
    include nginx
    file {
        "/etc/nginx/conf.d/upstream.conf":
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("nginx/upstream.conf.erb");
    }
}
