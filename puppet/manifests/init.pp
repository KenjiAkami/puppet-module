class puppet {
#        include puppet::install, puppet::config, puppet::service
        include puppet::config, puppet::service
}
