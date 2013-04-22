class ssh::config {
    if $presrv != "" {
        file { "/root/.ssh":
                mode    => "0700",
                ensure => "directory";
        }

        ssh_authorized_key{ $presrv: 
            key => $presrv ? {
                pre03 => "AAAAB3NzaC1yc2EAAAABIwAAAQEAvJP9VCJTByNa4/8IeT49w+enWD7B9XslXyz/rrHThMjsc7UMPqGHxdwy5i49ovIvLmQ38Ea+MZrCCivScDYqxcb0OAEVf2xoGteOZb0fWUEzhJAoMt3XFRH8vXW1/MByAr8+MsGhPbrnpsEa6RLh1ewNx47K6q9Qb58TOtuMtx5SXAtMy8wt3R1tBv9grwcxfiB/+t97vEfVtKqOGVOFlltiRSL0Y24NsKTNcm11K78+mvvtJMZIV0GCTOn1TKPOG1jCfKfu7jZKQaFjjByY43VqZ2LYzZE0S+Qr7yKXsE0IrsHoLD/DBXi/B3+ADyJcRzQmmU5SAcE5xUwUTxBB7Q==",
                pre04 => "AAAAB3NzaC1yc2EAAAABIwAAAQEAvJP9VCJTByNa4/8IeT49w+enWD7B9XslXyz/rrHThMjsc7UMPqGHxdwy5i49ovIvLmQ38Ea+MZrCCivScDYqxcb0OAEVf2xoGteOZb0fWUEzhJAoMt3XFRH8vXW1/MByAr8+MsGhPbrnpsEa6RLh1ewNx47K6q9Qb58TOtuMtx5SXAtMy8wt3R1tBv9grwcxfiB/+t97vEfVtKqOGVOFlltiRSL0Y24NsKTNcm11K78+mvvtJMZIV0GCTOn1TKPOG1jCfKfu7jZKQaFjjByY43VqZ2LYzZE0S+Qr7yKXsE0IrsHoLD/DBXi/B3+ADyJcRzQmmU5SAcE5xUwUTxBB7Q==",
                pre05 => "AAAAB3NzaC1yc2EAAAABIwAAAQEAl2AR80VcXsjbTKMNBddq05jd7MFCj3a6RrWUQQc6AF6n/enFYh5vMEv4HCE0aLy1Vmp6ZDKVzJ0Dt21u8TnKMOt7ugrLhdzbv466K2xUfDLRPMKug/JYQOhuH+ZhyWvhEeeU+9bqPdQ9vTUgDFjGrH+f/D9w3SdPFTKK4WBP7BFfrp5az2FhU8EgiHgIvuXdX5VDO9kJRcO+9/BFfIL/w51/MPSK4qXAeI4lV5tgmD8coA3Jbe3vNQl8Xw8r+ERhcnV5Xi0krE14QHed8yxfVN9OQukNtvpIMZ4XU0a8FTtY2ZSG5EkT7CYPVmlLXJmS6GFxIflsXjC1HrDLDMMc3w==",
                pre06 => "AAAAB3NzaC1yc2EAAAABIwAAAQEA4BlplCk8o6Qr05/tygik2DsH1QXHM6nblfIX18iNAKqPkrhNWpUYAzy0Z6buEuog/l1dM+UA4f6iXYkzbUq48pO7CHjluGGVtzvbTggUixGrU8flufpK4lOZUGsRjcSy0bvw+6wl6qP/g0+qHmPk/ZI8LQqtwj6XJDIB86a36/eLpVa1ax0qtXvUvtvQl/YLGFZnK+N/okEmu489/ZfSo9dV2686+FFTnKuGQfJbYGcmc+JXmYMPOWWr8Du3n8u5UnGEwluoRXW7lTRI6y6HwTmAUQ8QggNIVAB4yXdrSvdBmtLwtc3YBIPr54JvNU5BWaJaDbutBO2l4z1Sx4BJqw==",
                pre07 => "AAAAB3NzaC1yc2EAAAABIwAAAQEA0Pyyz0gajlx24cYCFHiiLkHF+0SXwY585ifO00nPEXlcjWFBURpQ+Dl1gZ5bk+C0wysDS8ZXKIUs5VLYSZryNfWwpHzugBxXHhJcM6+oxoGpPHW24k28bhQTv+ay4Tx6w0Tu0wRSgB9FrYJkmkyZlTi6lMVZW3/HKkbaaCOwD53wkjIroYEZbRfG9DEZyV+mbmleoJLR5VXAVpFiCmCn1VjJjccjpezcMkMj2hkq612KMEuswjk9GZiWKrrHk8eGMzh7c4W4P4pd6HcPg8cPll3Fhbxl89ryEko7saxq+eF2FcgObNezdUQYkDhWGFRv/wgAa+5d6psoN7jvvyirjw==",
            default => undef },
            user => "root",
            ensure => present, 
            type => "ssh-rsa", 
            name => "root@social$presrv",
        } 

        augeas { "sshd_config":
            context => "/files/etc/ssh/sshd_config",
            changes => [
                "set PermitEmptyPasswords no",
                "set PermitRootLogin yes",
                "set AllowUsers/1 wdsliusr",
                "set AllowUsers/2 sysadmin",
                "set AllowUsers/3 root",
            ],
            notify => Class["ssh::service"],
        }
    }
    else {
        augeas { "sshd_config":
            context => "/files/etc/ssh/sshd_config",
            changes => [
                "set PermitEmptyPasswords no",
                "set PermitRootLogin no",
                "set AllowUsers/1 wdsliusr",
                "set AllowUsers/2 sysadmin",
            ],
            notify => Class["ssh::service"],
        }
    }
}
