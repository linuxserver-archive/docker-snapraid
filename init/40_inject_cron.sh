#!/bin/bash

# Inject user supplied cron files
[[ ! -d /config/cron ]] && \
  (echo "No cron jobs found to inject..." && \
	exit 0)

# Delete cron jobs except those supplied with this container
find /etc/cron.d/ -type f -not -name 'snapraid-runner' -delete

# inject user supplied cron files
for f in /config/cron/* ; do
    echo "injecting: $f"
    cp $f /etc/cron.d/
done
