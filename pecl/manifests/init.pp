class pecl {
	define php::pecl_package() {
	  exec { "pecl-install-${name}":
	    command => "/usr/bin/pecl install $name",
	    require => Class['php'],
	    unless => "/usr/bin/pecl shell-test $name"
	  }
	}
}
