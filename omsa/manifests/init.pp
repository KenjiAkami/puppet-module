class omsa {
   $omsaURL = "http://linux.dell.com/repo/hardware/latest/bootstrap.cgi"
   if $manufacturer =~ /Dell/ {
      exec { "install-OpenManage":
         command => "wget -q -O - ${omsaURL} | bash",
         path    => "/bin:/usr/bin:/usr/sbin:/sbin",
         unless  => "test -e /etc/yum.repos.d/dell-omsa-repository.repo",
         before  => Package[["srvadmin-base"],["srvadmin-storageservices"], ["srvadmin-all"]]
      }
      package { "srvadmin-all": }
      package { "srvadmin-storageservices": }
      package { "srvadmin-base": }
      service {
         "ipmi":
            hasstatus  => "true",
            ensure     => "true",
            enable     => "true";
         "srvadmin-services.sh":
            provider   => "init",
            path       => "/opt/dell/srvadmin/sbin",
            ensure     => "true",
            hasrestart => "true",
            hasstatus  => "true",
            require    => [ Package["srvadmin-all"],
                            Package["srvadmin-base"],
                            Package["srvadmin-storageservices"],
                            Service["ipmi"] ],
      }
   }
}
