FROM l3iggs/archlinux-aur

USER root
RUN pacman -Syu --noconfirm 

USER docker
RUN packer -S --noconfirm snapraid

VOLUME /mnt

ADD snapraid.conf /etc/snapraid.conf

USER root
CMD ["snapraid", "sync"]
