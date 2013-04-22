class keepalived::config {
    define conf ($service_name = []){
    	$require = Class["keepalived::install"]
    
    	File {
            ensure	=> present,
            owner	=> "root",
            group	=> "root",
    	}
    
        file {
            "/etc/keepalived/keepalived.conf":
            mode    => "0600",
            content => template("keepalived/keepalived.conf.erb");
        }
    }
}
