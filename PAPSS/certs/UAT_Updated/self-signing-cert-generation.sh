1. openssl genrsa -out equity-client.key 2048

2. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls_updated|⇒  openssl req -new \
  -key equity-client.key \
  -out equity-client.csr \
  -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=Channels/CN=equitybank-papss-client/emailAddress=info@equitybank.co.ke"
  
3. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls_updated|⇒  openssl req -new \
  -key equity-client.key \
  -out equity-client.csr \
  -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=Channels/CN=equitybank-papss-client/emailAddress=info@equitybank.co.ke"
  
4. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls_updated|⇒  vi client-ext.cnf


5. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls/equity|⇒  cat client-ext.cnf 
basicConstraints=CA:FALSE
keyUsage=digitalSignature, nonRepudiation
extendedKeyUsage=clientAuth,emailProtection
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer

6. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls_updated|⇒  openssl x509 -req \
  -in equity-client.csr \
  -CA equity-root-ca.crt \
  -CAkey equity-root-ca.key \
  -CAcreateserial \
  -out equity-client.crt \
  -days 3650 \
  -sha256 \
  -extfile client-ext.cnf

Certificate request self-signature ok
subject=C=KE, ST=Nairobi, L=Nairobi, O=Equity Bank Kenya Limited, OU=Channels, CN=equitybank-papss-client, emailAddress=info@equitybank.co.ke

7. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls_updated|⇒  openssl pkcs12 -export \
  -inkey equity-client.key \
  -in equity-client.crt \
  -certfile equity-root-ca.crt \
  -name papss-client-key \
  -out equity-client-keystore.p12 \
  -passout pass:changeit
  
8. bishop@Kennedys-MacBook-Pro:~/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/PAPSS/certs/UAT_Updated/mtls_updated|⇒  openssl x509 -in equity-client.crt -text -noout