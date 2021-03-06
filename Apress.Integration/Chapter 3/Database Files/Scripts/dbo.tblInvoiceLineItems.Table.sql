/****** Object:  Table [dbo].[tblInvoiceLineItems]    Script Date: 05/30/2007 13:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInvoiceLineItems](
	[uidLineItemID] [uniqueidentifier] NOT NULL,
	[uidInvoiceHeaderID] [uniqueidentifier] NOT NULL,
	[vchType] [varchar](20) NOT NULL,
	[mnyPrice] [money] NOT NULL,
	[intQuantity] [int] NOT NULL,
	[vchItemDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblInvoiceLineItems] PRIMARY KEY CLUSTERED 
(
	[uidLineItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tblInvoiceLineItems]  WITH CHECK ADD  CONSTRAINT [FK_tblInvoiceLineItems_tblInvoiceHeader] FOREIGN KEY([uidInvoiceHeaderID])
REFERENCES [dbo].[tblInvoiceHeader] ([uidInvoiceID])
GO
ALTER TABLE [dbo].[tblInvoiceLineItems] CHECK CONSTRAINT [FK_tblInvoiceLineItems_tblInvoiceHeader]
GO
