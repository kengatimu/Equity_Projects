A. PAPSS - Equity : PAPSS side (Simulation)

	1. For ssl: ssl-equity-papss.csr
		Supported algorithms and key lengths
		RSA
		2048
		3072
		4096

			# Step 1: Generate RSA 2048-bit private key
			openssl genrsa -out ssl-equity-papss.key 2048

			# Step 2: Generate CSR
			openssl req -new -key ssl-equity-papss.key -out ssl-equity-papss.csr \
			  -subj "/C=EG/ST=Cairo/L=Cairo/O=PAPSS/OU=SIPS/CN=*.papss.com/emailAddress=info@ips.com"

		 	NOTE: You can adjust key size to 3072 or 4096 if required.


	2. For message signing: signing-equity-papss.csr
		EAC - Elliptic - curve cryptography
		p-256
		p-384

			# Step 1: Generate EC private key using P-256
			openssl ecparam -name prime256v1 -genkey -noout -out signing-equity-papss.key

			# Step 2: Generate CSR
			openssl req -new -key signing-equity-papss.key -out signing-equity-papss.csr \
			  -subj "/C=EG/ST=Cairo/L=Cairo/O=PAPSS/OU=SIPS/CN=*.papss.com/emailAddress=info@ips.com"

			NOTE: You may also use secp384r1 (P-384) if PAPSS requires a stronger curve

B. Self signing : PAPSS side (Simulation)
	1. For ssl: 
		- create a self-signed EC certificate (ssl-equity-papss.pem) that is valid for 10 years (-days 3650).
			# Self-sign the CSR with the private key to generate the certificate
			openssl x509 -req -in ssl-equity-papss.csr -signkey ssl-equity-papss.key -out ssl-equity-papss.pem -days 3650
			
		- Create the .p12 file, which contains both the EC private key and the self-signed certificate.
			# Export the private key and certificate into a PKCS#12 file
			openssl pkcs12 -export -in ssl-equity-papss.pem -inkey ssl-equity-papss.key -out keystore-ssl-equity-papss.p12 -name ssl -password 'pass:Pap$$Secure@2025!'
			
		- Validate if the password works
			keytool -list -keystore keystore-ssl-equity-papss.p12
			<Enter the password>
		
		- Ensure the .p12 file has the correct permissions
			chmod 644 keystore-ssl-equity-papss.p12
			
	1. For signing: 
		- create a self-signed EC certificate (signing-equity-papss.pem) that is valid for 10 years (-days 3650).
			# Self-sign the CSR with the private key to generate the certificate
			openssl x509 -req -in signing-equity-papss.csr -signkey signing-equity-papss.key -out signing-equity-papss.pem -days 3650
			
		- Create the .p12 file, which contains both the EC private key and the self-signed certificate.
			# Export the EC private key and certificate into a PKCS#12 file
			openssl pkcs12 -export -in signing-equity-papss.pem -inkey signing-equity-papss.key -out keystore-signing-equity-papss.p12 -name signing -password 'pass:Pap$$Secure@2025!'
			
		- Validate if the password works
			keytool -list -keystore keystore-signing-equity-papss.p12
			<Enter the password>
		
		- Ensure the .p12 file has the correct permissions
			chmod 644 keystore-signing-equity-papss.p12
			
C. Generate ssl certificate for equity bank
		openssl x509 -in ssl-equity-papss.pem -out ssl-equity-papss.crt
		
			
D. Generate signining certificate for equity bank
		openssl x509 -in signing-equity-papss.pem -out signing-equity-papss.crt
		
E. Create a ssl truststore for papss certificate (ssl-equity-papss.crt, received ssl certificate from papss)
		- create a truststore
			- First import the cert into a temporary JKS
			
				keytool -importcert \
				  -alias ssl-equity \
				  -file ssl-papss-equity.crt \
				  -keystore truststore-ssl-papss-equity.jks \
				  -storepass 'Pap$$Secure@2025!' \
				  -noprompt
				  
			- Then convert to PKCS12 if needed
			
				keytool -importkeystore \
				  -srckeystore truststore-ssl-papss-equity.jks \
				  -destkeystore truststore-ssl-papss-equity.p12 \
				  -srcstoretype JKS \
				  -deststoretype PKCS12 \
				  -srcstorepass 'Pap$$Secure@2025!' \
				  -deststorepass 'Pap$$Secure@2025!'
				  
			- verify the truststore
			
				keytool -list -v \
				  -keystore truststore-ssl-papss-equity.p12 \
				  -storetype PKCS12 \
				  -storepass 'Pap$$Secure@2025!'
	