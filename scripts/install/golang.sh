#!/bin/bash
if [ ! -d "~/opt/go" ]
 then
   export GO_VERSION="1.19.1"
   export GO_ARCH="amd64"
   export GOROOT=/opt/go
   export PATH=$PATH:$GOROOT/bin
   mkdir -p /opt/go && cd /opt/go &&
   wget -L "https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
   tar -xf "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" --strip-components=1 --directory /opt/go
   rm -rf "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
fi
