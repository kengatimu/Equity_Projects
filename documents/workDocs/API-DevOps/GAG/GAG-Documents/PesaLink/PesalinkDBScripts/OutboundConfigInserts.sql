insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (1, 'xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"', 'ACMT023 NameSpace', 'schema.location.actmt0023','ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (2, 'xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"', 'Pacs028 NameSpace', 'schema.location.pac028','ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (3, '/api/v1/transaction/process', 'Finacle Debit Credit Url', 'ips.payment.status.url','ENABLEB','/api/v1/transaction/process');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (4, 'https://api.ips.pesalink.co.ke/iso20022/sync/v1/verification-request', 'IPSL Verification Request url', 'ips.verification.request.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/sync/v1/verification-request');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (5, 'https://api.ips.pesalink.co.ke/iso20022/async/v1/credit-transfer', 'IPSL Credit Transfer url', 'ips.credit.transfer.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/async/v1/credit-transfer');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (6, 'https://api.ips.pesalink.co.ke/iso20022/sync/v1/payment-status-request', 'IPSL Payment Status Url', 'ips.payment.status.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/sync/v1/payment-status-request');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (7, 'https://102.69.239.82:8443/kba/webservices/v2/LookupDbWS?wsdl', 'Endpoint To IPSL MGW Phone Lookup', 'ipsl.mgw.phone.lookup.url','ENABLEB','https://102.69.239.82:8443/kba/webservices/v2/LookupDbWS?wsdl');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (8, 'EQUITY BANK', 'Username To IPSL MGW Phone Lookup', 'kba.inquire.username','ENABLEB','EQUITY BANK');

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (9, '123456', 'Password To IPSL MGW Phone Lookup', 'kba.inquire.password','ENABLEB','123456');

delete from [dbo].[param_configs] where id = 10;

update [dbo].[param_configs] set config_id = 'finacle.DrCr.Url' where id = 3;

insert into [dbo].[param_configs] (id, config_bin_value, config_desc, config_id, config_status, config_value)
values (6, 'https://api.ips.pesalink.co.ke/iso20022/sync/v1/payment-status-request', 'IPSL Payment Status Url', 'ips.payment.status.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/sync/v1/payment-status-request');
