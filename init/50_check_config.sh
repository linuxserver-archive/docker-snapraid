#!/bin/bash

if [ ! -f /config/snapraid.conf ]; then
  echo "No config found, copying default..."
  mv /config/snapraid.conf.example /config/snapraid.conf
  chown abc.abc /config/snapraid.conf
fi
