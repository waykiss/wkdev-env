#!/bin/bash
 groupadd -g 1000 -r developer \
  && useradd -u 1000 -g 1000 -ms /bin/bash -r developer \
  && ls /etc/sudoers.d \
  && echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-developer \
  && adduser developer kvm \
  && adduser developer plugdev