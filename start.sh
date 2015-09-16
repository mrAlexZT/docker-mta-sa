#!/bin/bash
/usr/bin/screen -a -d -m -S mta-server /root/data/mta-server &

sleep 2

PID=$(pidof mta-server)

echo $PID

while [[ ( -d /proc/$PID ) && ( -z `grep zombie /proc/$PID/status` ) ]]; do
    sleep 1
done
