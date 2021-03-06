/****** Object:  Table [dbo].[tblInvoiceHeader]    Script Date: 05/30/2007 13:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInvoiceHeader](
	[uidInvoiceID] [uniqueidentifier] NOT NULL,
	[intDocumentID] [int] NOT NULL,
	[vchInvoiceDescription] [nvarchar](50) NOT NULL,
	[vchTradingPartnerName] [nvarchar](100) NOT NULL,
	[dtmCreateDate] [datetime] NULL,
 CONSTRAINT [PK_tblInvoiceHeader] PRIMARY KEY CLUSTERED 
(
	[uidInvoiceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
