USE [MyDemoAppDB]
GO
/****** Object:  StoredProcedure [dbo].[spGetProducts]    Script Date: 12.02.2021 08:06:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spGetProducts]
AS
BEGIN
	SELECT p.id, p.name, c.name catname, p.imageurl, p.price, p.isactive, p.description
	FROM Product p
	INNER JOIN Category c ON p.catid=c.id;
END
