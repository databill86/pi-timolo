#!/bin/bash
# This script will run the webserver.py as a background task
# You will then be able close the terminal session.  To auto start
# Add the following command to the /etc/rc.local
# /home/pi/pi-timolo/webserver.sh start

progpath="/home/pi/pi-timolo"
progname="webserver.py"

echo "$0 ver 1.1 written by Claude Pageau"
echo "-----------------------------------------------"
cd $progpath

# Check if progname exists
if [ ! -e $progname ] ; then
  echo "ERROR - Could Not Find $progname"
  exit 1
fi

if [ -z "$( pgrep -f $progname )" ]; then
  if [ "$1" = "start" ]; then
     echo "Start $progname in Background ..."
     ./$progname >/dev/null 2>&1 &
  fi
else
  if [ "$1" = "stop" ]; then
    echo "Stopping $progname ...."
    progPID=$( pgrep -f $progname )
    sudo kill $progPID
  fi
fi

if [ -z "$( pgrep -f $progname )" ]; then
    echo "$progname is Not Running ..."
    echo "To Start $progname execute command below"
    echo "$0 start"
  else
    progPID=$(pgrep -f $progname)
    echo "$progname is Running ..."
    echo "PID is $progPID"
    echo "To Stop $progname execute command below"
    echo "$0 stop"
fi
echo "Bye"
