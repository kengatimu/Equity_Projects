1. Table creation Script

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[business_param_configs](
	[id] [bigint] NOT NULL,
	[config_id] [nvarchar](max) NOT NULL,
	[config_value] [nvarchar](max) NOT NULL,
	[config_bin_value] [text] NOT NULL,
	[config_desc] [nvarchar](max) NOT NULL,
	[config_status] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[business_param_configs] ADD  CONSTRAINT [PK_business_param_configs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


2. Insert Scripts

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('aml-fraud-check-endpoint', 'http://10.9.64.57:8062/fraud/v1/score', 'http://10.9.64.57:8062/fraud/v1/score','AML Fraud Check Endpoint',' ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('aml.fraud.check',  'true',  'true','AML Fraud Check Flag',' ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('customer-limit-defaut',  '300000', '300000', 'Default Customer Limit', 'ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('outBoundMs-accountVerification-endpoint',  '/api/v1/verification-request', '/api/v1/verification-request', 'Account Verification Endpoint For Outbound MS', 'ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('outBoundMs-creditTransfer-endpoint',  '/api/v1/credit-transfer',  '/api/v1/credit-transfer', 'Credit Transfer Endpoint For Outbound MS', 'ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('outBoundMs-paymentStatusRequest-endpoint',  '/api/v1/payment-status-request', '/api/v1/payment-status-request', 'Payment Status Request Endpoint For Outbound MS', 'ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status)
values ('max_amount_for_zero_charge', '1000', '1000', 'Maximum amount for zero charge', 'ENABLED');

insert into [dbo].[business_param_configs] (config_id, config_value, config_bin_value, config_desc, config_status) 
values ('ipsl-mgw-phone-lookup-endpoint', 'https://102.69.239.82:8443/kba/webservices/v2/LookupDbWS?wsdl', 'https://102.69.239.82:8443/kba/webservices/v2/LookupDbWS?wsdl', 'Endpoint To IPSL MGW Phone Lookup', 'ENABLED');