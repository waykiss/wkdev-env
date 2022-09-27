#!/bin/bash
apt-get install locales
locale-gen en_US.UTF-8 \
  && dpkg-reconfigure locales \
  && locale-gen C.UTF-8 \
  && /usr/sbin/update-locale LANG=C.UTF-8
