USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[Review]    Script Date: 08-01-2025 08:23:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Review] 
	@Action varchar(10),
	@ReviewId int = null,
	@Review varchar(200) = null,
	@Name varchar(50) = null,
	@Address varchar(50) = null,
	@ImageUrl VARCHAR(MAX) = NULL,
	@IsActive BIT = false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --INSERT 
	IF @Action = 'INSERT'
		BEGIN 
			INSERT INTO dbo.Reviews (Review, Name, Address, ImageUrl, IsActive, PostedOn)
			values(@Review, @Name, @Address, @ImageUrl, @IsActive, GETDATE())
		END

	--ACTIVE REVIEW
	IF @Action = 'ACTIVEREV'
		BEGIN 
			SELECT * FROM dbo.Reviews WHERE IsActive = 1 
		END

	--SELECT 
	IF @Action = 'SELECT'
		BEGIN 
			SELECT * FROM dbo.Reviews ORDER BY PostedOn DESC
		END
	

	----DELETE BY ADMIN 
	--IF @Action = 'DELETE'
	--	BEGIN 
	--		DELETE FROM dbo.Contact WHERE ContactId = @ReviewId
	--	END
END
GO

