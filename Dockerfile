FROM linuxserver/baseimage
MAINTAINER LinuxServer.io <ironicbadger@linuxserver.io>
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV TERM screen
ENV SNAPRAID_VERSION="8.1"

RUN apt-get update && \
    apt-get install gcc git make wget -y && \
    cd /tmp && \
    wget https://github.com/amadvance/snapraid/releases/download/v8.1/snapraid-8.1.tar.gz && \
    tar -xvf snapraid-8.1.tar.gz && \
    cd snapraid-8.1 && \
    ./configure && \
    make && \
    make check && \
    make install && \
    ln -s /config/snapraid.conf /etc/snapraid.conf && \
    cp /tmp/snapraid-8.1/snapraid.conf.example /config/ && \
    rm -rf /tmp/snapraid-8.1 && \
    rm /tmp/snapraid-8.1.tar.gz && \
    apt-get purge gcc git make wget -y && \
    apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/

RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

CMD ["/sbin/my_init"]

VOLUME /mnt
VOLUME /config
