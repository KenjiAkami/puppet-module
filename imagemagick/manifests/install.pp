class imagemagick::install {
	package { "imagemagick":
		name    => ["ImageMagick", "ImageMagick-devel",],
		ensure  => installed,
        require => Class["yumrepo"],
	}
    pecl::php::pecl_package {"imagick-2.2.2": 
        require => Package["imagemagick"],
    }
}
