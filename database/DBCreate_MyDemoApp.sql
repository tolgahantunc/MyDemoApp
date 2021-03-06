USE [MyDemoAppDB]
GO
/****** Object:  StoredProcedure [dbo].[spGetProducts]    Script Date: 12.02.2021 08:06:19 ******/
DROP PROCEDURE [dbo].[spGetProducts]
GO
/****** Object:  StoredProcedure [dbo].[spGetCategories]    Script Date: 12.02.2021 08:06:19 ******/
DROP PROCEDURE [dbo].[spGetCategories]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Category]
GO
/****** Object:  Table [dbo].[User]    Script Date: 12.02.2021 08:06:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12.02.2021 08:06:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Role]') AND type in (N'U'))
DROP TABLE [dbo].[Role]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12.02.2021 08:06:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
DROP TABLE [dbo].[Product]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12.02.2021 08:06:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
DROP TABLE [dbo].[Category]
GO
USE [master]
GO
/****** Object:  Database [MyDemoAppDB]    Script Date: 12.02.2021 08:06:19 ******/
DROP DATABASE [MyDemoAppDB]
GO
/****** Object:  Database [MyDemoAppDB]    Script Date: 12.02.2021 08:06:19 ******/
CREATE DATABASE [MyDemoAppDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyDemoAppDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MyDemoAppDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyDemoAppDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MyDemoAppDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE SQL_Latin1_General_CP1_CI_AS
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MyDemoAppDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyDemoAppDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyDemoAppDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyDemoAppDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyDemoAppDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyDemoAppDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyDemoAppDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MyDemoAppDB] SET  MULTI_USER 
GO
ALTER DATABASE [MyDemoAppDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyDemoAppDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyDemoAppDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyDemoAppDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyDemoAppDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyDemoAppDB', N'ON'
GO
ALTER DATABASE [MyDemoAppDB] SET QUERY_STORE = OFF
GO
ALTER AUTHORIZATION ON DATABASE::[MyDemoAppDB] TO [TOLGAHAN-PC\Tolgahan Tunç]
GO
USE [MyDemoAppDB]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12.02.2021 08:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Category] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12.02.2021 08:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[catid] [int] NOT NULL,
	[imageurl] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[price] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[isactive] [bit] NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Product] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12.02.2021 08:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Role] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[User]    Script Date: 12.02.2021 08:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[password] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[roleid] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[User] TO  SCHEMA OWNER 
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name]) VALUES (1, N'tek_atista_vuran_silahh')
INSERT [dbo].[Category] ([id], [name]) VALUES (2, N'bes_atista_vuran_silah')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [catid], [imageurl], [price], [isactive], [description]) VALUES (4, N'silah01', 1, N'silah01.png', N'1500', 1, N'silah01 aciklama')
INSERT [dbo].[Product] ([id], [name], [catid], [imageurl], [price], [isactive], [description]) VALUES (6, N'silah02', 2, N'silah02.png', N'750', 1, N'silah02 aciklama')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [name]) VALUES (1, N'product_view')
INSERT [dbo].[Role] ([id], [name]) VALUES (2, N'login')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [username], [password], [roleid]) VALUES (1, N'tolgahan', N'123456', 1)
INSERT [dbo].[User] ([id], [username], [password], [roleid]) VALUES (2, N'tolunay', N'123456', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([catid])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([roleid])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  StoredProcedure [dbo].[spGetCategories]    Script Date: 12.02.2021 08:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetCategories]
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
GO
ALTER AUTHORIZATION ON [dbo].[spGetCategories] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[spGetProducts]    Script Date: 12.02.2021 08:06:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetProducts]
AS
BEGIN
	SELECT p.id, p.name, c.name catname, p.imageurl, p.price, p.isactive, p.description
	FROM Product p
	INNER JOIN Category c ON p.catid=c.id;
END
GO
ALTER AUTHORIZATION ON [dbo].[spGetProducts] TO  SCHEMA OWNER 
GO
USE [master]
GO
ALTER DATABASE [MyDemoAppDB] SET  READ_WRITE 
GO
