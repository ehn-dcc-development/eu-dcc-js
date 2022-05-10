#!/bin/sh
mkdir -p trust
#
# CSCA key
#
set -e

OPENSSL=${OPENSSL:=openssl}

${OPENSSL} ecparam -name prime256v1 -genkey -noout -out ./trust/csca.key
${OPENSSL} req -x509 \
	-subj '/CN=National CSCA of Friesland/C=FR/' \
	-key ./trust/csca.key \
	-out ./trust/csca.pem -nodes \
	-days 3650

# DSC keys
for i in 1 2 3 4 worker
do
R=$( ${OPENSSL} rand -hex 16 )
${OPENSSL} ecparam -name prime256v1 -genkey -noout -out ./trust/dsc-$i.key
${OPENSSL} req -new \
	-subj "/CN=DSC number $i of Friesland/C=FR/" \
	-key ./trust/dsc-$i.key -nodes |
${OPENSSL} x509 -req -CA ./trust/csca.pem -CAkey ./trust/csca.key -set_serial 0x$R \
	-days 1780  \
	-out ./trust/dsc-$i.pem
done

cat ./trust/dsc-*.pem > ./trust/masterlist-dsc.pem

# JavaScripts prefers PKCS#8
openssl pkcs8 -in ./trust/dsc-worker.key -nocrypt -topk8 -out ./trust/dsc-worker.p8

# Remove unneeded keys and certs
rm -f ./trust/csca.key ./trust/dsc-?.key ./trust/dsc-?.pem 
