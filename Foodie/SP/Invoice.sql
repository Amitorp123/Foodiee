USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[Invoice]    Script Date: 08-01-2025 08:23:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Invoice]
	@Action VARCHAR(10),
	@PaymentId INT = NULL,
	@UserId INT = NULL,
	@OrderDetailId INT = NULL,
	@Status VARCHAR(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --GET INVOICE BY ID
   IF @Action = 'INVOICBYID'
	BEGIN
		SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo], o.OrderNo, p.ProductName, p.Price, o.Quantity, 
		(p.Price * o.Quantity) as TotalPrice, o.OrderDate, o. Status FROM Orders o 
		INNER JOIN Products p ON p.ProductId = o.ProductId
		WHERE o.PaymentId = @PaymentId AND o.UserId = @UserId
	END

	--SELECT ORDER HISTORY
	IF @Action = 'ODRHISTORY'
	  BEGIN
			SELECT DISTINCT o.PaymentId, p.PaymentMode, p.CardNo FROM Orders o
			INNER JOIN Payment p on p.PaymentId = o.PaymentId
			WHERE o.UserId = @UserId
	  END

	--GET ORDER STATUS
	IF @Action = 'GETSTATUS'
		BEGIN
			SELECT o.OrderDetailId, o.OrderNo, (pr.Price * o.Quantity) as TotalPrice, o.Status, o.OrderDate, p.PaymentMode, pr.ProductName FROM Orders o
			INNER JOIN Payment p ON p.PaymentId = o.PaymentId
			INNER JOIN Products pr ON pr.ProductId = o.ProductId
		END

	--GET ORDERS STATUS BY ID
	IF @Action = 'STATUSBYID'
		BEGIN
			SELECT OrderDetailId, Status FROM Orders
			WHERE OrderDetailId = @OrderDetailId
		END

	--UPDATE ORDER STATUS
	IF @Action = 'UPDSTATUS'
		BEGIN
			UPDATE dbo.Orders
			SET Status =@Status WHERE OrderDetailId = @OrderDetailId
		END
END
GO

