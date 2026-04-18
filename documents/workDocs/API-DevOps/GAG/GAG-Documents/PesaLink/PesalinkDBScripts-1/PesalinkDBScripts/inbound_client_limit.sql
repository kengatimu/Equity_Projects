SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client_limit](
	[id] [numeric](19, 0) NOT NULL,
	[end_date] [datetime] NULL,
	[fee_amount] [numeric](21, 2) NULL,
	[fee_currency] [varchar](255) NULL,
	[limit_status] [varchar](255) NULL,
	[source_account] [varchar](255) NULL,
	[start_date] [datetime] NULL,
	[tran_amount_max_limt] [numeric](21, 2) NULL,
	[tran_amount_max_limt_currency] [varchar](255) NULL,
	[tran_type] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[client_limit] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
