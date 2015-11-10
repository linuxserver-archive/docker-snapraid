FROM linuxserver/baseimage
MAINTAINER LinuxServer.io <ironicbadger@linuxserver.io>

ENV APTLIST="snapraid python2.7 git screen"

RUN add-apt-repository ppa:tikhonov/snapraid && \
    apt-get update -qq && \
    apt-get install $APTLIST -qy && \
    mkdir -p /app && \
    cd /app && \
    git clone https://github.com/Chronial/snapraid-runner.git && \
    cp snapraid-runner/snapraid-runner.conf.example /defaults/snapraid-runner.conf.example && \
    chmod +x /app/snapraid-runner/snapraid-runner.py && \
    apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD cron/ /etc/cron.d/
ADD defaults/ /defaults/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

CMD ["/sbin/my_init"]

VOLUME /mnt /config
