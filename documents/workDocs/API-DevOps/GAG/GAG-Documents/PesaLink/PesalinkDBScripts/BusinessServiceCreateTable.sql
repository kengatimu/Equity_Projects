1. Table business_param_configs

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[business_param_configs](
	[id] [bigint] NOT NULL,
	[config_id] [nvarchar](max) NOT NULL,
	[config_value] [nvarchar](max) NOT NULL,
	[config_bin_value] [text] NOT NULL,
	[config_desc] [nvarchar](max) NOT NULL,
	[config_status] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[business_param_configs] ADD  CONSTRAINT [PK_business_param_configs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


2. Table Banks

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[banks](
	[id] [bigint] NOT NULL,
	[bank_id] [nvarchar](max) NOT NULL,
	[bank_name] [nvarchar](max) NOT NULL,
	[bank_status] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[banks] ADD  CONSTRAINT [PK_banks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


