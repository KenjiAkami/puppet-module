#!/bin/sh
export LANG=C
export PATH=/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/opt/dell/srvadmin/bin:/home/hobbit/bin:$PATH

BBCL="green"
SB=`redis-cli info | grep master_link_status | cut -c 20-21`

if [ -z "$SB" ]; then
  MSG="Can't get slave status"
  BBCL="yellow"
else
  if [ "$SB" = "up" ]; then
    MSG="master_link_status : up"
    BBCL="green"
  else
    MSG="master_link_status : down"
    BBCL="red"
  fi
fi

$BB $BBDISP "status $MACHINE.redis $BBCL `date`
$MSG
"

exit 0

