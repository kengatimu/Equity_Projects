A. PAPSS - Equity : Equity side

	1. For ssl: ssl-papss-equity.csr
		Supported algorithms and key lengths
		RSA
		2048
		3072
		4096

		# Step 1: Generate RSA private key (3072 bits)
		openssl genrsa -out ssl-papss-equity.key 3072

		# Step 2: Generate CSR
		openssl req -new -key ssl-papss-equity.key -out ssl-papss-equity.csr \
		  -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=SRE-GAG/CN=*.equitybank.co.ke/emailAddress=info@equitybankgroup.co.ke"

		 NOTE: You can adjust key size to 2048 or 4096 if required — but 3072 is the sweet spot (stronger than 2048, more performant than 4096).


	2. For message signing: signing-papss-equity.csr
		EAC - Elliptic - curve cryptography
		p-256
		p-384

		# Step 1: Generate EC private key using P-256
		openssl ecparam -name prime256v1 -genkey -noout -out signing-papss-equity.key

		# Step 2: Generate CSR
		openssl req -new -key signing-papss-equity.key -out signing-papss-equity.csr \
		  -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=SRE-GAG/CN=*.equitybank.co.ke/emailAddress=info@equitybankgroup.co.ke"

		NOTE: You may also use secp384r1 (P-384) if PAPSS requires a stronger curve

B. Self signing : Equity Side
	1. For ssl: 
		- create a self-signed EC certificate (ssl-papss-equity.pem) that is valid for 10 years (-days 3650).
			# Self-sign the CSR with the private key to generate the certificate
			openssl x509 -req -in ssl-papss-equity.csr -signkey ssl-papss-equity.key -out ssl-papss-equity.pem -days 3650
			
		- Create the .p12 file, which contains both the EC private key and the self-signed certificate.
			# Export the private key and certificate into a PKCS#12 file
			openssl pkcs12 -export -in ssl-papss-equity.pem -inkey ssl-papss-equity.key -out keystore-ssl-papss-equity.p12 -name ssl -password 'pass:Equi$tr0ng@2025!'
			
		- Validate if the password works
			keytool -list -keystore keystore-ssl-papss-equity.p12
			<Enter the password>
		
		- Ensure the .p12 file has the correct permissions
			chmod 644 keystore-ssl-papss-equity.p12
			
	1. For signing: 
		- create a self-signed EC certificate (signing-papss-equity.pem) that is valid for 10 years (-days 3650).
			# Self-sign the CSR with the private key to generate the certificate
			openssl x509 -req -in signing-papss-equity.csr -signkey signing-papss-equity.key -out signing-papss-equity.pem -days 3650
			
		- Create the .p12 file, which contains both the EC private key and the self-signed certificate.
			# Export the EC private key and certificate into a PKCS#12 file
			openssl pkcs12 -export -in signing-papss-equity.pem -inkey signing-papss-equity.key -out keystore-signing-papss-equity.p12 -name signing -password 'pass:Equi$tr0ng@2025!'
			
		- Validate if the password works
			keytool -list -keystore keystore-signing-papss-equity.p12
			<Enter the password>
		
		- Ensure the .p12 file has the correct permissions
			chmod 644 keystore-signing-papss-equity.p12
			
C. Generate ssl certificate for papss
		openssl x509 -in ssl-papss-equity.pem -out ssl-papss-equity.crt
		
			
D. Generate signining certificate for equity bank
		openssl x509 -in signing-papss-equity.pem -out signing-papss-equity.crt
		
E. Create a ssl truststore for papss certificate (ssl-equity-papss.crt, received ssl certificate from papss)
		- create a truststore
			- First import the cert into a temporary JKS
			
				keytool -importcert \
				  -alias ssl-ips \
				  -file ssl-equity-papss.crt \
				  -keystore truststore-ssl-equity-papss.jks \
				  -storepass 'Equi$tr0ng@2025!' \
				  -noprompt
				  
			- Then convert to PKCS12 if needed
			
				keytool -importkeystore \
				  -srckeystore truststore-ssl-equity-papss.jks \
				  -destkeystore truststore-ssl-equity-papss.p12 \
				  -srcstoretype JKS \
				  -deststoretype PKCS12 \
				  -srcstorepass 'Equi$tr0ng@2025!' \
				  -deststorepass 'Equi$tr0ng@2025!'
				  
			- verify the truststore
			
				keytool -list -v \
				  -keystore truststore-ssl-equity-papss.p12 \
				  -storetype PKCS12 \
				  -storepass 'Equi$tr0ng@2025!'

=============

Digicert - new password:  'Equi$tr0ng@2025!'

keytool -importkeystore \
  -srckeystore papss_equitygroupholdings_com.jks \
  -srcstoretype JKS \
  -destkeystore keystore-ssl-papss-equity.p12 \
  -deststoretype PKCS12 \
  -srcalias server \
  -destalias ssl-papss-equity
