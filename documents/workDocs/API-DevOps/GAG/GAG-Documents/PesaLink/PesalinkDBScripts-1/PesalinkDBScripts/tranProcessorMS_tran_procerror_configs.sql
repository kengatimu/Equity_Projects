SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tran_processor_configs](
	[id] [bigint] NOT NULL,
	[config_bin_value] [varchar](max) NULL,
	[config_desc] [varchar](255) NULL,
	[config_id] [varchar](255) NULL,
	[config_status] [varchar](255) NULL,
	[config_value] [varchar](3000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tran_processor_configs] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tran_processor_configs] ADD  CONSTRAINT [UK_6mhy3d0302rf8su4b352v2mbi] UNIQUE NONCLUSTERED 
(
	[config_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
