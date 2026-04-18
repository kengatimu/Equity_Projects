STEP 1 — Generate Private Key
openssl genrsa -out equity-signing.key 2048

STEP 2 — Generate CSR
openssl req -new \
  -key equity-signing.key \
  -out equity-signing.csr \
  -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=Channels/CN=equitybank-papss-signing/emailAddress=info@equitybank.co.ke"
  
STEP 3 — Generate Self-Signed Certificate
openssl x509 -req \
  -in equity-signing.csr \
  -signkey equity-signing.key \
  -out equity-signing.crt \
  -days 3650 \
  -sha256
  
STEP 4 — Create PKCS12 Keystore (Java)
openssl pkcs12 -export \
  -inkey equity-signing.key \
  -in equity-signing.crt \
  -name papss-signing-key \
  -out equity-keystore.p12 \
  -passout pass:changeit
  
STEP 5 — Verify Everything

1. Check cert
openssl x509 -in equity-signing.crt -text -noout

2. Check keystore
keytool -list -v \
  -keystore equity-keystore.p12 \
  -storetype PKCS12 \
  -storepass changeit