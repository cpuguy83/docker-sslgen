#!/bin/bash

trap ctrl_c INT
ctrl_c() {
  echo "Control+C pressed, exiting"
  exit 255
}

trap term TERM
term() {
  echo "Caught SIGTERM, exiting"
  exit 0
}

genca() {
  export OPENSSL_CONF=/var/ssl/ca_conf.cnf
  openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -keyout /var/ssl/ca/ca_key.pem -out /var/ssl/ca/ca_cert.pem
  chmod 640 /var/ssl/ca_*
}

cafiles=/var/ssl/ca
if [ `ls ${cafiles}/* | wc -l` -eq 2 ]; then
  echo "No CA cert provided, creating a new one!"
  genca
fi

serial=$(cat /var/ssl/ca/serial)

echo ""
echo "Generating SSL Cert"
echo "Enter name for certificate file"
read CERT_NAME
export OPENSSL_CONF=/var/ssl/crt_conf.cnf
openssl req -nodes -newkey rsa:2048 -keyout /var/ssl/certs/${CERT_NAME}.key -keyform PEM -out tempreq.pem -outform PEM

export OPENSSL_CONF=/var/ssl/ca_conf.cnf
openssl ca -in tempreq.pem -out ${CERT_NAME}.pem
rm -f tempreq.pem

mv /var/ssl/certs/${serial}.pem /var/ssl/certs/${CERT_NAME}.pem
chmod 640 /var/ssl/certs/${CERT_NAME}.pem


