class mcollective::service {
    service { "mcollective":
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => Class["mcollective::config"],
    }
}
