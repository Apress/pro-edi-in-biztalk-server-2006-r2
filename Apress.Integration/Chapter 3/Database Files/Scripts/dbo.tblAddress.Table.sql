USE [Apress.EDI.Custom]
GO
/****** Object:  Table [dbo].[tblAddress]    Script Date: 05/30/2007 13:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAddress](
	[uidAddressID] [uniqueidentifier] NOT NULL,
	[uidInvoiceHeaderID] [uniqueidentifier] NOT NULL,
	[vchAddressType] [nvarchar](50) NOT NULL,
	[vchAddressStreet] [nvarchar](50) NOT NULL,
	[vchCity] [nvarchar](30) NOT NULL,
	[vchState] [nvarchar](20) NOT NULL,
	[intZipCode] [int] NOT NULL,
 CONSTRAINT [PK_tblAddress] PRIMARY KEY CLUSTERED 
(
	[uidAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAddress]  WITH CHECK ADD  CONSTRAINT [FK_tblAddress_tblInvoiceHeader] FOREIGN KEY([uidInvoiceHeaderID])
REFERENCES [dbo].[tblInvoiceHeader] ([uidInvoiceID])
GO
ALTER TABLE [dbo].[tblAddress] CHECK CONSTRAINT [FK_tblAddress_tblInvoiceHeader]
GO
