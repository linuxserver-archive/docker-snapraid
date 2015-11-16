#!/bin/bash

# Delete cron jobs except those supplied with this container
find /etc/cron.d/ -type f -not -name 'snapraid-runner' -delete

# Inject user supplied cron files
if [[ -d /config/cron ]] ; then
  for f in /config/cron/* ; do
    echo 'injecting cron file: "$f"'
    cp $f /etc/cron.d/
  done
fi
