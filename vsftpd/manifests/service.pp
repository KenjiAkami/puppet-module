class vsftpd::service {
    service { "vsftpd":
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => Class["vsftpd::config"],
    }
}
