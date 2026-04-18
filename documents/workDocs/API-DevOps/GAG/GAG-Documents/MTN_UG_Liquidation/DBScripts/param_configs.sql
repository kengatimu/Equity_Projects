 Insert Data

insert into param_configs (id, config_bin_value, config_desc, config_id, config_status, config_value, deleted)
values
(1,'https://212.88.125.189:8033/poextvip/v1/debit', 'MTN UG Deposit URL Dev', 'MTNUG.DEPOSIT.URL.DEV', 'ENABLED', 'https://212.88.125.189:8033/poextvip/v1/debit', 'N'),
(2,'https://212.88.125.189:8033/poextvip/v1/getaccountholderinfo', 'MTN UG Namecheck URL Dev', 'MTNUG.NAMECHECK.URL.DEV', 'ENABLED', 'https://212.88.125.189:8033/poextvip/v1/getaccountholderinfo', 'N'),
(3,'https://212.88.125.189:8033/poextvip/v1/refund', 'MTN UG Refund URL Dev', 'MTNUG.REFUND.URL', 'ENABLED', 'https://212.88.125.189:8033/poextvip/v1/refund', 'N'),
(4,'https://212.88.125.189:8033/poextvip/v1_1/gettransactionstatus', 'MTN UG Transaction Status Check URL Dev', 'MTNUG.STATUS.CHECK.URL.DEV', 'ENABLED', 'https://212.88.125.189:8033/poextvip/v1_1/gettransactionstatus', 'N'),
(5,'Monitoring@123*', 'MTN UG Pass Phrase Dev', 'MTNUG.PASS.PHRASE.DEV', 'ENABLED', 'Monitoring@123*', 'N'),
(6,'<?xml version="1.0" encoding="UTF-8"?><ns0:debitcompletedresponse xmlns:ns0="http://www.ericsson.com/em/emm/callback/v1_0"/>', 'MTNUG Callback Response', 'MTNUG.CALLBACK.RESPONSE', 'ENABLED', '<?xml version="1.0" encoding="UTF-8"?><ns0:debitcompletedresponse xmlns:ns0="http://www.ericsson.com/em/emm/callback/v1_0"/>', 'N');

