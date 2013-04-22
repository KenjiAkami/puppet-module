class dena-hadoop::install {
    package { "DeNA_Hadoop":
        name    => [ "php-ComboLog-3rdparty-0.2.0-1", "perl-HTML-Parser", "perl-Compress-Zlib", "perl-URI", "perl-Crypt-SSLeay", "perl-libwww-perl-5.805-1.1.1_1", "mod_fastcgi-2.4.6-2", "perl-FCGI-0.74-1", "mbga_send_sglog_3rdparty-1.1.0-2" ],
        ensure  => installed,
        require => [Class["yumrepo"],],
    }
}
