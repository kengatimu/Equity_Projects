SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[b2b_coms_log](
	[id] [numeric](19, 0) NOT NULL,
	[created_at] [datetime] NULL,
	[end_to_end_id] [varchar](255) NULL,
	[request_ack_status] [varchar](255) NULL,
	[request_msg_id] [varchar](255) NULL,
	[request_rejection_error_message] [text] NULL,
	[request_xml_message_type] [varchar](255) NULL,
	[request_xml_payload] [text] NULL,
	[response_ack_status] [varchar](255) NULL,
	[response_msg_id] [varchar](255) NULL,
	[response_rejection_error_message] [text] NULL,
	[response_xml_message_type] [varchar](255) NULL,
	[response_xml_payload] [text] NULL,
	[updated_at] [datetime] NULL,
	[time_elapsed] [varchar](255) NULL,
	[inv_xml_message_type] [varchar](255) NULL,
	[inv_xml_payload] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[b2b_coms_log] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [end_to_end_id_index] ON [dbo].[b2b_coms_log]
(
	[end_to_end_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [request_msg_id_index] ON [dbo].[b2b_coms_log]
(
	[request_msg_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
