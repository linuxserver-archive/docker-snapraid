#!/bin/bash

# Delete cron jobs except those supplied with this container
find /etc/cron.d/ -type f -not -name 'snapraid-runner' -delete

# Inject user supplied cron files
[[ -d /config/cron ]] && \
  (for f in /config/cron/* ; do
      echo "injecting: $f"
      cp $f /etc/cron.d/
  done)
