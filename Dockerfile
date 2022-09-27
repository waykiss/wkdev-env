FROM ubuntu:22.04

# commons libs
RUN apt-get update
RUN apt-get install curl wget make build-essential -y
RUN apt-get update && apt-get install --no-install-recommends -y
RUN apt-get install gcc git curl nano apt-transport-https -y
RUN apt-get install libxtst-dev libxext-dev libxrender-dev libfreetype6-dev -y
RUN apt-get install libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 libpq-dev libglu1-mesa pkg-config libgtk-3-dev -y
RUN apt-get install sudo zip unzip -y
# RUN apt-get install jq libgdal-dev libmagic-dev libgeos-dev libffi-dev libxml2-dev libxslt1-dev -y
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*
RUN apt-get install nodejs -y

RUN apt-get install supervisor -y
RUN chmod 777 -R /var/log/supervisor/

RUN apt-get install openvpn openconnect -y \
&& mkdir -p /var/run/vpnc && mkdir -p /dev/net \
&& chmod 777 -R /var/run/vpnc && chmod 777 -R /dev/net

RUN apt-get install openjdk-11-jdk -y
RUN apt-get install nautilus bsdmainutils -y
RUN apt-get install xterm -y
RUN apt-get install gedit -y
RUN apt-get install -qqy x11-apps


# install golang
ENV GO_VERSION="1.19.1"
ENV GO_ARCH="amd64"
ENV GO_ARCH="amd64"
ENV GOROOT=/opt/go
ENV PATH=$PATH:$GOROOT/bin
RUN mkdir -p /opt/go && cd /opt/go && wget -L "https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" \
    && tar -xf "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" --strip-components=1 --directory /opt/go \
    && rm -rf "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"

# install intelij
ENV IDEA_VERSION=2022.2.2
RUN export IDEA_VERSION=2022.2.2  \
   && mkdir -p /opt/intelij \
   && cd /opt/intelij \
   && wget -L "https://download.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz" \
   && tar -xf "ideaIU-${IDEA_VERSION}.tar.gz" --strip-components=1 --directory /opt/intelij \
   && rm -rf "ideaIU-${IDEA_VERSION}.tar.gz"

RUN mkdir -p ~/.config && chmod 777 -R ~/.config

# config developer user
RUN groupadd -g 1000 -r developer \
      && useradd -u 1000 -g 1000 -ms /bin/bash -r developer \
      && ls /etc/sudoers.d \
      && echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-developer \
      && adduser developer kvm \
      && adduser developer plugdev

# define user home
USER developer
WORKDIR /home/developer
ENV HOME=/home/developer LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

# run scripts, some instalations and settings
ADD scripts scripts
RUN sudo cat scripts/config/bash_color_1 >> ~/.bashrc

# general config permission
RUN mkdir -p ~/.ssh && sudo chmod 600 -R ~/.ssh
RUN git config --global --add safe.directory '*'


EXPOSE 80 8080 8000 3000 5405 22
CMD [ "/bin/bash" ]