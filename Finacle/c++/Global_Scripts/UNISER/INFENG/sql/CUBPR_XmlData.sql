SET DEFINE OFF;
Insert into CUSTOM.C_CUBPR
   (TEMPLATE_ID, REQ_XML)
 Values
   ('TEMPLATE1', '<?xml version=''1.0'' encoding=''UTF-8''?><S:Envelope xmlns:S=''http://schemas.xmlsoap.org/soap/envelope/''><S:Header/><S:Body><ns2:getPaymentDetails xmlns:ns2=''http://equitybank.ke.co/''><transactionRef>XXX</transactionRef><currency>XXX</currency></ns2:getPaymentDetails></S:Body></S:Envelope>');
Insert into CUSTOM.C_CUBPR
   (TEMPLATE_ID, REQ_XML)
 Values
   ('TEMPLATE2', '<transactionRef>XXX</transactionRef>');
Insert into CUSTOM.C_CUBPR
   (TEMPLATE_ID, REQ_XML)
 Values
   ('TEMPLATE3', '<paymentId>XXX</paymentId>');
COMMIT;
