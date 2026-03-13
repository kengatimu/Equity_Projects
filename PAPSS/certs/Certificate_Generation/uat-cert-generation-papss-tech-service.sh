A. Outbound servie: papss.equitygroupholdings

1. Generate a single CSR and private key
openssl req -newkey rsa:2048 -nodes -keyout papss-equitygroup.key -out papss-equitygroup.csr \
-subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=Channels/CN=*.equitybank.co.ke/emailAddress=info@equitybank.co.ke"

2. Self-sign the CSR to create certificates per channel
	openssl x509 -req -in papss-equitygroup.csr -signkey papss-equitygroup.key -out papss-equitygroup.pem -days 3650

	# Create temporary omni.p12 keystore
	openssl pkcs12 -export -in papss-equitygroup.pem -inkey papss-equitygroup.key -out papss-equitygroup.p12 -name papss-equitygroup -password 'pass:papss-equitygroup!'


3. Verify the contents of the unified keystore and update the permissions
	# Verify the contents of the keystore
	keytool -list -keystore papss-equitygroup.p12

	# Update the permissions
	chmod 644 papss-equitygroup.p12
		

Truststores 

1. Generate certificate to be shared with papss. I will use it for my mock-papss cert
	openssl x509 -in papss-equitygroup.pem -out papss-equitygroup.crt

2. Create a truststore and import the papss cert in the truststore

i. For PAPSS
	a. EQUITYY-c1.crt
	keytool -importcert \
	  -alias papss-uat \
	  -file EQUITYY-c1.crt \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'

	b. tesf-c1.crt
	keytool -importcert \
	  -alias papss-uat-test \
	  -file tesf-c1.crt \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'

	c. papssnet.crt
	keytool -importcert \
	  -alias papss-amazon-uat \
	  -file papssnet.crt \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'
	  
ii. For REMMITTANCE
	keytool -importcert \
	  -alias papss-moc \
	  -file papss-equitygroup.crt \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'
	  
iii. For OMNI
	keytool -importcert \
	  -alias omni \
	  -file OMNI.crt \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'

iv. For REMITTANCE
	keytool -importcert \
	  -alias remittance \
	  -file REMITTANCE.crt \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'
  
v. Verify the truststore plus its contents
	keytool -list -v \
	  -keystore truststore-papss-equitygroup.p12 \
	  -storetype PKCS12 \
	  -storepass 'papss-equity!'
	  
** vi. Delete a cert from keystore
	- keytool -delete -alias papss-amazon-uat -keystore truststore-papss-equitygroup.p12
	- keytool -delete -alias papss-uat -keystore truststore-papss-equitygroup.p12

** Show Certs online
	openssl s_client -connect 10.109.10.139:443 -showcerts
	openssl s_client -connect 10.109.10.151:443 -showcerts
	  
** Check the contents of the crt
a. subject

bishop@Kennedys-MacBook-Pro:|⇒  openssl x509 -in papssnet.crt -noout -subject 
subject=CN=*.papssnet.papss.com

b. All info
bishop@Kennedys-MacBook-Pro:|⇒  openssl x509 -in papssnet.crt -noout -text

		
*** For PAPSS UAT pm.test.papssnet.papss.com which is mapped to both 10.109.10.139 and 10.109.10.151, am creatign the truststore like:
1. Show certs with either the ips:
	openssl s_client -connect 10.109.10.139:443 -showcerts 
	or
	openssl s_client -connect 10.109.10.151:443 -showcerts
	
2. Create a crt file for the second block with issurer i:/CN=AFXM CA. Call it afxm-ca.crt since it is self signed.
you can create both files, but this will work

-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----

3.Import crt to a truststore

keytool -importcert \
  -alias afxm-ca \
  -file afxm-ca.crt \
  -keystore papss_truststore.p12 \
  -storetype PKCS12 \
  -storepass changeit \
  -noprompt

-- list the keystore
keytool -list -keystore papss_truststore.p12 -storepass changeit

4. Incase you are testing to papss direct using curl, curl requires a .pem file
-- create pem file
openssl pkcs12 -in papss_truststore.p12 \
  -out papss_truststore.pem \
  -nokeys \
  -passin pass:changeit
  
-- list the contents of the pem file
openssl x509 -in papss_truststore.pem -noout -text
openssl x509 -in papss_truststore.pem -noout -subject -issuer | grep AFXM


*** How to check if the channel is signing with the same key as the cert provided
1. How to compare modulus for key and cert

openssl rsa -noout -modulus -in OMNI.cer | openssl md5
openssl rsa -noout -modulus -in OMNI.key | openssl md5

- If both produce the exact same hash (the md5 output), then the private key and certificate match.
(cert) d4fc237e2cd48f0c202a4e2d0701ee17
(key)  d4fc237e2cd48f0c202a4e2d0701ee17


papss.signing.trust-store

