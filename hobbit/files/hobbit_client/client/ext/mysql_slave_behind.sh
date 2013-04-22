#!/bin/sh
export LANG=C

THRESHOLD=60
MYSQL='/usr/bin/mysql -h127.0.0.1 -ucroozdbman -pD7hebhgy'
SB=`$MYSQL -e 'show slave status\G' | grep Seconds_Behind_Master | awk '{print $2}'`

if [ -z "$SB" ]; then
  MSG="Can't get slave status"
  BBCL="yellow"
else
  MSG="Seconds_Behind_Master : $SB"
  BBCL="green"

  if [ "$SB" = "NULL" ]; then
    BBCL="red"
  elif [ "$SB" -gt 10 -a "$SB" -lt "$THRESHOLD" ]; then
    BBCL="yellow"
  elif [ "$SB" -ge "$THRESHOLD" ]; then
    BBCL="red"
  fi
fi

$BB $BBDISP "status $MACHINE.mysql_slave_behind $BBCL `date`
$MSG
NOTES: yellow threshold is 10, red threshold is $THRESHOLD.
"

exit 0
