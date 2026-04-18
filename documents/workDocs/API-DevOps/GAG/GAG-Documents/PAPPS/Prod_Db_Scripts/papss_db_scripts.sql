-- ============================================================
-- 1.  SEQUENCES Creation
-- ============================================================
CREATE SEQUENCE papss_transaction_master_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;
CREATE SEQUENCE papss_sender_details_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;
CREATE SEQUENCE papss_receiver_details_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;
CREATE SEQUENCE papss_channel_info_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;
CREATE SEQUENCE papss_finacle_transaction_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;
CREATE SEQUENCE papss_callback_details_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;
CREATE SEQUENCE papss_transaction_payloads_seq START WITH 1 INCREMENT BY 10 MINVALUE 1 NOCYCLE CACHE 100 NOORDER;

-- ============================================================
-- 2.  Table - papss_transaction_master
-- ============================================================
CREATE TABLE papss_transaction_master (
    id NUMBER(19) PRIMARY KEY,
    version NUMBER(19),

    rrn VARCHAR2(255 CHAR) NOT NULL,
    finacle_rrn VARCHAR2(255 CHAR),
    end_to_end_id VARCHAR2(255 CHAR),
    papss_message_id VARCHAR2(255 CHAR),
    papss_txn_creation_time VARCHAR2(255 CHAR),

    bank_id VARCHAR2(20 CHAR) NOT NULL,
    channel_id VARCHAR2(50 CHAR) NOT NULL,
    source_system_id VARCHAR2(50 CHAR) NOT NULL,

    ips_status VARCHAR2(10 CHAR),
    ips_status_reason VARCHAR2(100 CHAR),
    ips_status_code VARCHAR2(20 CHAR),
    ips_status_description VARCHAR2(255 CHAR),

    status VARCHAR2(20 CHAR) NOT NULL,
    response_code VARCHAR2(20 CHAR),
    response_message VARCHAR2(500 CHAR),

    finacle_status VARCHAR2(20 CHAR),
    finacle_response_code VARCHAR2(20 CHAR),
    finacle_response_message VARCHAR2(500 CHAR),

    operation_type VARCHAR2(20 CHAR) NOT NULL,
    transaction_type VARCHAR2(20 CHAR) NOT NULL,

    sender_amount NUMBER(18,2) NOT NULL,
    receiver_amount NUMBER(18,2),

    papss_feeAmount NUMBER(18,2) DEFAULT 0,
    papss_fee_tax NUMBER(18,2) DEFAULT 0,
    papss_fee_amount_net NUMBER(18,2) DEFAULT 0,

    bank_feeAmount NUMBER(18,2) DEFAULT 0,
    bank_fee_tax NUMBER(18,2) DEFAULT 0,
    bank_fee_amount_net NUMBER(18,2) DEFAULT 0,

    total_tax_amount NUMBER(18,2) DEFAULT 0,

    fx_rate VARCHAR2(255 CHAR),

    transaction_currency VARCHAR2(3 CHAR) NOT NULL,
    source_currency VARCHAR2(3 CHAR),
    destination_currency VARCHAR2(3 CHAR) NOT NULL,
    destination_country VARCHAR2(20 CHAR) NOT NULL,

    payment_reason VARCHAR2(255 CHAR),
    narration VARCHAR2(255 CHAR),

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,

    CONSTRAINT uk_papss_tm_rrn UNIQUE (rrn),
    CONSTRAINT uk_papss_tm_e2e UNIQUE (end_to_end_id),
    CONSTRAINT uk_papss_tm_msg UNIQUE (papss_message_id),
    CONSTRAINT uk_papss_tm_txntime UNIQUE (papss_txn_creation_time)
);

-- ============================================================
-- 2.1  Table - papss_transaction_master Indexes
-- ============================================================
CREATE INDEX idx_status ON papss_transaction_master(status);
CREATE INDEX idx_bank_id ON papss_transaction_master(bank_id);
CREATE INDEX idx_created_at ON papss_transaction_master(created_at);
CREATE INDEX idx_channel_id ON papss_transaction_master(channel_id);
CREATE INDEX idx_transaction_type ON papss_transaction_master(transaction_type);

-- ============================================================
-- 3  Table - papss_sender_details
-- ============================================================
CREATE TABLE papss_sender_details (
    id NUMBER(19) PRIMARY KEY,
    version NUMBER(19),

    rrn VARCHAR2(255 CHAR) NOT NULL,

    institution_id VARCHAR2(20 CHAR),
    bic VARCHAR2(20 CHAR),
    country_code VARCHAR2(5 CHAR),
    currency VARCHAR2(5 CHAR),
    account_number VARCHAR2(30 CHAR),
    account_name VARCHAR2(100 CHAR),
    address VARCHAR2(255 CHAR),

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT uk_sender_rrn UNIQUE (rrn),
    CONSTRAINT fk_sender_rrn FOREIGN KEY (rrn) REFERENCES papss_transaction_master(rrn)
);

