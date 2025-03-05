FROM debian:latest AS builder

RUN apt-get update && apt-get -y upgrade && apt-get install -y libssl-dev build-essential autoconf libpcap-dev
RUN apt-get install -y make git
RUN git clone https://github.com/nmap/nmap.git
WORKDIR /nmap/
RUN   sed -i "s/LIBS =  \$(NSOCKDIR)\/src\/libnsock.a \$(NBASEDIR)\/libnbase.a ..\/libnetutil\/libnetutil.a \$(OPENSSL_LIBS) @LIBPCAP_LIBS@ @LIBDNET_LIBS@ @LIBS@/LIBS =  \$(NSOCKDIR)\/src\/libnsock.a ..\/libnetutil\/libnetutil.a \$(NBASEDIR)\/libnbase.a \$(OPENSSL_LIBS) @LIBPCAP_LIBS@ @LIBDNET_LIBS@ @LIBS@/g" nping/Makefile.in
RUN ./configure && make && make install

ENTRYPOINT ["/nmap/nmap"] 
