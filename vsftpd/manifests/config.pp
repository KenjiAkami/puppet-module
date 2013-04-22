class vsftpd::config {
    File {
        owner   => "root",
        group   => "root",
        mode    => "0600",
        ensure  => present,
    }

    file {  
        "/etc/vsftpd/user_list":
        source  => "puppet:///modules/vsftpd/user_list",
        notify => Class["vsftpd::service"];

        "/etc/vsftpd/vsftpd.conf":
        source  => "puppet:///modules/vsftpd/vsftpd.conf",
        notify => Class["vsftpd::service"];
    }
}
