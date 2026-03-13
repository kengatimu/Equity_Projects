1. Generate a single CSR and private key for all channel services
openssl req -newkey rsa:2048 -nodes -keyout channel-service.key -out channel-service.csr \
-subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity Bank Kenya Limited/OU=Channels/CN=*.equitybank.co.ke/emailAddress=info@equitybank.co.ke"

2. Self-sign the CSR to create certificates per channel
	i. Omni channel
		openssl x509 -req -in channel-service.csr -signkey channel-service.key -out omni-channel.pem -days 3650
		
		# Create temporary omni.p12 keystore
		openssl pkcs12 -export -in omni-channel.pem -inkey channel-service.key -out omni.p12 -name omni -password 'pass:channel_services!'
		
	ii. Remittance channel
		# Creeate remittance private key
		openssl x509 -req -in channel-service.csr -signkey channel-service.key -out remittance-channel.pem -days 3650

		# Create temporary remittance.p12 keystore
		openssl pkcs12 -export -in remittance-channel.pem -inkey channel-service.key -out remittance.p12 -name remittance -password 'pass:channel_services!'
		
3. Merge the individual private key + certificate chains (omni.p12 and remittance.p12) into a single unified keystore - channel-services.p12 - under different aliases (omni and 	remittance).

	i. Omni keystore
		# Import omni.p12 into the uninfied keystore
		keytool -importkeystore \
		  -srckeystore omni.p12 \
		  -srcstoretype PKCS12 \
		  -destkeystore channel-services.p12 \
		  -deststoretype PKCS12 \
		  -srcstorepass 'channel_services!' \
		  -deststorepass 'channel_services!'
		  
	ii. Omni keystore
		# Import remittance.p12 into the uninfied keystore
		keytool -importkeystore \
		  -srckeystore remittance.p12 \
		  -srcstoretype PKCS12 \
		  -destkeystore channel-services.p12 \
		  -deststoretype PKCS12 \
		  -srcstorepass 'channel_services!' \
		  -deststorepass 'channel_services!'

4. Verify the contents of the unified keystore and update the permissions
	# Verify the contents of the keystore
	keytool -list -keystore channel-services.p12

	# Update the permissions
	chmod 644 channel-services.p12
		

Certificates 

1. Create certificate files for each channel

openssl x509 -in omni-channel.pem -out OMNI.crt
openssl x509 -in remittance-channel.pem -out REMMITTANCE.crt

2. Create a truststore and import the two certificates in the truststore - on papss-technical-service

i. For OMNI
	keytool -importcert \
	  -alias omni \
	  -file OMNI.crt \
	  -keystore truststore-channel-services.p12 \
	  -storetype PKCS12 \
	  -storepass 'channel-verify!'
  
ii. For REMMITTANCE
	keytool -importcert \
	  -alias remittance \
	  -file REMMITTANCE.crt \
	  -keystore truststore-channel-services.p12 \
	  -storetype PKCS12 \
	  -storepass 'channel-verify!'
  
iii. Verify the truststore plus its contents
	keytool -list -v \
	  -keystore truststore-channel-services.p12 \
	  -storetype PKCS12 \
	  -storepass 'channel-verify!'