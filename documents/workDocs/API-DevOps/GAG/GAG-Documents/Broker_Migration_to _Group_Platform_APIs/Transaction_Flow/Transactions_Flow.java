A. Business Servie (BS):

I. Request

1. BS receives request from the channel

2. BS checks for duplicate transaction from the received rrn
	I. If a duplicate exists, BS returns an error with below details:
		i. 	 status: ERROR|409 (Correct status code to be determined)
		ii.	 responseCode: 409
		iii. responseDesc: De-Dup! The request is a duplicate and has already been processed.
		
3. Bs saves the initial transaction details as follows:
	i. TransactionDetails table: 
		a. Read the request and updates the respective fields
	ii. StatusDetails table:
		a. Status: INITIALIZED
		b. StateusCode: 02 (Correct status code to be determined)
		c. StatusMessage: Request received. Processing started.
	iii. PayloadDetails:
		a. ChannelRequest: Saves received channel request xml string
		
4. Bs will check if there exists request validation errors.
	I. If errors exists it will return an error with below details:
		i. 	 status: ERROR|400 (Correct status code to be determined)
		ii.	 responseCode: 400
		iii. responseDesc: This will be based on the erroneous field.
		
7. Bs will validate the signature
	I. If signature is invalid:
		a. Compose error response xml with below fields
			i. 	 Status: ERROR|-6
			ii.	 responseCode: -6
			iii. responseDesc:  Unauthorized. Signature validation failed.
		b. Updte the database table as follows:
			i. StatusDetails table:
					a. Status: ERROR|-6
					b. StateusCode: -6
					c. StatusMessage: Unauthorized. Signature validation failed.
			ii. PayloadDetails:
					a. channelResponse: Saves the composed response xml string
		c. Reurns the composed xml stirng back to channel		

8. Bs will compose telco technical service xml request string.
9. Bs calls the telco's technical service via the eurkea provide url and the composed request string.
10. If a timeout occurs:
		a. Compose error response xml with below fields
			i. 	 Status: ERROR|-3
			ii.	 responseCode: -3
			iii. responseDesc:  Business service did not receive a response possibly due to timout.
		b. Updte the database table as follows:
			i. StatusDetails table:
					a. Status: ERROR|-3
					b. StateusCode: -3
					c. StatusMessage: Business service did not receive a response possibly due to timout.
			iii. PayloadDetails:
					a. channelResponse: Saves the composed response xml string
		c. Reurns the composed xml stirng back to channel
					
I. Response

1. Bs recives the response from telco's technical service.
2. BS extracts the xml response and return it back to the calling channel


B. Telco Technical Service MS (TS)
					
I. Request

1. TS receives the request from BS
2. Ts confirms if the transaction exist in the TransactionDetails table using rrn.
	a. If it does not exist:
		a. Compose error response xml with below fields
			i. 	 Status: ERROR|404 (Correct status code to be determined)
			ii.	 responseCode: 404
			iii. responseDesc: Transaction with the provided rrn does not exist.
		b. Updte the database table as follows:
			i. StatusDetails table:
					a. Status: ERROR|404 (Correct status code to be determined)
					b. StateusCode: 404
					c. StatusMessage: Transaction with the provided rrn does not exist.
			iii. PayloadDetails:
					a. channelResponse: Saves the composed response xml string
		c. Reurns the composed xml stirng back to BS

3. Ts composes the telco request (xml or json, based on the telco's requirements)
								  
4. Ts Updates the dabase table as follows:
 	a. PayloadDetails:
		i. telcoRequest: Saves the composed telco request string

5. Ts sends a http post request to the telco using the composed request string
6. Ts updates the database as follows:
	i. StatusDetails table:
		a. Status: PENDING
		b. StateusCode: 01
		c. StatusMessage: Transaction sent to telco. Awaiting final response.						  

6. If a timeout occurs:
	a. Compose error response xml with below fields
		i. 	 Status: ERROR|-3
		ii.	 responseCode: -3
		iii. responseDesc: Telco technical service did not receive a response possibly due to timout.
	b. Updte the database table as follows:
		i. StatusDetails table:
				a. Status: ERROR|-3
				b. StateusCode: -3
				c. StatusMessage: Telco technical service did not receive a response possibly due to timout.
		iii. PayloadDetails:
				a. channelResponse: Saves the composed response xml string
	c. Reurns the composed xml stirng back to BS
	

I. Response

1. TS recives the response from the telco.
2. TS processes the response
3. If the response is an error/ failure, TS does the following:
	a. Compose error response xml with below fields
		i. 	 Status: ERROR|<Error_CODE> 
		ii.	 responseCode: <Error_CODE> 
		iii. responseDesc: <ERROR_DESC>
	b. Updte the database table as follows:
		i. StatusDetails table:
				a. Status: ERROR|<Error_CODE>
				b. StateusCode: <Error_CODE>
				c. StatusMessage: <ERROR_DESC>
		iii. PayloadDetails:
				a. channelResponse: Saves the composed response xml string
				b. telcoResponse: Saves the received response string from telco
	c. Reurns the composed xml stirng back to BS	

4. If the response is an OK/ Success and response is async, TS does the following:
	a. Update the StatusDeteails table with:
		i. TranId: <Received transactionId from the telco>
	b. Create a 10 seconds while loop that will do the following:
		i.   Check the final status of the transaction
		ii.  If the final status is not determined withing the 10 seconds, exit the loop and do the following:
				a. Compose success xml response string with below fields
					i. 	 Status: OK
					ii.	 responseCode: 00
					iii. responseDesc: COMPLETED_SUCCESSFULLY
				b. Updte the database table as follows:
					i. StatusDetails table:
							a. Status: PENDING
							b. StateusCode: 01
							c. StatusMessage: The transaction final status is still unknown
					iii. PayloadDetails:
							a. channelResponse: Saves the composed response xml string
							b. telcoResponse: Saves the received status check response string from telco
				c. Reurns the composed xml stirng back to BS
				
		iii. If the final status is known (SUCCESS OR FAILURE), exit the loop and do the following:
				a. Compose response xml response string with below fields, based on the received status
					i. 	 Status: <OK or ERROR> 
					ii.	 responseCode: <00 or RECEIVED_ERROR_CODE> 
					iii. responseDesc: <COMPLETED_SUCCESSFULLY or RECEIVED_ERROR_DESC>
				b. Updte the database table as follows:
					i. StatusDetails table:
							a. Status: <OK or ERROR> 
							b. StateusCode: <00 or RECEIVED_ERROR_CODE> 
							c. StatusMessage: <COMPLETED_SUCCESSFULLY or RECEIVED_ERROR_DESC>
					iii. PayloadDetails:
							a. channelResponse: Saves the composed response xml string
							b. telcoResponse: Saves the received status check response string from telco
				c. Reurns the composed xml stirng back to BS	

5. Otherwise if the response is sync:
	a. Compose success xml response string with below fields
		i. 	 Status: OK
		ii.	 responseCode: 00
		iii. responseDesc: COMPLETED_SUCCESSFULLY
	b. Updte the database table as follows:
		i. StatusDetails table:
				a. Status: OK
				b. StateusCode: 00
				c. StatusMessage: COMPLETED_SUCCESSFULLY
				d. TranId : <Received transactionID from the telco>
		iii. PayloadDetails:
				a. channelResponse: Saves the composed response xml string
				b. telcoResponse: Saves the received response string from telco
	c. Reurns the composed xml stirng back to BS	
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						

