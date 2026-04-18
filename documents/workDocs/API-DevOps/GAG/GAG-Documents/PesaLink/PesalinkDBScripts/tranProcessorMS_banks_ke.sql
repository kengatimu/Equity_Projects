SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[banks_ke](
	[pic_code] [varchar](255) NOT NULL,
	[bank_code] [varchar](255) NULL,
	[bank_names] [varchar](255) NULL,
	[bank_short_name] [varchar](255) NULL,
	[bic_code] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[id] [bigint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[banks_ke] ADD PRIMARY KEY CLUSTERED 
(
	[pic_code] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
