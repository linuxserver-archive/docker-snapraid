FROM linuxserver/baseimage
MAINTAINER LinuxServer.io <ironicbadger@linuxserver.io>

ENV APTLIST="snapraid"

# add repository
RUN add-apt-repository ppa:tikhonov/snapraid

# install packages
RUN apt-get update -q && \
apt-get install $APTLIST -y && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD cron/ /etc/cron.d/
ADD defaults/ /defaults/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

VOLUME /mnt /config
