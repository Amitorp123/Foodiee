USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[SellingReport]    Script Date: 08-01-2025 08:24:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SellingReport]
	@FromDate Date = null,
	@ToDate Date = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo], u.Name, u.Email,
		SUM(o.Quantity) AS TotalOrders, SUM(o.Quantity * p.Price) AS TotalPrice
		FROM Orders o
		INNER JOIN Products p ON p.ProductId = o.ProductId
		INNER JOIN Users u ON u.UserId = o.UserId
		WHERE CAST(o.OrderDate AS DATE) BETWEEN @FromDate AND @ToDate
		GROUP BY u.Name, u.Email
END
GO

