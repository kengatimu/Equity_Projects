SELECT TOP (1000) * FROM [dbo].[param_configs]

insert into [dbo].[param_configs] values(1,'xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"','ACMT023 NameSpace','schema.location.actmt0023',
'ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"');

insert into [dbo].[param_configs] values(2,'xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"','Pacs028 NameSpace','schema.location.pac028',
'ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"');

insert into [dbo].[param_configs] values(3,'https://api.start.ipsl.co.ke/iso20022/sync/v1/verification-request','IPSL Verification Request url','ips.verification.request.url',
'ENABLEB','https://api.start.ipsl.co.ke/iso20022/sync/v1/verification-request'); 

insert into [dbo].[param_configs] values(4,'https://api.start.ipsl.co.ke/iso20022/async/v1/credit-transfer','IPSL Credit Transfer url','ips.credit.transfer.url',
'ENABLEB','https://api.start.ipsl.co.ke/iso20022/async/v1/credit-transfer'); 


insert into [dbo].[param_configs] values(7,'http://localhost:8085/v1/callback/channel','Channel Callback Url','channel.callback.url','ENABLEB','http://localhost:8085/v1/callback/channel'); 

insert into [dbo].[param_configs] values(8,'https://api.start.ipsl.co.ke/v1/payment-status-request','IPSL Payment Status Url','payment.status.url','ENABLEB','https://api.start.ipsl.co.ke/v1/payment-status-request'); 

insert into [dbo].[banks] values(14,'0025','CREDIT BANK','ONLINE');

insert into [dbo].[banks] values(14,'0025','CREDIT BANK','ONLINE');

insert into pesalink.param_configs values(1,'xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"','ACMT023 NameSpace','schema.location.actmt0023',
'ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"');

insert into pesalink.param_configs values(2,'xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"','Pacs028 NameSpace','schema.location.pac028',
'ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"');

insert into pesalink.param_configs values(3,'https://api.start.ipsl.co.ke/iso20022/sync/v1/verification-request','IPSL Verification Request url','ips.verification.request.url',
'ENABLEB','https://api.start.ipsl.co.ke/iso20022/sync/v1/verification-request'); 

insert into pesalink.param_configs values(4,'https://api.start.ipsl.co.ke/iso20022/async/v1/credit-transfer','IPSL Credit Transfer url','ips.credit.transfer.url',
'ENABLEB','https://api.start.ipsl.co.ke/iso20022/async/v1/credit-transfer'); 

insert into pesalink.param_configs values(5,'testq','Service Bus Queue Name','servicebus.queue.name','ENABLEB','testq'); 

insert into pesalink.param_configs values(6,'Endpoint=sb://sb-telco-partnership-dev.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AOR6rK8gW/Jgm4IohkDQZHgXVj8o7i2TiMo6MSuGCBI=
','Service Bus Connection String
','servicebus.connection.string',
'ENABLEB','Endpoint=sb://sb-telco-partnership-dev.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AOR6rK8gW/Jgm4IohkDQZHgXVj8o7i2TiMo6MSuGCBI=
'); 

insert into pesalink.param_configs values(7,'http://localhost:8085/v1/callback/channel','Channel Callback Url','channel.callback.url','ENABLEB','http://localhost:8085/v1/callback/channel'); 

insert into pesalink.param_configs values(8,'https://api.start.ipsl.co.ke/v1/payment-status-request','IPSL Payment Status Url','payment.status.url','ENABLEB','https://api.start.ipsl.co.ke/v1/payment-status-request'); 

  INSERT into [dbo].[param_configs] values(9,'/api/v1/transaction/process','Finacle Debit Credit Url ','finacle.DrCr.Url','ENABLEB','/api/v1/transaction/process'); 