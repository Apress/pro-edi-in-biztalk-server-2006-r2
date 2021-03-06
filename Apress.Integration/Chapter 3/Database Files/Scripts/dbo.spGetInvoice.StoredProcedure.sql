/****** Object:  StoredProcedure [dbo].[spGetInvoice]    Script Date: 05/30/2007 13:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Apress
-- Create date: 2007
-- Description:	Extracts a single invoice xml document
--				and updates the delivered table to indicate
--				document was delivered to external system.
--				Only one document will be returned for each
--				call to this stored procedure.
-- Sample Implementation:
-- EXEC spGetInvoice
-- =============================================
CREATE PROCEDURE [dbo].[spGetInvoice] 
AS
BEGIN
	SET NOCOUNT ON;

	--  Select invoice to be extracted
	DECLARE @uidInvoiceID As uniqueidentifier
			,@intCounter As int

	-- get the first document returned which has not already
	-- been deliverd.  Remaining documents will be processed
	-- on subsequent calls to this stored procedure.
	SET @uidInvoiceID = 
		(	SELECT TOP 1 uidInvoiceID
			FROM tblInvoiceHeader
			WHERE uidInvoiceID NOT IN (	SELECT uidInvoiceHeaderID 
										FROM tblDeliveryStatus
										WHERE bitDeliveredFlag = 1)
			ORDER BY dtmCreateDate
		)

	-- Only execute the code if an ID is present
	IF @uidInvoiceID IS NOT NULL
	BEGIN
		-- wrapping in a tran can be useful if running multiple updates
		-- shown here for demonstration purposes
		BEGIN TRAN	
			BEGIN TRY

				-- generate XML Document as result set
				-- note that BizTalk will add its own root node when
				-- extracted using the SQL Receive Adapter

				-- the DOCID is unique, and can be used to trace
				-- document throughout entire process
				SELECT	NULL
						,(	SELECT	uidInvoiceID AS "GUID"
									,intDocumentID AS "DOCID"
									,vchInvoiceDescription AS "DESC"
									,vchTradingPartnerName AS "PARTNER"
							FROM tblInvoiceHeader
							WHERE uidInvoiceID = @uidInvoiceID
							FOR XML PATH('HEADER'), BINARY BASE64, TYPE)
						,(	SELECT	NULL
									,(	SELECT	vchAddressType AS "TYPE"
												,vchAddressStreet AS "STREET"
												,vchCity AS "CITY"
												,vchState AS "STATE"
												,intZipCode AS "ZIP"
										FROM tblAddress
										WHERE uidInvoiceHeaderID = @uidInvoiceID
										FOR XML PATH('ADDRESS'), BINARY BASE64, TYPE)
							FOR XML PATH('ADDRESSES'), BINARY BASE64, TYPE)
						,(	SELECT NULL
									,(	SELECT	vchType AS "TYPE"
												,mnyPrice AS "PRICE"
												,vchItemDescription AS "DESC"
												,intQuantity AS "QTY"
										FROM tblInvoiceLineItems
										WHERE uidInvoiceHeaderID = @uidInvoiceID
										FOR XML PATH('ITEM'), BINARY BASE64, TYPE)
							FOR XML PATH('ITEMS'), BINARY BASE64, TYPE)
				FOR XML PATH('TRANSACTION'), BINARY BASE64

				-- Now set the delivered flag in the table to "true"
				UPDATE tblDeliveryStatus 
				SET bitDeliveredFlag = 1
				WHERE uidInvoiceHeaderID = @uidInvoiceID

			END TRY
			BEGIN CATCH
				-- error occurred, rollback
				ROLLBACK TRAN
				RETURN @@ERROR
			END CATCH
		-- success
		COMMIT TRAN
	END
	
END
GO
