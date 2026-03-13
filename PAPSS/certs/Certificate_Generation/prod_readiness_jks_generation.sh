Papss certifcate production readiness

1. Go to the location of the jks and do 
	 keytool -list -v -keystore papss_equitygroupholdings_com.jks
	 
2. This will show 3 entries
	

i. 	Alias name: papssca
	Creation date: 23 Apr 2025
	Entry type: trustedCertEntry

	Owner: CN=AFXM CA
	Issuer: CN=AFXM CA

ii. Alias name: papssserver
	Creation date: 23 Apr 2025
	Entry type: trustedCertEntry

	Owner: CN=server-c1
	Issuer: CN=AFXM CA
	
iii. Alias name: server
	Creation date: 23 Apr 2025
	Entry type: PrivateKeyEntry
	Certificate chain length: 3
	Certificate[1]:
	Owner: CN=papss.equitygroupholdings.com, OU=IT, O=Equity Bank Kenya Limited, L=Nairobi, C=KE
	Issuer: CN=DigiCert Assured ID Client CA G2, OU=www.digicert.com, O=DigiCert Inc, C=US
	Serial number: 7d2d016be41fcd30d374843fc91ba40

3. Decide what to trust

	From your keystore dump, you have:
	papssca : AFXM CA (CA=true) 
	papssserver : PAPSS server cert (leaf)

	The best practice is to Trust the CA (papssca), not the leaf server cert, but will trust them both, no harm.
	
4. Export PAPSS CA certificate from existing JKS - In PEM (RFC-compliant) format

	 keytool -exportcert \
	  -alias papssca \
	  -keystore papss_equitygroupholdings_com.jks \
	  -rfc \
	  -file papss_ca.crt

	Enter keystore password:  
	Certificate stored in file <papss_ca.crt>

	Warning:
	The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore papss_equitygroupholdings_com.jks -destkeystore papss_equitygroupholdings_com.jks -deststoretype pkcs12".
	
5. (Optional) Export PAPSS server cert
	 
	 keytool -exportcert \
	  -alias papssserver \
	  -keystore papss_equitygroupholdings_com.jks \
	  -rfc \
	  -file papss_server.crt

	Enter keystore password:  
	Certificate stored in file <papss_server.crt>

	Warning:
	The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore papss_equitygroupholdings_com.jks -destkeystore papss_equitygroupholdings_com.jks -deststoretype pkcs12".
	
6. Create a NEW production truststore
	i. Import PAPSS CA (this CREATES the truststore)
	
		keytool -importcert \
		  -alias papss-ca \
		  -file papss_ca.crt \
		  -keystore truststore-papss-prod.jks \
		  -storepass EquityPap
		  
	ii. Import PAPSS server cert (optional, since trusting CA is enough)
	
		keytool -importcert \
		  -alias papss-server \
		  -file papss_server.crt \
		  -keystore truststore-papss-prod.jks \
		  -storepass EquityPap
		  
	iii. Import channel (OMNI) certs in the truststore
		
		keytool -importcert \
		  -alias omni \
		  -file OMNI.cer \
		  -keystore truststore-papss-prod.jks \
		  -storepass EquityPap
		  
7. Verify keystore contents

	 keytool -list -v \
	  -keystore truststore-papss-prod.jks \
	  -storepass EquityPap





