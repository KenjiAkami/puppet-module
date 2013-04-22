#!/bin/bash
DUMP_FILE=/etc/zabbix/bmc/server.dump

if [ $# -eq 0 ]; then
  echo 0
  exit 0
fi

LINE=`cat ${DUMP_FILE} | grep "$*" | wc -l`
if [ ${LINE} -eq 0 ]; then
  exit 0
fi
VALUES=`cat ${DUMP_FILE} | grep "$*"`

VAL=`echo ${VALUES} | awk -F'|' '{print $5}' | awk '{print $1}'`
if [ ${VAL} == "Disabled" ]; then
  VAL=0
fi
echo ${VAL}
exit 0
