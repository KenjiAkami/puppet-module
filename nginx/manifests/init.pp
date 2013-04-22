class nginx {
	include  nginx::install, nginx::config
}

### Example
#    include nginx
#    nginx::proxy {'mguildbattle.croozsocial.jp': srvname => 'mguildbattle', srvlist => ["192.168.0.1", "192.168.0.2"]}
