-- Main transaction record for every payment/transfer
CREATE TABLE transaction_master (
    rrn VARCHAR(50) PRIMARY KEY, -- Channel’s Reference Number (unique)
	end_to_end_id VARCHAR(50) UNIQUE,
    bank_id VARCHAR(20),
    channel_id VARCHAR(50),
    source_system_id VARCHAR(50),
    status VARCHAR(20) NOT NULL, -- PENDING, PROCESSING, COMPLETED, FAILED, REVERSED
    response_code VARCHAR(20),
    response_message VARCHAR(500),
    transaction_type VARCHAR(20) NOT NULL, -- DEBIT, CREDIT, REVERSAL
    amount DECIMAL(18,2) NOT NULL,
    fee_amount DECIMAL(18,2) DEFAULT 0.00,
    charge_flag CHAR(1) DEFAULT 'N', -- Y/N
    is_sms_charge_included CHAR(1) DEFAULT 'N', -- Y/N
    is_velocity_enabled CHAR(1) DEFAULT 'N', -- Y/N
    payment_reason VARCHAR(100),
    narration VARCHAR(255),
    currency CHAR(3) NOT NULL, -- e.g. KES, USD
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL
);

-- Sender party details (1:1 with transaction)
CREATE TABLE sender_details (
    rrn VARCHAR(50) PRIMARY KEY,
    institution_id VARCHAR(20),
    bic VARCHAR(20),
    country_code VARCHAR(5),
    currency VARCHAR(5),
    account_number VARCHAR(30),
    account_name VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);

-- Receiver party details (1:1 with transaction)
CREATE TABLE receiver_details (
    rrn VARCHAR(50) PRIMARY KEY,
    institution_id VARCHAR(20),
    bic VARCHAR(20),
    country_code VARCHAR(5),
    currency VARCHAR(5),
    account_number VARCHAR(30),
    account_name VARCHAR(100),
    email_address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);

-- Channel info (1:1 with transaction)
CREATE TABLE channel_info (
    rrn VARCHAR(50) PRIMARY KEY,
    channel_id VARCHAR(50),
    source_system_id VARCHAR(50),
    callback_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);

-- Finacle integration log (1:1 with transaction)
CREATE TABLE finacle_transaction (
    rrn VARCHAR(50) PRIMARY KEY,
    debit_account VARCHAR(30),
    credit_account VARCHAR(30),
    finacle_status VARCHAR(50),
    finacle_response_code VARCHAR(10),
    finacle_response_desc TEXT,
    
    amount DECIMAL(18,2) NOT NULL,
    fee_amount DECIMAL(18,2) DEFAULT 0.00,
    transaction_currency VARCHAR(10),
    core_txn_ref VARCHAR(50), -- Optional Finacle reference
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Reversal related columns
    reversal_status VARCHAR(50), -- Reversal status (e.g., "PENDING", "COMPLETED", "FAILED")
    reversal_response_code VARCHAR(10),
    reversal_response_desc TEXT,
    reversal_amount DECIMAL(18,2) DEFAULT 0.00, -- Amount to be reversed
    reversal_fee_amount DECIMAL(18,2) DEFAULT 0.00, -- Fee for the reversal (if any)
    reversal_transaction_ref VARCHAR(50), -- Reversal transaction reference (optional)
    reversal_created_at TIMESTAMP, -- Timestamp when the reversal was initiated
    reversal_completed_at TIMESTAMP, -- Timestamp when the reversal was completed (if successful)

    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);


-- Callback received from PAPSS (1:1 with transaction)
CREATE TABLE papss_callback (
    rrn VARCHAR(50) PRIMARY KEY,
    callback_status VARCHAR(50), -- COMPLETED, FAILED, etc.
    callback_code VARCHAR(20),
    callback_message TEXT,
    received_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);

-- Final callback sent back to originating channel (1:1 with transaction)
CREATE TABLE channel_callback (
    rrn VARCHAR(50) PRIMARY KEY,
    callback_status VARCHAR(50),
    callback_status_code VARCHAR(50),
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);

-- Audit payloads (only for channel + Finacle) (1:1 with transaction)
CREATE TABLE payload (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    rrn VARCHAR(50) NOT NULL,
    channel_request TEXT,
    channel_response TEXT,
    channel_callback_response TEXT,
    finacle_debit_request TEXT,
    finacle_debit_response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (rrn),
    FOREIGN KEY (rrn) REFERENCES transaction_master(rrn)
);

-- Optional: Recommended indexes for performance
CREATE INDEX idx_status ON transaction_master(status);
CREATE INDEX idx_created_at ON transaction_master(created_at);
CREATE INDEX idx_channel_id ON transaction_master(channel_id);
CREATE INDEX idx_transaction_type ON transaction_master(transaction_type);