-- ============================================================
-- 4  Table - papss_receiver_details
-- ============================================================
CREATE TABLE papss_receiver_details (
    id NUMBER(19) PRIMARY KEY,
    version NUMBER(19),

    rrn VARCHAR2(255 CHAR) NOT NULL,

    institution_id VARCHAR2(20 CHAR),
    bic VARCHAR2(20 CHAR),
    country_code VARCHAR2(5 CHAR),
    currency VARCHAR2(5 CHAR),
    account_number VARCHAR2(30 CHAR),
    account_name VARCHAR2(100 CHAR),
    email_address VARCHAR2(255 CHAR),

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT uk_receiver_rrn UNIQUE (rrn),
    CONSTRAINT fk_receiver_rrn FOREIGN KEY (rrn) REFERENCES papss_transaction_master(rrn)
);

-- ============================================================
-- 5  Table - papss_channel_info
-- ============================================================
CREATE TABLE papss_channel_info (
    id NUMBER(19) PRIMARY KEY,
    version NUMBER(19),

    rrn VARCHAR2(255 CHAR) NOT NULL,

    channel_id VARCHAR2(50 CHAR) NOT NULL,
    source_system_id VARCHAR2(50 CHAR) NOT NULL,
    callback_url VARCHAR2(500 CHAR),

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT uk_channel_info_rrn UNIQUE (rrn),
    CONSTRAINT fk_channel_info_rrn FOREIGN KEY (rrn) REFERENCES papss_transaction_master(rrn)
);

-- ============================================================
-- 6  Table - papss_finacle_transaction
-- ============================================================
CREATE TABLE papss_finacle_transaction (
    id NUMBER(19) PRIMARY KEY,
    version NUMBER(19),

    rrn VARCHAR2(255 CHAR) NOT NULL,

    debit_account VARCHAR2(30 CHAR),
    credit_account VARCHAR2(30 CHAR),
    commission_account VARCHAR2(30 CHAR),

    finacle_status VARCHAR2(50 CHAR),
    finacle_response_code VARCHAR2(10 CHAR),
    finacle_response_desc VARCHAR2(500 CHAR),

    amount NUMBER(18,2),
    fee_amount NUMBER(18,2),

    transaction_currency VARCHAR2(10 CHAR) NOT NULL,
    finacle_tran_id VARCHAR2(50 CHAR),

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE,

    reversal_status VARCHAR2(50 CHAR),
    reversal_response_code VARCHAR2(10 CHAR),
    reversal_response_desc VARCHAR2(500 CHAR),

    reversal_amount NUMBER(18,2),
    reversal_fee_amount NUMBER(18,2),
    reversal_transaction_ref VARCHAR2(50 CHAR),

    reversal_created_at TIMESTAMP WITH TIME ZONE,
    reversal_completed_at TIMESTAMP WITH TIME ZONE,

    CONSTRAINT uk_finacle_rrn UNIQUE (rrn),
    CONSTRAINT fk_finacle_rrn FOREIGN KEY (rrn) REFERENCES papss_transaction_master(rrn)
);

-- ============================================================
-- 7  Table - papss_callback_details
-- ============================================================
CREATE TABLE papss_callback_details (
    id NUMBER(19) PRIMARY KEY,
    version NUMBER(19),

    rrn VARCHAR2(255 CHAR) NOT NULL,

    papss_status VARCHAR2(50 CHAR),
    papss_status_code VARCHAR2(20 CHAR),
    papss_reason_code VARCHAR2(20 CHAR),
    papss_status_description VARCHAR2(500 CHAR),

    callback_received_at TIMESTAMP WITH TIME ZONE,

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE,

    CONSTRAINT uk_callback_rrn UNIQUE (rrn),
    CONSTRAINT fk_callback_rrn FOREIGN KEY (rrn) REFERENCES papss_transaction_master(rrn)
);

-- ============================================================
-- 8  Table - papss_transaction_payload
-- ============================================================
CREATE TABLE papss_transaction_payload (
    id NUMBER(19) NOT NULL,
    version NUMBER(19),
    rrn VARCHAR2(255 CHAR) NOT NULL,

    channel_request CLOB,
    channel_response CLOB,
    channel_callback_response CLOB,

    fin_txn_iso_request BLOB,
    fin_txn_iso_response BLOB,
    fin_charges_iso_request BLOB,
    fin_charges_iso_response BLOB,
    fin_chrg_reverse_iso_request BLOB,
    fin_chrg_reverse_iso_response BLOB,
    fin_txn_reverse_iso_request BLOB,
    fin_txn_reverse_iso_response BLOB,

    created_at TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP(6) WITH TIME ZONE,

    CONSTRAINT pk_papss_transaction_payload PRIMARY KEY (id),
    CONSTRAINT uk_papss_transaction_payload_rrn UNIQUE (rrn),
    CONSTRAINT fk_papss_transaction_payload_rrn FOREIGN KEY (rrn) REFERENCES papss_transaction_master (rrn)
)

LOB (channel_request) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (channel_response) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (channel_callback_response) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_txn_iso_request) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_txn_iso_response) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_charges_iso_request) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_charges_iso_response) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_chrg_reverse_iso_request) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_chrg_reverse_iso_response) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_txn_reverse_iso_request) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
)

LOB (fin_txn_reverse_iso_response) STORE AS SECUREFILE (
    ENABLE STORAGE IN ROW
    CHUNK 8192
    NOCACHE
    LOGGING
    NOCOMPRESS
    KEEP_DUPLICATES
);
