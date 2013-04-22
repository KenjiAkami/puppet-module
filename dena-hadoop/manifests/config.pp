#define dena-hadoop::config($srvlist=[],
#                        $template='dena-hadoop', ){
class dena-hadoop::config($srvlist=[] ){
    File {
        ensure  => "present",
        owner   => "root",
        group   => "root",
        mode    => "0655",
    }

    file {
        "/usr/dena/mbga_send_log/conf/GameConf.pm":
        source => "puppet:///modules/dena-hadoop/GameConf.pm";
    }

    file {
        "/etc/init.d/game_hadoop_log":
        source => "puppet:///modules/dena-hadoop/game_hadoop_log";
    }

#    file {
#        "/etc/init.d/game_hadoop_log":
#        target => "/usr/dena/mbga_send_log/libexec/game_hadoop_log";
#    }
}
