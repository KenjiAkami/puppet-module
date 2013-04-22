class limits::config {
    $require = Class["pam"]
    define conf (
      $domain = "*",
      $type = "soft",
      $item = "nofile",
      $value = "4096"
      ) {
        $key = "$domain/$type/$item"
        $context = "/files/etc/security/limits.conf"
  
        $path_list  = "domain[.=\"$domain\"][./type=\"$type\" and ./item=\"$item\"]"
        $path_exact = "domain[.=\"$domain\"][./type=\"$type\" and ./item=\"$item\" and ./value=\"$value\"]"
  
        augeas { "limits_conf/$key":
            context => "$context",
            onlyif  => "match $path_exact size != 1",
            changes => [
              "rm $path_list", 
              "set domain[last()+1] $domain",
              "set domain[last()]/type $type",
              "set domain[last()]/item $item",
              "set domain[last()]/value $value",
            ],
        }
    } 
}
