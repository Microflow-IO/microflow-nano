FROM registry.jxit.net.cn:5000/ubuntu:22.04

RUN apt-get -y update && \
    apt-get -y install curl wget iproute2 psmisc libpcap0.8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY mfnano-x86 /usr/local/bin/mfnano
