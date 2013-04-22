class sysctl::config {
	augeas { "sysctl":
		context	=> "/files/etc/sysctl.conf",
		changes => [
			"set net.core.wmem_default  256960",
			"set net.core.wmem_max  256960",
			"set net.core.rmem_default  256960",
			"set net.core.rmem_max  256960",
			"set net.ipv4.tcp_keepalive_time  10",
			"set fs.lease-break-time  15",
			"set fs.file-max  2097152",
			"set net.ipv4.tcp_max_syn_backlog  8192",
			"set net.core.somaxconn  8192",
			"set net.core.netdev_max_backlog  2000",
			"set net.ipv4.tcp_keepalive_intvl  75",
			"set net.ipv4.tcp_keepalive_probes  3",
			"set net.ipv4.tcp_fin_timeout  10",
			"set net.ipv4.tcp_keepalive_time  30",
			"set net.ipv4.tcp_wmem  '32768    524288   4194304'",
			"set net.ipv4.tcp_rmem  '32768    524288   4194304'",
			"set net.ipv4.tcp_synack_retries  2",
			"set vm.swappiness  0",
		],
	}
}
