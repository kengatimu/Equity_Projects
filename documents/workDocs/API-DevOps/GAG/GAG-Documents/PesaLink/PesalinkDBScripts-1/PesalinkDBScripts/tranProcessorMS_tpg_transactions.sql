SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tpg_transactions](
	[id] [bigint] NOT NULL,
	[msg_id] [varchar](255) NULL,
	[end_to_end_id] [varchar](255) NULL,
	[tran_type] [varchar](255) NULL,
	[tran_date] [datetime] NULL,
	[tran_amount] [decimal](21, 2) NULL,
	[tran_currency] [varchar](255) NULL,
	[settle_amount] [decimal](21, 2) NULL,
	[settle_currency] [varchar](255) NULL,
	[fee_amount] [decimal](21, 2) NULL,
	[fee_currency] [varchar](255) NULL,
	[settle_date] [datetime] NULL,
	[tran_status] [varchar](255) NULL,
	[tran_id] [varchar](255) NULL,
	[cbs_response_code] [varchar](255) NULL,
	[cbs_response_desc] [varchar](255) NULL,
	[ips_response_code] [varchar](255) NULL,
	[ips_response_desc] [varchar](255) NULL,
	[value_date] [datetime] NULL,
	[source_bank_id] [varchar](255) NULL,
	[dest_bank_id] [varchar](255) NULL,
	[sender_account] [varchar](255) NULL,
	[sender_name] [varchar](255) NULL,
	[sender_mobile] [varchar](255) NULL,
	[receiver_account] [varchar](255) NULL,
	[receiver_name] [varchar](255) NULL,
	[receiver_mobile] [varchar](255) NULL,
	[narration] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[payment_reason] [varchar](255) NULL,
	[source_channel] [varchar](255) NULL,
	[source_system] [varchar](255) NULL,
	[source_system_call_back_url] [varchar](255) NULL,
	[rec_version] [int] NULL,
	[free_field_1] [varchar](255) NULL,
	[free_field_2] [varchar](255) NULL,
	[free_field_3] [varchar](255) NULL,
	[sig_hash] [varchar](255) NULL,
	[sig_hash_2] [varchar](255) NULL,
	[req_msg_hash] [varchar](max) NULL,
	[resp_msg_hash] [varchar](max) NULL,
	[chrg_req_msg_hash] [varchar](max) NULL,
	[chrg_resp_msg_hash] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tpg_transactions] ADD  CONSTRAINT [PK_TPG_TRANSACTIONS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tpg_transactions] ADD  CONSTRAINT [ux_tpg_transactions__end_to_end_id] UNIQUE NONCLUSTERED 
(
	[end_to_end_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tpg_transactions] ADD  CONSTRAINT [ux_tpg_transactions__msg_id] UNIQUE NONCLUSTERED 
(
	[msg_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
