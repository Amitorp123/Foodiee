USE [Foddie]
GO

/****** Object:  StoredProcedure [dbo].[ContactSp]    Script Date: 08-01-2025 08:23:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ContactSp] 
	@Action varchar(10),
	@ContactId int = null,
	@Name varchar(50) = null,
	@Email varchar(50) = null,
	@Subject varchar(200) = null,
	@Message varchar(max) = null 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --INSERT 
	IF @Action = 'INSERT'
		BEGIN 
			INSERT INTO dbo.Contact(Name, Email, Subject, Message, CreatedDate)
			values(@Name, @Email, @Subject, @Message, GETDATE())
		END

	--SELECT 
	IF @Action = 'SELECT'
		BEGIN 
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],* FROM dbo.Contact
		END

	--DELETE BY ADMIN 
	IF @Action = 'DELETE'
		BEGIN 
			DELETE FROM dbo.Contact WHERE ContactId = @ContactId
		END
END
GO

