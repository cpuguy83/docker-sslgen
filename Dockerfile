FROM cpuguy83/debian:jessie

RUN apt-get update -qq && apt-get install -y openssl libssl-dev -qq
RUN mkdir -p /var/ssl/ca && mkdir /var/ssl/certs

ADD ca_conf.cnf /var/ssl/
ADD crt_conf.cnf /var/ssl/
RUN touch /var/ssl/ca/index.txt && echo "01" > /var/ssl/ca/serial

ADD genssl.sh /usr/local/bin/genssl

VOLUME ["/var/ssl/certs", "/var/ssl/ca"]

ENTRYPOINT ["/usr/local/bin/genssl"]
