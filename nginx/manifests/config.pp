class nginx::config {
	$require = Class["nginx::install"]

	File {
		ensure	=> present,
		owner	=> "root",
		group	=> "root",
		mode	=> "0644",
	}
	file { 
		"/etc/nginx/nginx.conf":
		source => "puppet:///modules/nginx/nginx.conf";

		"/etc/nginx/mime.types":
		source	=> "puppet:///modules/nginx/mime.types";

        "/etc/logrotate.d/nginx":
        source  => "puppet:///modules/nginx/nginx.logrotate.d";

		"/usr/share/nginx/html/_proxycheck":
		source	=> "puppet:///modules/nginx/conf.d/_proxycheck",
        recurse => "true",
        ensure  => "directory";

		"/usr/share/nginx/html/_proxyerror":
		source	=> "puppet:///modules/nginx/conf.d/_proxyerror",
        recurse => "true",
        ensure  => "directory";

		"/etc/nginx/conf.d/default.conf":
		source => "puppet:///modules/nginx/conf.d/default.conf";

       "/etc/nginx/fastcgi_params":
        ensure  => absent;

        "/etc/nginx/koi-utf":
        ensure  => absent;

        "/etc/nginx/koi-win":
        ensure  => absent;

        "/etc/nginx/scgi_params":
        ensure  => absent;

        "/etc/nginx/uwsgi_params":
        ensure  => absent;

        "/etc/nginx/win-utf":
        ensure  => absent;

        "/etc/nginx/conf.d/example_ssl.conf":
        ensure  => absent;
	}
}
