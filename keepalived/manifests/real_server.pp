# Define : keepalived::real_server
#
# Define a real server. 
#
# Parameters :
#        real_ip
#        port
#        virtual_server_name : name of the related keepalived::virtual_server
#        weight = '10',
#        check_type : MISC_CHECK , TCP_CHECK or HTTP_GET - if not set, the check is a TCP_CHECK on the port
#                check_connect_timeout = '1',
#                check_nb_get_retry = '2',
#                check_delay_before_retry = '2',
#                check_misc_path = '', #for MISC_CHECK
#                check_connect_port = '', #for TCP_CHECK and HTTP_GET
#                check_url_path = '', #for HTTP_GET
#                check_url_digest = '' #for HTTP_GET
define keepalived::real_server (
	$real_ip,
	$port,
	$virtual_server_name = $name,
    $virtual_server_ip = [],
	$weight = '10',
	$check_type = 'TCP_CHECK', 
		$check_connect_timeout = '1',
		$check_nb_get_retry = '2',
		$check_delay_before_retry = '2',
		$check_misc_path = '', 
		$check_connect_port = '', 
		$check_url_path = '', 
		$check_url_digest = '' 
	) {
	
	if $check_type == 'TCP_CHECK' {
		$real_check_connect_port = $check_connect_port ? {
			'' => $port,
			default => $check_connect_port,
		}
	}

	file{"/etc/keepalived/${virtual_server_name}.inc":
		ensure => present,
		content => template("keepalived/real_server.erb"),
        mode => 0644, owner => root, group => 0,
		before => Class["keepalived::config"],
	}
}
