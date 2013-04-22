class account::install {
    define add_user ( $uid="", $password, $shell="/bin/bash", $sshkeytype="ssh-rsa", $sshkey="") {
        $homedir = '/home'
        $username = $title
        user { $username:
            home    => "$homedir/$username",
            shell   => "$shell",
            uid     => $uid,
            gid => $uid,
            managehome => 'true',
            password  => "$password",
            groups => $title
        }
        
        group { $username:
            gid => "$uid"
        }
        
        if $sshkey != "" {
            ssh_authorized_key{ $username: 
                user => "$username",
                ensure => present, 
                type => "$sshkeytype", 
                key => "$sshkey", 
                name => "$username" 
            } 
       }
    }
}
