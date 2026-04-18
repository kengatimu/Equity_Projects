CREATE INDEX index_bankId ON [dbo].[banks] (bank_id); 
CREATE INDEX index_sourceAccount ON [dbo].[client_limit] (source_account); 
CREATE INDEX index_configId ON [dbo].[param_configs](config_id); 
CREATE INDEX index_messageId ON [dbo].[tpg_transactions](msg_id); 
CREATE INDEX index_endToEndId ON [dbo].[tpg_transactions](end_to_end_id); 
CREATE INDEX index_originalRequestId ON [dbo].[transaction_details](original_request_id); 
CREATE INDEX index_endToEndMsgId ON [dbo].[transaction_details](end_to_end_message_id);