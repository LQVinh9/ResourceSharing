USE [master]
GO
/****** Object:  Database [ResourceSharing]    Script Date: 5/30/2021 11:58:50 AM ******/
CREATE DATABASE [ResourceSharing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ResourceSharing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\ResourceSharing.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ResourceSharing_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\ResourceSharing_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ResourceSharing] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ResourceSharing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ResourceSharing] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ResourceSharing] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ResourceSharing] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ResourceSharing] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ResourceSharing] SET ARITHABORT OFF 
GO
ALTER DATABASE [ResourceSharing] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ResourceSharing] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ResourceSharing] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ResourceSharing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ResourceSharing] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ResourceSharing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ResourceSharing] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ResourceSharing] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ResourceSharing] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ResourceSharing] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ResourceSharing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ResourceSharing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ResourceSharing] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ResourceSharing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ResourceSharing] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ResourceSharing] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ResourceSharing] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ResourceSharing] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ResourceSharing] SET  MULTI_USER 
GO
ALTER DATABASE [ResourceSharing] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ResourceSharing] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ResourceSharing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ResourceSharing] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ResourceSharing] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ResourceSharing] SET QUERY_STORE = OFF
GO
USE [ResourceSharing]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ResourceSharing]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[bookingID] [nvarchar](10) NOT NULL,
	[date] [datetime] NOT NULL,
	[userID] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[bookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingDetail]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetail](
	[bookingDetailID] [nvarchar](10) NOT NULL,
	[quantity] [int] NOT NULL,
	[dateBorrow] [date] NOT NULL,
	[statusRequest] [nvarchar](20) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[itemID] [nvarchar](10) NOT NULL,
	[bookingID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[bookingDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryID] [nvarchar](10) NOT NULL,
	[categoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[itemID] [nvarchar](10) NOT NULL,
	[itemName] [nvarchar](100) NOT NULL,
	[color] [nvarchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[image] [nvarchar](500) NOT NULL,
	[levelID] [nvarchar](10) NOT NULL,
	[categoryID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[itemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Level]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Level](
	[levelID] [nvarchar](10) NOT NULL,
	[levelName] [nvarchar](30) NULL,
 CONSTRAINT [PK_Level] PRIMARY KEY CLUSTERED 
(
	[levelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleID] [nvarchar](10) NOT NULL,
	[roleName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/30/2021 11:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [nvarchar](100) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[address] [nvarchar](300) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[codeRegister] [nvarchar](20) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[roleID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'0uJlD', CAST(N'2021-05-23T13:42:42.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'4MfiX', CAST(N'2021-05-18T21:42:55.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'5mNej', CAST(N'2021-05-20T10:45:52.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'5sW2p', CAST(N'2021-05-23T13:42:57.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'A3sxj', CAST(N'2021-05-24T11:42:16.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'aLDt4', CAST(N'2021-05-19T12:44:08.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'BAMGM', CAST(N'2021-05-19T12:50:33.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'CEKqM', CAST(N'2021-05-19T12:14:19.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'D9rF3', CAST(N'2021-05-18T21:53:58.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'dVDFf', CAST(N'2021-05-19T13:21:41.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'e2I6Y', CAST(N'2021-05-30T11:32:32.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'eI4KC', CAST(N'2021-05-21T17:04:44.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'elHMQ', CAST(N'2021-05-25T13:04:14.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'ezlun', CAST(N'2021-05-23T13:22:56.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'F36kM', CAST(N'2021-05-28T12:28:24.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'g6jyT', CAST(N'2021-05-19T13:18:50.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'gPkwA', CAST(N'2021-05-23T20:24:37.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'hCuGA', CAST(N'2021-05-19T12:38:52.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'HdcSI', CAST(N'2021-05-19T13:01:43.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'hsv4N', CAST(N'2021-05-21T12:40:28.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'iFHRF', CAST(N'2021-05-23T13:23:10.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'iXuf3', CAST(N'2021-05-19T13:29:34.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'jAIVN', CAST(N'2021-05-19T12:36:19.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'JPsPw', CAST(N'2021-05-20T10:36:50.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'kGXcN', CAST(N'2021-05-24T00:02:49.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'KUwuQ', CAST(N'2021-05-19T19:45:48.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'KZbHA', CAST(N'2021-05-30T11:34:29.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'LEpaV', CAST(N'2021-05-25T09:02:34.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'mMOUb', CAST(N'2021-05-28T23:23:55.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'mqna8', CAST(N'2021-05-22T12:59:18.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'nbogz', CAST(N'2021-05-21T17:05:59.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'OiyGW', CAST(N'2021-05-19T12:34:16.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'OrXrZ', CAST(N'2021-05-19T12:46:28.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'P6YvB', CAST(N'2021-05-19T22:14:50.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'pNWtL', CAST(N'2021-05-23T13:43:40.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'QCGcL', CAST(N'2021-05-27T07:35:35.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'ql4vA', CAST(N'2021-05-24T00:01:20.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'RvuY3', CAST(N'2021-05-23T13:34:54.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'RyqAS', CAST(N'2021-05-23T20:48:36.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'SNeaE', CAST(N'2021-05-19T12:45:03.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'tcjF0', CAST(N'2021-05-20T07:46:06.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'tKHl5', CAST(N'2021-05-28T14:43:50.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'uwF5V', CAST(N'2021-05-19T19:23:49.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'VeqKk', CAST(N'2021-05-24T00:03:20.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'vIrJ1', CAST(N'2021-05-19T19:40:04.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'WBnMN', CAST(N'2021-05-21T12:47:57.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'wke4Y', CAST(N'2021-05-25T21:47:34.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'WYIqw', CAST(N'2021-05-19T12:31:50.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'xPLy7', CAST(N'2021-05-20T12:11:27.000' AS DateTime), N'lqvinhh2000@gmail.com')
GO
INSERT [dbo].[Booking] ([bookingID], [date], [userID]) VALUES (N'yrhkL', CAST(N'2021-05-20T13:09:54.000' AS DateTime), N'levinhh2000@gmail.com')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'14xmE', 2, CAST(N'2021-05-29' AS Date), N'Delete', N'True', N'P16', N'RvuY3')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'1AOyt', 1, CAST(N'2021-05-29' AS Date), N'Delete', N'True', N'P16', N'0uJlD')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'1kGBK', 3, CAST(N'2021-06-07' AS Date), N'Delete', N'False', N'P20', N'F36kM')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'29UAA', 1, CAST(N'2021-05-21' AS Date), N'New', N'True', N'P06', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'3bqIt', 1, CAST(N'2021-05-28' AS Date), N'Delete', N'True', N'P03', N'pNWtL')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'579Xo', 1, CAST(N'2021-05-25' AS Date), N'Delete', N'True', N'P06', N'mqna8')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'5doIm', 1, CAST(N'2021-05-23' AS Date), N'Delete', N'False', N'P20', N'JPsPw')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'5rbXo', 2, CAST(N'2021-05-21' AS Date), N'Delete', N'False', N'P03', N'5mNej')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'5Xpeg', 3, CAST(N'2021-05-28' AS Date), N'Accept', N'True', N'P03', N'iFHRF')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'5y9hl', 1, CAST(N'2021-05-29' AS Date), N'Accept', N'True', N'P06', N'RvuY3')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'9takC', 2, CAST(N'2021-06-05' AS Date), N'Accept', N'True', N'P12', N'e2I6Y')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'A0x5F', 2, CAST(N'2021-05-31' AS Date), N'Delete', N'True', N'P15', N'elHMQ')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'a0ZRR', 1, CAST(N'2021-05-27' AS Date), N'Accept', N'False', N'P06', N'gPkwA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'agEvt', 4, CAST(N'2021-06-12' AS Date), N'New', N'True', N'P16', N'tKHl5')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'BThiT', 2, CAST(N'2021-05-30' AS Date), N'Delete', N'True', N'P03', N'RyqAS')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'cmOAy', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P03', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'CU6sJ', 4, CAST(N'2021-05-28' AS Date), N'Delete', N'True', N'P03', N'ezlun')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'CWtrT', 1, CAST(N'2021-05-29' AS Date), N'Accept', N'True', N'P09', N'0uJlD')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'CXe4u', 2, CAST(N'2021-05-27' AS Date), N'New', N'False', N'P16', N'xPLy7')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'd2oo6', 1, CAST(N'2021-05-27' AS Date), N'Delete', N'False', N'P03', N'hsv4N')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'e6QT9', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P01', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Ei5bk', 3, CAST(N'2021-05-30' AS Date), N'Delete', N'True', N'P02', N'RyqAS')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'F0ytZ', 4, CAST(N'2021-05-26' AS Date), N'New', N'True', N'P01', N'ql4vA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Ffcnf', 1, CAST(N'2021-06-06' AS Date), N'Delete', N'True', N'P06', N'e2I6Y')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'FOHlZ', 1, CAST(N'2021-05-30' AS Date), N'New', N'True', N'P01', N'RyqAS')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'G2NVP', 1, CAST(N'2021-05-30' AS Date), N'Accept', N'True', N'P04', N'LEpaV')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Gh1XT', 1, CAST(N'2021-05-29' AS Date), N'Delete', N'True', N'P13', N'0uJlD')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'gThgp', 1, CAST(N'2021-05-29' AS Date), N'Accept', N'True', N'P03', N'5sW2p')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'HDZn7', 2, CAST(N'2021-06-04' AS Date), N'Accept', N'True', N'P06', N'mMOUb')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'i537B', 2, CAST(N'2021-05-20' AS Date), N'Accept', N'False', N'P03', N'OiyGW')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'i9YGW', 3, CAST(N'2021-05-25' AS Date), N'New', N'True', N'P03', N'VeqKk')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'IWkGY', 2, CAST(N'2021-05-20' AS Date), N'Accept', N'False', N'P03', N'4MfiX')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'iXAB6', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P10', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'JeQzg', 4, CAST(N'2021-06-10' AS Date), N'Accept', N'True', N'P19', N'KZbHA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'jmjEA', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P13', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'jNeYU', 1, CAST(N'2021-05-30' AS Date), N'Accept', N'True', N'P06', N'QCGcL')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'JPJTY', 3, CAST(N'2021-05-22' AS Date), N'New', N'False', N'P07', N'5mNej')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'k1bac', 2, CAST(N'2021-05-21' AS Date), N'Delete', N'True', N'P19', N'yrhkL')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'K1VM5', 2, CAST(N'2021-06-09' AS Date), N'Delete', N'True', N'P02', N'KZbHA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Kfx9N', 1, CAST(N'2021-05-23' AS Date), N'Delete', N'False', N'P01', N'mqna8')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'KMtz9', 1, CAST(N'2021-06-06' AS Date), N'New', N'False', N'P15', N'F36kM')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'KT9eO', 1, CAST(N'2021-05-29' AS Date), N'Delete', N'True', N'P01', N'RvuY3')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'KyPOO', 1, CAST(N'2021-05-30' AS Date), N'Accept', N'False', N'P03', N'gPkwA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Le6fL', 1, CAST(N'2021-05-29' AS Date), N'Accept', N'True', N'P01', N'gPkwA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'LgDXo', 1, CAST(N'2021-05-25' AS Date), N'Delete', N'True', N'P06', N'A3sxj')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'lQPbf', 6, CAST(N'2021-06-05' AS Date), N'Accept', N'True', N'P10', N'F36kM')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'LVq9t', 1, CAST(N'2021-05-29' AS Date), N'Accept', N'True', N'P07', N'0uJlD')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'nCAG9', 1, CAST(N'2021-05-21' AS Date), N'New', N'True', N'P03', N'eI4KC')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'NkaXl', 4, CAST(N'2021-06-04' AS Date), N'Delete', N'False', N'P10', N'mMOUb')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'ntbbE', 2, CAST(N'2021-05-22' AS Date), N'Delete', N'True', N'P21', N'nbogz')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'ORsp2', 3, CAST(N'2021-06-11' AS Date), N'New', N'True', N'P12', N'tKHl5')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'OVzmF', 1, CAST(N'2021-05-24' AS Date), N'Accept', N'True', N'P03', N'mqna8')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'qs01n', 1, CAST(N'2021-05-23' AS Date), N'New', N'False', N'P01', N'hsv4N')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'R2XHe', 1, CAST(N'2021-05-20' AS Date), N'New', N'False', N'P06', N'JPsPw')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'R6zEU', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P07', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'R8ewD', 2, CAST(N'2021-05-29' AS Date), N'Delete', N'False', N'P03', N'KUwuQ')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'rGn0c', 1, CAST(N'2021-05-29' AS Date), N'Accept', N'False', N'P10', N'elHMQ')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'rivc3', 1, CAST(N'2021-05-28' AS Date), N'Delete', N'True', N'P04', N'nbogz')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'rQaC0', 3, CAST(N'2021-05-20' AS Date), N'New', N'False', N'P18', N'yrhkL')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'rqW6D', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P09', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'S9Fvh', 2, CAST(N'2021-05-27' AS Date), N'Delete', N'True', N'P02', N'LEpaV')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'SjFaG', 1, CAST(N'2021-05-26' AS Date), N'Delete', N'True', N'P03', N'A3sxj')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'SJItQ', 1, CAST(N'2021-05-21' AS Date), N'Delete', N'True', N'P06', N'eI4KC')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'sjYFQ', 1, CAST(N'2021-05-22' AS Date), N'New', N'False', N'P09', N'yrhkL')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N't3STe', 4, CAST(N'2021-05-25' AS Date), N'Accept', N'True', N'P03', N'kGXcN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'T9nnW', 2, CAST(N'2021-05-29' AS Date), N'Accept', N'True', N'P07', N'RvuY3')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Thhez', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P01', N'JPsPw')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'tpgPk', 4, CAST(N'2021-05-31' AS Date), N'Delete', N'True', N'P10', N'QCGcL')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'TxB0r', 2, CAST(N'2021-05-20' AS Date), N'New', N'False', N'P10', N'5mNej')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'uF84Z', 3, CAST(N'2021-05-26' AS Date), N'New', N'True', N'P03', N'ql4vA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'VceEl', 1, CAST(N'2021-05-29' AS Date), N'Delete', N'True', N'P01', N'0uJlD')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'vFytM', 1, CAST(N'2021-05-29' AS Date), N'Delete', N'True', N'P20', N'RvuY3')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'vjWCI', 1, CAST(N'2021-06-04' AS Date), N'Delete', N'False', N'P06', N'wke4Y')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'VrWR1', 2, CAST(N'2021-05-22' AS Date), N'Delete', N'False', N'P03', N'JPsPw')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'Vz1to', 1, CAST(N'2021-05-21' AS Date), N'New', N'False', N'P12', N'WBnMN')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'WMcFL', 2, CAST(N'2021-06-03' AS Date), N'Accept', N'False', N'P07', N'wke4Y')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'wXDFK', 2, CAST(N'2021-05-28' AS Date), N'Delete', N'False', N'P12', N'xPLy7')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'xiIk9', 1, CAST(N'2021-05-29' AS Date), N'Delete', N'False', N'P06', N'hsv4N')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'ykaQo', 3, CAST(N'2021-05-31' AS Date), N'Accept', N'True', N'P03', N'LEpaV')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'YP3Lq', 1, CAST(N'2021-05-26' AS Date), N'New', N'True', N'P07', N'gPkwA')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'zaGwZ', 3, CAST(N'2021-05-20' AS Date), N'Accept', N'True', N'P02', N'WYIqw')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'ZbP8L', 1, CAST(N'2021-05-20' AS Date), N'New', N'True', N'P04', N'OiyGW')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'ZIdkI', 3, CAST(N'2021-05-20' AS Date), N'Accept', N'False', N'P07', N'4MfiX')
GO
INSERT [dbo].[BookingDetail] ([bookingDetailID], [quantity], [dateBorrow], [statusRequest], [status], [itemID], [bookingID]) VALUES (N'ZrtOG', 1, CAST(N'2021-05-20' AS Date), N'New', N'False', N'P06', N'D9rF3')
GO
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (N'C01', N'MÁY IN')
GO
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (N'C02', N'MÁY TÍNH')
GO
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (N'C03', N'MÁY CHIẾU')
GO
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (N'C04', N'BÀN GHẾ')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P01', N'Máy in HP DeskJet', N'White', 5, N'MayInHPDeskJet.jpg', N'1', N'C01')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P02', N'Máy in Canon Pixma', N'Black', 3, N'MayInCanonPixma.gif', N'2', N'C01')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P03', N'Máy in Samsung SL', N'Black', 4, N'MayInSamsungSL.png', N'1', N'C01')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P04', N'Máy in Epson L8', N'Black', 2, N'MayInEpsonL8.jpg', N'2', N'C01')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P05', N'Máy in HP Officejet', N'Black', 1, N'MayInHPOfficejet.jpg', N'2', N'C01')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P06', N'Máy tính Dell', N'Black', 2, N'MayTinhDell.jpg', N'1', N'C02')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P07', N'Máy tính HP', N'Black', 4, N'MaytinhHP.jpg', N'1', N'C02')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P08', N'Máy tính Asus', N'Black', 6, N'MaytinhAsus.jpg', N'2', N'C02')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P09', N'Laptop Dell', N'Black', 4, N'LaptopDell.jpg', N'1', N'C02')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P10', N'Laptop Acer', N'Black', 6, N'LaptopAcer.jpg', N'1', N'C02')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P11', N'Máy chiếu ViewSonic', N'White', 5, N'MayChieuViewSonic.jpg', N'2', N'C03')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P12', N'Máy chiếu Sony', N'White', 4, N'MayChieuSony.jpg', N'1', N'C03')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P13', N'Máy chiếu Optoma', N'Black', 6, N'MayChieuOptoma.jpg', N'1', N'C03')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P14', N'Máy chiếu FULL HD TYCO', N'White', 1, N'MayChieuFullHdTyco.jpg', N'2', N'C03')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P15', N'Máy chiếu VIVITEK', N'White', 2, N'MayChieuVIVITEK.png', N'1', N'C03')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P16', N'Ghế Chân Quỳ Lưới Lưng Thấp', N'Black', 8, N'GheChanQuyLuoiLungThap.jpg', N'1', N'C04')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P17', N'Ghế xoay lưới Trendy', N'Black', 10, N'GheXoayLuoiTrendy.jpg', N'2', N'C04')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P18', N'Ghế Gấp Chân Sơn', N'Blue', 12, N'GheGapChanSon.jpg', N'2', N'C04')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P19', N'Bàn làm việc MConcept', N'Brown', 6, N'BanLamViecMConcept.jpg', N'2', N'C04')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P20', N'Bàn làm việc chữ L', N'Yellow', 4, N'BanLamViecChuL.jpg', N'1', N'C04')
GO
INSERT [dbo].[Item] ([itemID], [itemName], [color], [quantity], [image], [levelID], [categoryID]) VALUES (N'P21', N'Bàn Uconcept', N'Black', 5, N'BanUconcept.jpg', N'2', N'C04')
GO
INSERT [dbo].[Level] ([levelID], [levelName]) VALUES (N'1', N'Employee, Leader')
GO
INSERT [dbo].[Level] ([levelID], [levelName]) VALUES (N'2', N'Leader')
GO
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (N'E', N'Employee')
GO
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (N'L', N'Leader')
GO
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (N'M', N'Manager')
GO
INSERT [dbo].[Users] ([userID], [name], [password], [phone], [address], [createDate], [codeRegister], [status], [roleID]) VALUES (N'levinhh2000@gmail.com', N'Vũ', N'12345678', N'0909546789', N'45/32 - Xa lộ Hà Nội - TPHCM', CAST(N'2021-05-14T07:30:00.000' AS DateTime), N'AAABBBCC', N'Active', N'L')
GO
INSERT [dbo].[Users] ([userID], [name], [password], [phone], [address], [createDate], [codeRegister], [status], [roleID]) VALUES (N'lqvinhh2000@gmail.com', N'Tài', N'12345678', N'0986171234', N'65A - Củ Chi', CAST(N'2021-06-12T08:25:00.000' AS DateTime), N'HSDKTREC', N'Active', N'E')
GO
INSERT [dbo].[Users] ([userID], [name], [password], [phone], [address], [createDate], [codeRegister], [status], [roleID]) VALUES (N'zingleeng@gmail.com', N'Vinh', N'12345678', N'0989123456', N'34 - Trường Chinh - TPHCM', CAST(N'2020-05-13T00:10:00.000' AS DateTime), N'DTHAABCS', N'Active', N'M')
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([userID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Booking] FOREIGN KEY([bookingID])
REFERENCES [dbo].[Booking] ([bookingID])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Booking]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Item] FOREIGN KEY([itemID])
REFERENCES [dbo].[Item] ([itemID])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_OrderDetail_Item]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Category] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Category] ([categoryID])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Category]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Level] FOREIGN KEY([levelID])
REFERENCES [dbo].[Level] ([levelID])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Level]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([roleID])
REFERENCES [dbo].[Role] ([roleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [ResourceSharing] SET  READ_WRITE 
GO
