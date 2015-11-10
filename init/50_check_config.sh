#!/bin/bash
# Ensures that configuration files for both SnapRAID and snapraid-runner are present
# in /config. In reality, both files should be edited manually before running this
# container to ensure correct operation.

# test for /etc/snapraid.conf being a file and not a link, delete if file.
[[ ! -L /etc/snapraid.conf && -f /etc/snapraid.conf ]] && rm /etc/snapraid.conf

# test if snapraid.conf is in /config, copy from /defaults/snapraid.conf.example if not.
[[ ! -f /config/snapraid.conf ]] && \
  (cp /defaults/snapraid.conf.example /config/snapraid.conf && \
  echo "No config found, copying default...")

[[ ! -f /config/snapraid-runner.conf ]] && \
  (cp /defaults/snapraid-runner.conf.example /config/snapraid-runner.conf) && \
  echo "Runner config not found, copying default - please edit"

# test if link is made between /etc/snapraid.conf and /config/snapraid.conf, make if not
[[ ! -L /etc/snapraid.conf ]] && ln -s /config/snapraid.conf /etc/snapraid.conf

# chown local copies of /config/*.conf and /app
chown -R abc:abc /app /config
