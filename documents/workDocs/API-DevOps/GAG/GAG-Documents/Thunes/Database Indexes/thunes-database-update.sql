
Insert into  [dbo].[imt_core_configs] values(729,'6f77cb91-bc26-49c1-9e1f-42d760730570', 'Thunes DRC AuthKey', 'thunes.cod.auth.key', '6f77cb91-bc26-49c1-9e1f-42d760730570');
Insert into  [dbo].[imt_core_configs] values(730,'6a68e1b5-9129-4f30-83f7-1c2bfd307a5e', 'Thunes DRC AuthSecret', 'thunes.cod.auth.secret', '6a68e1b5-9129-4f30-83f7-1c2bfd307a5e');

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/quotations', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/quotations' 
where config_id = 'thunes.quotation.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/payers/PayerId/rates', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/payers/PayerId/rates' 
where config_id = 'thunes.get.rate.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/payment', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/payment' 
where config_id = 'thunes.payment.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/payers', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/payers' 
where config_id = 'thunes.payers.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/quotations/QUOTATION_ID/transactions', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/quotations/QUOTATION_ID/transactions' 
where config_id = 'thunes.transaction.create.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/transactions/QUOTATION_ID/confirm', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/transactions/QUOTATION_ID/confirm' 
where config_id = 'thunes.transaction.confirm.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/transactions/QUOTATION_ID', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/transactions/QUOTATION_ID' 
where config_id = 'thunes.transaction.status.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/payers/PAYER_ID/TRANSACTION_TYPE/credit-party-information', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/payers/PAYER_ID/TRANSACTION_TYPE/credit-party-information' 
where config_id = 'thunes.credit.party.lookup.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/payers/PAYER_ID/TRANSACTION_TYPE/credit-party-verification', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/payers/PAYER_ID/TRANSACTION_TYPE/credit-party-verification' 
where config_id = 'thunes.credit.party.verify.url';

update  [dbo].[imt_core_configs] set config_bin_value='https://api-mt.pre.thunes.com/v2/money-transfer/lookups/BIC/BIC_CODE', config_value = 'https://api-mt.pre.thunes.com/v2/money-transfer/lookups/BIC/BIC_CODE' 
where config_id = 'thunes.bic.lookup.url';

















