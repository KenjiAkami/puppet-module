#!/bin/bash
IP_FILE=/etc/zabbix/bmc/bmc_ip

/opt/dell/srvadmin/bin/omreport chassis bmc config=nic|grep "IP Address" | grep -v Source | awk -F':' '{print $2}' > ${IP_FILE}
if [ $? -ne 0 ]; then
  rm -rf ${IP_FILE}
  exit 0
fi
