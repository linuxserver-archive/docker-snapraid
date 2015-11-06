FROM linuxserver/baseimage
MAINTAINER LinuxServer.io <ironicbadger@linuxserver.io>
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV TERM screen

WORKDIR /tmp

RUN apt-get update
RUN apt-get install gcc git make wget -y
RUN wget https://github.com/amadvance/snapraid/releases/download/v8.1/snapraid-8.1.tar.gz
RUN tar -xvf snapraid-8.1.tar.gz
RUN pwd
WORKDIR snapraid-8.1
RUN ./configure
RUN make
RUN make check
RUN make install
RUN ln -s /config/snapraid.conf /etc/snapraid.conf
RUN cp /tmp/snapraid-8.1/snapraid.conf.example /config/
RUN rm -rf /tmp/snapraid-8.1

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/

RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

CMD ["/sbin/my_init"]

VOLUME /mnt
VOLUME /config
