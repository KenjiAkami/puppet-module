#!/bin/sh

export LANG=C
PQ=`/usr/sbin/postqueue -p | tail -1 |awk '{if($5 != "")print $5;else print "0"}'`

BBCL="green"

if [ $PQ -gt 50 -a $PQ -lt 500 ]; then
        BBCL="yellow"
elif [ $PQ -ge 500 ]; then
        BBCL="red"
fi

echo "postqueue : $PQ" > /tmp/postqueue.txt

$BB $BBDISP "status $MACHINE.postqueue $BBCL `date`
`cat /tmp/postqueue.txt`
"

exit 0

