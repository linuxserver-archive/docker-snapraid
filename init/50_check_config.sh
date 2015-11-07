#!/bin/bash

# test for /etc/snapraid.conf being a file and not a link, delete if file.
[[ ! -L /etc/snapraid.conf && -f /etc/snapraid.conf ]] && rm /etc/snapraid.conf

# test if snapraid.conf is in /config, copy from /defaults/snapraid.conf.example if not.
[[ ! -f /config/snapraid.conf ]] && (cp /defaults/snapraid.conf.example /config/snapraid.conf && echo "No config found, copying default...")

# test if link is made between /etc/snapraid.conf and /config/snapraid.conf, make if not
[[ ! -L /etc/snapraid.conf ]] && ln -s /config/snapraid.conf /etc/snapraid.conf

# chown local copy of /config/snapraid.conf
chown abc:abc /config/snapraid.conf
