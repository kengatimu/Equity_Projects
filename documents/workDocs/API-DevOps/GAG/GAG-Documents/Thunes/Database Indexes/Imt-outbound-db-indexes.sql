TABLE INDEXES

Database: <Production Oracle Database>
Note: Inclued the schema on the table name. ie. <schema_name>.<table_name>

1. Table: imt_out_bound_tran
    CREATE INDEX index_status ON imt_out_bound_tran(status);
    CREATE INDEX index_transaction_id ON imt_out_bound_tran(transaction_id);
    CREATE INDEX index_reference_number ON imt_out_bound_tran(reference_number);
    CREATE INDEX index_transaction_type ON imt_out_bound_tran(transaction_type);
     
2. Table: imt_out_bound_thunes_Logger
    CREATE INDEX index_rrn ON imt_out_bound_thunes_Logger(rrn);
    
3. Table: imt_core_configs
    CREATE INDEX index_config_id ON imt_core_configs(config_id);
    
4. View The Indexes
    SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('<schema_name>.<table_name>');
    