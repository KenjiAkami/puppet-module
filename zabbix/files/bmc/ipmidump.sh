#!/bin/bash
IP_FILE="/etc/zabbix/bmc/bmc_ip"
PW="calvin"

RET=0
if [ ! -f ${IP_FILE} ]; then
  /etc/zabbix/bmc/get_bmc_ip.sh
  RET=$?
fi
if [ ${RET} -ne 0 ]; then
  exit 1
fi

BMC_IP=`cat /etc/zabbix/bmc/bmc_ip`
/usr/bin/ipmitool -H ${BMC_IP} -U root -P ${PW} sdr type Current > /etc/zabbix/bmc/server.dump.running
cp -p /etc/zabbix/bmc/server.dump.running /etc/zabbix/bmc/server.dump
