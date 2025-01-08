USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[Dashboard]    Script Date: 08-01-2025 08:23:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Dashboard]
	@Action varchar(20) = null
AS
BEGIN
		SET NOCOUNT ON;

		--1. Categories
		IF @Action = 'CATEGORY'
		BEGIN
			SELECT COUNT(*) FROM dbo.Categories
		END

		--2. Products
		IF @Action = 'PRODUCT'
		BEGIN
			SELECT COUNT(*) FROM dbo.Products
		END

		--3. Orders
		IF @Action = 'ORDER'
		BEGIN
			SELECT COUNT(*) FROM dbo.Orders
		END

		--4. Orders Delivered
		IF @Action = 'DELIVERED'
		BEGIN
			SELECT COUNT(*) FROM dbo.Orders
			WHERE Status = 'Delivered'
		END

		--5. Orders Pending
		IF @Action = 'PENDING'
		BEGIN
			SELECT COUNT(*) FROM dbo.Orders
			WHERE Status IN ('Pending' , 'Dispatched')
		END

		--6. Users
		IF @Action = 'USER'
		BEGIN
			SELECT COUNT(*) FROM dbo.Users
		END

		--7. Sold Item Cost
		IF @Action = 'SOLDAMOUNT'
		BEGIN
			SELECT SUM(o.Quantity * p.Price) FROM Orders o
			INNER JOIN Products p ON p.ProductId = o.ProductId
		END

		--8. Contact
		IF @Action = 'CONTACT'
		BEGIN
			SELECT COUNT(*) FROM dbo.Contact
		END
END
GO

