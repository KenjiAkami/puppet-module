#!/bin/sh
#update 2012/01/06

PATH=/bin:/usr/bin:/opt/dell/srvadmin/bin:/home/hobbit/bin
export PATH
export LANG=C

BBCL="green"
TYPE=`sudo /usr/sbin/dmidecode|grep "Product Name"`
VENDOR=`sudo /usr/sbin/dmidecode|grep Vendor |awk '{print $2}'`


if [ $VENDOR = "HP" ] ;then
  STATUS=`sudo /usr/sbin/hpacucli ctrl all show config`
  ret=$?
  if [ $ret -ne 0 ];then
    STATUS='command fail'
    BBCL="red"
  else
    ERRORNUM=`sudo /usr/sbin/hpacucli ctrl all show config | egrep 'physicaldrive|logicaldrive' | grep -v OK | wc -l`
    if [ $ERRORNUM -ne 0 ];then
      BBCL="red"
    fi
  fi

elif [ $VENDOR = "Dell" ] ;then
  STATUS=`sudo omreport storage pdisk controller=0`
  ret=$?
  if [ $ret -ne 0 ];then
    STATUS='command fail. please perform /etc/init.d/srvadmin start.'
    BBCL="red"
  else
    ERRORNUM=`sudo omreport storage pdisk controller=0 | egrep ^Status | grep -v Ok |wc -l`
    if [ $ERRORNUM -ne 0 ];then
      BBCL="red"
    fi
  fi

else
   BBCL="yellow"
fi

$BB $BBDISP "status $MACHINE.raidchk $BBCL `date`
$TYPE
$STATUS"

exit 0
