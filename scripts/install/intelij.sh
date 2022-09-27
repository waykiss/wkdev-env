#!/bin/bash
if [ ! -d "/opt/intelij" ]
 then
   export IDEA_VERSION=2022.2.2 \
   && mkdir -p /opt/intelij \
   && cd /opt/intelij \
   && wget -L "https://download.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz" \
   && tar -xf "ideaIU-${IDEA_VERSION}.tar.gz" --strip-components=1 --directory intelij \
   && rm -rf "ideaIU-${IDEA_VERSION}.tar.gz"
fi
