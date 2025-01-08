USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[Product_Crud]    Script Date: 08-01-2025 08:23:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Product_Crud] 
	@Action VARCHAR(20),
	@ProductId INT = NULL,
	@ProductName VARCHAR(100) = NULL,
	@Description VARCHAR(MAX) = NULL,
	@Price DECIMAL(18,2) = 0,
	@Quantity INT = NULL,
	@ImageUrl VARCHAR(MAX) = NULL,
	@CategoryId INT = NULL,
	@IsActive BIT = false
	
AS
BEGIN
	SET NOCOUNT ON;

    --SELECT 
	IF @Action = 'SELECT'
		BEGIN 
			SELECT p.*,c.CategoryName AS CategoryName FROM dbo.Products p
			INNER JOIN dbo.Categories c ON c.CategoryId = p.CategoryId ORDER BY p.CreatedDate DESC
		END

	--ACTIVE PRODUCT 
	IF @Action = 'ACTIVEPROD'
		BEGIN 
			SELECT p.*,c.CategoryName AS CategoryName FROM dbo.Products p
			INNER JOIN dbo.Categories c ON c.CategoryId = p.CategoryId 
			WHERE p.IsActive = 1
		END

	--INSERT
	IF @Action = 'INSERT'
		BEGIN 
			INSERT INTO dbo.Products(ProductName , Description, Price, Quantity, ImageUrl, CategoryId, IsActive, CreatedDate)
			VALUES (@ProductName, @Description, @Price, @Quantity, @ImageUrl, @CategoryId, @IsActive, GETDATE())
		END

	--UPDATE 
	IF @Action = 'UPDATE'
		BEGIN 
			DECLARE @UPDATE_IMAGE VARCHAR(20)
			SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
			IF @UPDATE_IMAGE = 'NO'
				BEGIN
					UPDATE dbo.Products
					SET ProductName = @ProductName, Description = @Description , Price = @Price, 
					Quantity = @Quantity, CategoryId = @CategoryId, IsActive = @IsActive
					WHERE ProductId = @ProductId
				END
			ELSE
				BEGIN
					UPDATE dbo.Products
					SET ProductName = @ProductName, Description = @Description , Price = @Price, ImageUrl = @ImageUrl ,
					Quantity = @Quantity, CategoryId = @CategoryId, IsActive = @IsActive
					WHERE ProductId = @ProductId
				END
		END

	--UPDATE QUANTITY 
	IF @Action = 'QTYUPDATE'
	BEGIN 
		UPDATE dbo.Products SET Quantity = @Quantity
		WHERE ProductId = @ProductId
	END

	--DELETE
	IF @Action = 'DELETE'
		BEGIN 
			DELETE FROM dbo.Products WHERE ProductId = @ProductId
		END

		--GETBYID
		IF @Action = 'GETBYID'
			BEGIN
				SELECT * FROM dbo.Products WHERE ProductId = @ProductId
			END
END
GO

