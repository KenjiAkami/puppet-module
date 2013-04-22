# Define : keepalived::virtual_server
#
# Define a virtual server. 
#
# Parameters :
#        state : MASTER or BACKUP
#        virtual_router_id
#        virtual_ipaddress
#        virtual_server_port
#        lb_kind = 'DR' : Support only DR in this version
#	 lb_algo = 'wlc
#        interface = 'bond1'
#        priority = '' : If not set, BACKUP will take 100 and MASTER 200

define keepalived::virtual_server ( 
	$virtual_ipaddress,
	$virtual_server_port,
	$lb_kind = 'DR',
	$lb_algo = 'wlc',
	$interface = 'bond1', ) {

	#Construct /etc/keepalived/keepalived.conf
        file { 
            "/etc/keepalived/${name}_vrrp_lvs.inc":
            content => template("keepalived/vrrp.erb"),
            mode => 0644, owner => root, group => 0,
            before => Class["keepalived::config"];
        }

}
