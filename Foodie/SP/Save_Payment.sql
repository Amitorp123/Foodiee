USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[Save_Payment]    Script Date: 08-01-2025 08:24:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Save_Payment]
	@Name VARCHAR(100) = NULL,
	@CardNo VARCHAR (50) = NULL,
	@ExpiryDate VARCHAR (50) = NULL,
	@Cvv INT = NULL,
	@Address VARCHAR (max) = NULL,
	@PaymentMode VARCHAR (10) = 'card',
	@InsertedId int OUTPUT 
AS
BEGIN
	--SET NOCOUNT ON added to prevent extra result sets from
	--interfering with SELECT statements
	SET NOCOUNT ON;

	--INSERT
	  BEGIN
			INSERT INTO dbo.Payment(Name, CardNo, ExpiryDate, CvvNo, Address, PaymentMode)
			VALUES (@Name, @CardNo, @ExpiryDate, @Cvv, @Address, @PaymentMode)

			SELECT @InsertedId = SCOPE_IDENTITY();
	  END

END
GO

