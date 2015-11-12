#!/bin/bash

#Check for /config/cron presence
if [ ! -d /config/cron ] ; then
	echo "You can create a folder called cron inside /config and add cron.d files to be loaded on boot."
	exit 0
fi
shopt -s nullglob
#Delete any except dockersupplied
find /etc/cron.d/ -type f -not -name 'plexwatch' -delete


#inject any present files.
for f in /config/cron/* ; do
    echo "injecting: $f"
    cp $f /etc/cron.d/
done
