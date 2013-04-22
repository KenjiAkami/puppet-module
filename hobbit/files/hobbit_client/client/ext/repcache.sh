#!/bin/sh

RESULT=`sudo /usr/sbin/lsof -i:11212|grep ESTABLISHED|wc -l`
CMD=`sudo /usr/sbin/lsof -i:11212`
BBCL="green"

if [ $RESULT -ne 1 ]; then
    BBCL="yellow"
fi

echo "replication of memcache : $CMD" > /tmp/repcache.txt

$BB $BBDISP "status $MACHINE.repcache $BBCL `date`
`cat /tmp/repcache.txt`
NOTES: If status is ESTABLISHED, it synchronizes.
"

exit 0
