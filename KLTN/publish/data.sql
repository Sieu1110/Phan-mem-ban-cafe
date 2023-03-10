USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 12/26/2022 2:00:25 PM ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE = OFF
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'alo', N'aloha', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'K9', N'Sieu ko pro', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'staff', N'staff', N'1962026656160185351301320480154111117132155', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (37, CAST(N'2022-12-15' AS Date), CAST(N'2022-12-15' AS Date), 4, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (38, CAST(N'2022-12-15' AS Date), CAST(N'2022-12-15' AS Date), 6, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (39, CAST(N'2022-12-15' AS Date), CAST(N'2022-12-15' AS Date), 10, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (40, CAST(N'2022-12-18' AS Date), NULL, 2, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (41, CAST(N'2022-12-18' AS Date), NULL, 6, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (42, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (43, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (44, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (45, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (46, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (47, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (48, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (49, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (50, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (51, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (52, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (53, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (54, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (55, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (56, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (57, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (58, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (59, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (60, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (61, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (62, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (63, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (64, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (65, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (66, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (67, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (68, CAST(N'2022-12-24' AS Date), CAST(N'2022-12-24' AS Date), 1, 1, 0, 120000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (49, 37, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (50, 38, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (51, 39, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (54, 42, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (55, 43, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (56, 44, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (57, 45, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (58, 46, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (59, 47, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (60, 48, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (61, 49, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (62, 50, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (63, 51, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (64, 52, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (65, 53, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (66, 54, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (67, 55, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (68, 56, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (69, 57, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (70, 58, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (71, 59, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (72, 60, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (73, 61, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (74, 62, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (75, 63, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (76, 64, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (77, 65, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (78, 66, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (79, 67, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (80, 68, 1, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Mực một nắng nước sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Nghêu hấp xả', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Dú dê nướng sữa', 2, 60000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Heo rừng nướng muối ớt', 3, 75000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Cơm chiên mushi', 4, 999999)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'7Up', 5, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Cafe', 5, 12000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Hải sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Nông sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Lâm sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Sản sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Nước')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn10', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Kter') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Password]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName=@userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin
	SELECT t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateForReport]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateForReport]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name, b.totalPrice, DateCheckIn, DateCheckOut, discount
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBill]
@idTable int
as
begin
	insert Bill(DateCheckIn, DateCheckOut, idTable, status, discount)
	values (getdate(), null, @idTable, 0, 0)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBillInfo]
@idBill int, @idFood int, @count int
as
begin

	declare @isExitsBillInfo int 
	declare @foodCount int = 1

	select @isExitsBillInfo = id, @foodCount = b.count 
	from BillInfo as b 
	where idBill = @idBill and idFood=@idFood

	if (@isExitsBillInfo > 0)
	begin
		declare @newCount int =@foodCount + @count
		if(@newCount > 0)
			update BillInfo set count = @foodCount+@count where idFood = @idFood
		else
			delete BillInfo where idBill=@idBill and idFood=@idFood
	end
	else
	begin
		insert BillInfo(idBill, idFood, count)
		values (@idBill, @idFood, @count)
	end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	select * from Account where UserName=@userName and Password=@passWord
end
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTable]
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSeconrdBill INT
	
	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
	
	
	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idSeconrdBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSeconrdBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	UPDATE dbo.BillInfo SET idBill = @idSeconrdBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmty= 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 12/26/2022 2:00:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO
