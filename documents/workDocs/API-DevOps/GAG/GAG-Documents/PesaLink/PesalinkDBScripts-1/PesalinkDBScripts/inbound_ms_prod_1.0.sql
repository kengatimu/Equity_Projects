CREATE INDEX end_to_end_id_index
ON [dbo].[b2b_coms_log]([end_to_end_id]);

CREATE INDEX request_msg_id_index
ON [dbo].[b2b_coms_log]([request_msg_id]);

CREATE INDEX end_to_end_id_index
ON [dbo].[tpg_transactions]([end_to_end_id]);

CREATE INDEX msg_id_index
ON [dbo].[tpg_transactions]([msg_id]);

insert into [dbo].[param_configs] ([id]
      ,[config_bin_value]
      ,[config_desc]
      ,[config_id]
      ,[config_status]
      ,[config_value]) values 
      (1, 'https://api.stage.pesalink.co.ke/iso20022/async/v1/payment-status-report', 'IPS PAYMENT STATUS REQUEST URL', 'inbound.paymentStatusRequestURL', 'ACTIVE', 'https://api.stage.pesalink.co.ke/iso20022/async/v1/payment-status-report'),
      (2, 'https://api.stage.pesalink.co.ke/iso20022/async/v1/event-acknowledgement', 'IPS EVENT STATUS ACKNOWLEDGEMENT ENDPOINT', 'inbound.eventAckURL', 'ACTIVE', 'https://api.stage.pesalink.co.ke/iso20022/async/v1/event-acknowledgement'),
      (3, '/api/v1/transaction/process', 'TRANSACTION PROCESSOR CREDIT TRANSAFER URL', 'inbound.DRCRURL', 'ACTIVE', '/api/v1/transaction/process'),
      (4, 'https://api.stage.pesalink.co.ke/iso20022/async/v1/payment-status-report', 'IPS PAYMENT STATUS REPORT CALLBACK URL', 'inbound.paymentStatusReportCallbackURL', 'ACTIVE', 'https://api.stage.pesalink.co.ke/iso20022/async/v1/payment-status-report'),
      (5, 'https://api.stage.pesalink.co.ke/iso20022/async/v1/payment-status-report', 'IPS PAYMENT STATUS REPORT URL', 'inbound.paymentStatusReportURL', 'ACTIVE', 'https://api.stage.pesalink.co.ke/iso20022/async/v1/payment-status-report'),
      (6, 'https://api.stage.pesalink.co.ke/iso20022/sync/v1/verification-report', 'IPS ACCOUNT VERIFICATION URL', 'inbound.ipslValidationCallbackURL', 'ACTIVE', 'https://api.stage.pesalink.co.ke/iso20022/sync/v1/verification-report'),
      (7, 'true', 'SIGNATURE ENABLED', 'inbound.signatureEnabled', 'ACTIVE', 'true'),
      (8, '/api/v1/acc/get-account-name', 'IPS ACCOUNT VERIFICATION URL', 'inbound.accountValidationURL', 'ACTIVE', '/api/v1/acc/get-account-name');
