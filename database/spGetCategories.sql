USE [MyDemoAppDB]
GO
/****** Object:  StoredProcedure [dbo].[spGetCategories]    Script Date: 12.02.2021 08:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spGetCategories]
AS
BEGIN
	WITH tblCat (catId, catName) AS
	(
		SELECT id, name
		FROM Category
	)
	SELECT catId, catName
	FROM tblCat
END
