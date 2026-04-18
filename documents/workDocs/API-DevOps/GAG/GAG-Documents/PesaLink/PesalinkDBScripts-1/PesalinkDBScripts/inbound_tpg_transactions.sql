SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tpg_transactions](
	[id] [numeric](19, 0) NOT NULL,
	[csb_response_code] [varchar](255) NULL,
	[csb_response_desc] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[dest_bank_id] [varchar](255) NULL,
	[end_to_end_id] [varchar](255) NULL,
	[fee_amount] [numeric](19, 2) NULL,
	[fee_currency] [varchar](255) NULL,
	[free_field_1] [varchar](255) NULL,
	[free_field_2] [varchar](255) NULL,
	[free_field_3] [varchar](255) NULL,
	[ips_response_code] [varchar](255) NULL,
	[ips_response_desc] [varchar](255) NULL,
	[msg_id] [varchar](255) NULL,
	[narration] [varchar](255) NULL,
	[payment_reason] [varchar](255) NULL,
	[rec_version] [int] NULL,
	[receiver_account] [varchar](255) NULL,
	[receiver_mobile] [varchar](255) NULL,
	[receiver_name] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[req_msg_hash] [text] NULL,
	[resp_msg_hash] [text] NULL,
	[sender_account] [varchar](255) NULL,
	[sender_mobile] [varchar](255) NULL,
	[sender_name] [varchar](255) NULL,
	[settle_amount] [numeric](19, 2) NULL,
	[settle_currency] [varchar](255) NULL,
	[settle_date] [datetime] NULL,
	[sig_hash] [varchar](255) NULL,
	[sig_hash_2] [varchar](255) NULL,
	[source_bank_id] [varchar](255) NULL,
	[source_channel] [varchar](255) NULL,
	[source_system] [varchar](255) NULL,
	[source_system_callback_url] [varchar](255) NULL,
	[tran_amount] [numeric](19, 2) NULL,
	[tran_currency] [varchar](255) NULL,
	[tran_date] [datetime] NULL,
	[tran_id] [varchar](255) NULL,
	[tran_status] [varchar](255) NULL,
	[tran_type] [varchar](255) NULL,
	[updated_at] [datetime] NULL,
	[val_date] [datetime] NULL,
	[cbs_response_code] [varchar](255) NULL,
	[cbs_response_desc] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tpg_transactions] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [end_to_end_id_index] ON [dbo].[tpg_transactions]
(
	[end_to_end_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [msg_id_index] ON [dbo].[tpg_transactions]
(
	[msg_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
