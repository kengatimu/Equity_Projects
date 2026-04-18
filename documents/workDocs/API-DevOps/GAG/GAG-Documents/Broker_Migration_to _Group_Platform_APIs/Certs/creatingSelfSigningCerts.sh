1. Generate the Private Key and CSR: 
	
	i. For equitybank CN
	openssl req -newkey rsa:2048 -nodes -keyout EQUITY-MTN-SS.key -out EQUITY-MTN-SS.csr \
	-subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity/OU=MTN-Integration/CN=equitybankgroup.co.ke/emailAddress=info@equitybankgroup.co.ke"
	
	OR
	
	ii. For localhost CN:
	openssl req -newkey rsa:2048 -nodes -keyout EQUITY-MTN-SS.key -out EQUITY-MTN-SS.csr \
    -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Equity/OU=MTN-Integration/CN=localhost/emailAddress=info@equitybankgroup.co.ke"

2. Create a Self-Signed Certificate: 10 years Validity
	openssl x509 -req -in EQUITY-MTN-SS.csr -signkey EQUITY-MTN-SS.key -out EQUITY-MTN-SS.pem -days 3650

3. Verify the Certificate and Key: -- Very CN
	openssl x509 -in EQUITY-MTN-SS.pem -text -noout
	
	Also, check that the private key is correct by
	openssl rsa -in EQUITY-MTN-SS.key -check

4. Convert your .pem and .key files into a PKCS12 keystore format (.p12)
	openssl pkcs12 -export -in EQUITY-MTN-SS.pem -inkey EQUITY-MTN-SS.key -out EQUITY-MTN-SS.p12 -name tomcat -password pass:Ja6XzA129fT4
	
5. Update permission to the file:
	chmod 644 EQUITY-MTN-SS.p12
		ie.
			Owner (rw-): The owner (e.g., the user who owns the keystore) has read and write access.
			Group (r--): Other users (who are not the owner) have read-only access.
			Others (r--): Users outside the owner and group also have read-only access

========================

6. OTHER POINTS

1. Step 1: Fetch the Certificate Details (CN and other details) from remote service
   Run the following command to fetch the certificate from the server:
		openssl s_client -connect 41.78.191.160:30002 -showcerts