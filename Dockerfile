FROM debian:latest as builder

RUN apt-get update && apt-get -y upgrade && apt-get install -y libssl-dev build-essential 
RUN apt-get install -y git make libpcap-dev
RUN git clone https://github.com/nmap/nmap.git
WORKDIR /nmap/
RUN ./configure && make && make install

ENTRYPOINT ["/nmap/nmap"] 
