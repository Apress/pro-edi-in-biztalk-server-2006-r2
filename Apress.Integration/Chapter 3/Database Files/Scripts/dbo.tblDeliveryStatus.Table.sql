/****** Object:  Table [dbo].[tblDeliveryStatus]    Script Date: 05/30/2007 13:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDeliveryStatus](
	[uidInvoiceHeaderID] [uniqueidentifier] NOT NULL,
	[bitDeliveredFlag] [bit] NOT NULL,
 CONSTRAINT [PK_tblDeliveryStatus] PRIMARY KEY CLUSTERED 
(
	[uidInvoiceHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblDeliveryStatus]  WITH CHECK ADD  CONSTRAINT [FK_tblDeliveryStatus_tblInvoiceHeader] FOREIGN KEY([uidInvoiceHeaderID])
REFERENCES [dbo].[tblInvoiceHeader] ([uidInvoiceID])
GO
ALTER TABLE [dbo].[tblDeliveryStatus] CHECK CONSTRAINT [FK_tblDeliveryStatus_tblInvoiceHeader]
GO
