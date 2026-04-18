1. Table creation Script

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[param_configs](
	[id] [bigint] NOT NULL,
	[config_bin_value] [varchar](max) NULL,
	[config_desc] [varchar](255) NULL,
	[config_id] [varchar](255) NULL,
	[config_status] [varchar](255) NULL,
	[config_value] [varchar](3000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[param_configs] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[param_configs] ADD  CONSTRAINT [UK_emnx37cucombustxk7bowcjxy] UNIQUE NONCLUSTERED 
(
	[config_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [index_configId] ON [dbo].[param_configs]
(
	[config_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



2. Insert scripts

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"', 'ACMT023 NameSpace', 'schema.location.actmt0023','ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02"');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"', 'Pacs028 NameSpace', 'schema.location.pac028','ENABLEB','xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.028.001.04"');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('/api/v1/transaction/process', 'Finacle Debit Credit Url', 'ips.payment.status.url','ENABLEB','/api/v1/transaction/process');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('https://api.ips.pesalink.co.ke/iso20022/sync/v1/verification-request', 'IPSL Verification Request url', 'ips.verification.request.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/sync/v1/verification-request');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('https://api.ips.pesalink.co.ke/iso20022/async/v1/credit-transfer', 'IPSL Credit Transfer url', 'ips.credit.transfer.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/async/v1/credit-transfer');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('https://api.ips.pesalink.co.ke/iso20022/sync/v1/payment-status-request', 'IPSL Payment Status Url', 'ips.payment.status.url','ENABLEB','https://api.ips.pesalink.co.ke/iso20022/sync/v1/payment-status-request');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('https://102.69.239.82:8443/kba/webservices/v2/LookupDbWS?wsdl', 'Endpoint To IPSL MGW Phone Lookup', 'ipsl.mgw.phone.lookup.url','ENABLEB','https://102.69.239.82:8443/kba/webservices/v2/LookupDbWS?wsdl');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('EQUITY BANK', 'Username To IPSL MGW Phone Lookup', 'kba.inquire.username','ENABLEB','EQUITY BANK');

insert into [dbo].[param_configs] (config_bin_value, config_desc, config_id, config_status, config_value)
values ('123456', 'Password To IPSL MGW Phone Lookup', 'kba.inquire.password','ENABLEB','123456');


update [dbo].[param_configs] 
set config_value = 'Bank68InKenya', config_bin_value = 'Bank68InKenya'
where config_id = 'kba.inquire.password';

update [dbo].[param_configs] 
set config_value = 'EQUITY BANK', config_bin_value = 'EQUITY BANK'
where config_id = 'kba.inquire.username';