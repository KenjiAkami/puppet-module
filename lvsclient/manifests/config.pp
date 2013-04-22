class lvsclient::config {
    define setlvs ($lvsip="", $bondnum="", $up="") {
        $num = inline_template('<%= lvsip.split(".")[3] %>')
        if $lvsip != "" and $bondnum != "" {
            augeas { "lvssysctl-$title":
                context	=> "/files/etc/sysctl.conf",
                changes => [
                    "set net.ipv4.conf.default.arp_ignore 1",
                    "set net.ipv4.conf.default.arp_announce 2",
                    "set net.ipv4.conf.bond${bondnum}.arp_ignore 1",
                    "set net.ipv4.conf.bond${bondnum}.arp_announce 2",
                    "set net.ipv4.conf.lo.arp_ignore 1",
                    "set net.ipv4.conf.lo.arp_announce 2",
                ];
            }

            augeas { "lvsifcfg-$title":
                context => "/files/etc/sysconfig/network-scripts/ifcfg-lo:$num",
                changes => [
                    "set DEVICE lo:$num",
                    "set IPADDR $lvsip",
                    "set NETMASK 255.255.255.255",
                    "set ONBOOT yes",
                    "set NAME loopback",
                ];
            }
        }
        if $up {
            exec {"/sbin/ifup lo:$num":
                command => "/sbin/ifup lo:$num",
                unless  => "/sbin/ifconfig | grep lo:$num",
            }
        }
    }
}
