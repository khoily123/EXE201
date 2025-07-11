USE [master]
GO
/****** Object:  Database [Hshop2023]    Script Date: 02/07/2025 1:15:22 SA ******/
CREATE DATABASE [Hshop2023]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hshop2023', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Hshop2023.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hshop2023_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Hshop2023_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Hshop2023] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hshop2023].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hshop2023] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hshop2023] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hshop2023] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hshop2023] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hshop2023] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hshop2023] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Hshop2023] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hshop2023] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hshop2023] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hshop2023] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hshop2023] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hshop2023] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hshop2023] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hshop2023] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hshop2023] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Hshop2023] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hshop2023] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hshop2023] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hshop2023] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hshop2023] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hshop2023] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hshop2023] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hshop2023] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hshop2023] SET  MULTI_USER 
GO
ALTER DATABASE [Hshop2023] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hshop2023] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hshop2023] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hshop2023] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hshop2023] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hshop2023] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Hshop2023] SET QUERY_STORE = ON
GO
ALTER DATABASE [Hshop2023] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Hshop2023]
GO
/****** Object:  Table [dbo].[ChiTietHD]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHD](
	[MaCT] [int] IDENTITY(1,1) NOT NULL,
	[MaHD] [int] NOT NULL,
	[MaHH] [int] NOT NULL,
	[DonGia] [float] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiamGia] [float] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[MaCT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HangHoa]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangHoa](
	[MaHH] [int] IDENTITY(1,1) NOT NULL,
	[TenHH] [nvarchar](50) NOT NULL,
	[TenAlias] [nvarchar](50) NULL,
	[MaLoai] [int] NOT NULL,
	[MoTaDonVi] [nvarchar](50) NULL,
	[DonGia] [float] NULL,
	[Hinh] [nvarchar](50) NULL,
	[NgaySX] [datetime] NOT NULL,
	[GiamGia] [float] NOT NULL,
	[SoLanXem] [int] NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[MaNCC] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[MaHH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vChiTietHoaDon]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vChiTietHoaDon]
AS 
	SELECT cthd.*, TenHH
	FROM ChiTietHD cthd JOIN HangHoa hh 
		ON hh.MaHH = cthd.MaHH


GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BanBe]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanBe](
	[MaBB] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [nvarchar](20) NULL,
	[MaHH] [int] NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[NgayGui] [datetime] NOT NULL,
	[GhiChu] [nvarchar](max) NULL,
 CONSTRAINT [PK_Promotions] PRIMARY KEY CLUSTERED 
(
	[MaBB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChuDe]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChuDe](
	[MaCD] [int] IDENTITY(1,1) NOT NULL,
	[TenCD] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
 CONSTRAINT [PK_ChuDe] PRIMARY KEY CLUSTERED 
(
	[MaCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GopY]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GopY](
	[MaGY] [nvarchar](50) NOT NULL,
	[MaCD] [int] NOT NULL,
	[NoiDung] [nvarchar](max) NOT NULL,
	[NgayGY] [date] NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[DienThoai] [nvarchar](50) NULL,
	[CanTraLoi] [bit] NOT NULL,
	[TraLoi] [nvarchar](50) NULL,
	[NgayTL] [date] NULL,
 CONSTRAINT [PK_GopY] PRIMARY KEY CLUSTERED 
(
	[MaGY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHD] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [nvarchar](20) NOT NULL,
	[NgayDat] [datetime] NOT NULL,
	[NgayCan] [datetime] NULL,
	[NgayGiao] [datetime] NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](60) NOT NULL,
	[CachThanhToan] [nvarchar](50) NOT NULL,
	[CachVanChuyen] [nvarchar](50) NOT NULL,
	[PhiVanChuyen] [float] NOT NULL,
	[MaTrangThai] [int] NOT NULL,
	[MaNV] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](50) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoiDap]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoiDap](
	[MaHD] [int] NOT NULL,
	[CauHoi] [nvarchar](50) NOT NULL,
	[TraLoi] [nvarchar](50) NOT NULL,
	[NgayDua] [date] NOT NULL,
	[MaNV] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HoiDap] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](20) NOT NULL,
	[MatKhau] [nvarchar](50) NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[GioiTinh] [bit] NOT NULL,
	[NgaySinh] [datetime] NOT NULL,
	[DiaChi] [nvarchar](60) NULL,
	[DienThoai] [nvarchar](24) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Hinh] [nvarchar](50) NULL,
	[HieuLuc] [bit] NOT NULL,
	[VaiTro] [int] NOT NULL,
	[RandomKey] [varchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](50) NOT NULL,
	[TenLoaiAlias] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
	[Hinh] [nvarchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [nvarchar](50) NOT NULL,
	[TenCongTy] [nvarchar](50) NOT NULL,
	[Logo] [nvarchar](50) NOT NULL,
	[NguoiLienLac] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[DienThoai] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanCong]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanCong](
	[MaPC] [int] IDENTITY(1,1) NOT NULL,
	[MaNV] [nvarchar](50) NOT NULL,
	[MaPB] [varchar](7) NOT NULL,
	[NgayPC] [datetime] NULL,
	[HieuLuc] [bit] NULL,
 CONSTRAINT [PK_PhanCong] PRIMARY KEY CLUSTERED 
(
	[MaPC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanQuyen]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanQuyen](
	[MaPQ] [int] IDENTITY(1,1) NOT NULL,
	[MaPB] [varchar](7) NULL,
	[MaTrang] [int] NULL,
	[Them] [bit] NOT NULL,
	[Sua] [bit] NOT NULL,
	[Xoa] [bit] NOT NULL,
	[Xem] [bit] NOT NULL,
 CONSTRAINT [PK_PhanQuyen] PRIMARY KEY CLUSTERED 
(
	[MaPQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongBan]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongBan](
	[MaPB] [varchar](7) NOT NULL,
	[TenPB] [nvarchar](50) NOT NULL,
	[ThongTin] [nvarchar](max) NULL,
 CONSTRAINT [PK_PhongBan] PRIMARY KEY CLUSTERED 
(
	[MaPB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoanNhaCungCap]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoanNhaCungCap](
	[MaTK] [int] IDENTITY(1,1) NOT NULL,
	[MaNCC] [nvarchar](50) NOT NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](256) NOT NULL,
	[NgayTao] [datetime] NULL,
	[TrangThai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThai]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThai](
	[MaTrangThai] [int] NOT NULL,
	[TenTrangThai] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_TrangThai] PRIMARY KEY CLUSTERED 
(
	[MaTrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangWeb]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangWeb](
	[MaTrang] [int] IDENTITY(1,1) NOT NULL,
	[TenTrang] [nvarchar](50) NOT NULL,
	[URL] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_TrangWeb] PRIMARY KEY CLUSTERED 
(
	[MaTrang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YeuThich]    Script Date: 02/07/2025 1:15:23 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YeuThich](
	[MaYT] [int] IDENTITY(1,1) NOT NULL,
	[MaHH] [int] NULL,
	[MaKH] [nvarchar](20) NULL,
	[NgayChon] [datetime] NULL,
	[MoTa] [nvarchar](255) NULL,
 CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED 
(
	[MaYT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChiTietHD] ON 

INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102376, 11176, 1095, 3500000, 2, 0.05)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102378, 11178, 1184, 500000, 3, 0.2)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102381, 11181, 1100, 18000000, 1, 0.1)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102382, 11182, 1182, 1000000, 2, 0.05)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102383, 11183, 1185, 13500000, 1, 0.1)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102384, 11184, 1186, 800000, 2, 0.2)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102385, 11185, 1187, 400000, 1, 0.15)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102386, 11186, 1193, 450000, 3, 0.25)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102387, 11187, 1195, 780000, 2, 0.18)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102389, 11189, 1198, 10000000, 1, 0.1)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102390, 11190, 1199, 1100000, 2, 0.07)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102391, 11191, 1200, 8800000, 1, 0.14)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102394, 11194, 1210, 3802000, 2, 0.15)
INSERT [dbo].[ChiTietHD] ([MaCT], [MaHD], [MaHH], [DonGia], [SoLuong], [GiamGia]) VALUES (102395, 11177, 1200, 8800000, 1, 0.15)
SET IDENTITY_INSERT [dbo].[ChiTietHD] OFF
GO
SET IDENTITY_INSERT [dbo].[HangHoa] ON 

INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1094, N'Bàn làm việc gỗ óc chó', N'Bàn làm việc ', 1008, N'Bàn gỗ óc chó 1.2m x 0.6m', 12000000, N'1.jpg', CAST(N'2024-01-10T00:00:00.000' AS DateTime), 0, 150, N'Bàn làm việc đa năng', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1095, N'Ghế văn phòng công thái học', N'ghe-van-phong-cong-thai-hoc', 1009, N'Ghế xoay, đệm lưới', 3500000, N'ghe1.jpg', CAST(N'2024-02-15T00:00:00.000' AS DateTime), 5, 200, N'Ghế công thái học với đệm lưới thoáng khí, hỗ trợ lưng tối ưu.', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1096, N'Tủ quần áo 3 cánh', N'tu-quan-ao-3-canh', 1010, N'Tủ gỗ công nghiệp 1.8m x 2m', 8500000, N'tu1.jpg', CAST(N'2024-03-20T00:00:00.000' AS DateTime), 0, 120, N'Tủ quần áo 3 cánh với thiết kế hiện đại, nhiều ngăn tiện lợi.', N'NT03')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1097, N'Giường ngủ gỗ sồi', N'giuong-ngu-go-soi', 1011, N'Giường 1.8m x 2m', 15000000, N'giuong1.jpg', CAST(N'2024-04-05T00:00:00.000' AS DateTime), 15, 180, N'Giường ngủ gỗ sồi tự nhiên, thiết kế tối giản, chắc chắn.', N'NT04')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1098, N'Sofa góc vải nỉ', N'sofa-goc-vai-ni', 1012, N'Sofa góc 2.5m x 1.8m', 20000000, N'sofa1.jpg', CAST(N'2024-05-10T00:00:00.000' AS DateTime), 10, 250, N'Sofa góc bọc vải nỉ cao cấp, phù hợp phòng khách hiện đại.', N'NT05')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1100, N'Bộ bàn ăn 6 ghế', N'bo-ban-an-6-ghe', 1014, N'Bàn 1.6m x 0.8m, 6 ghế', 18000000, N'2.jpg', CAST(N'2024-07-20T00:00:00.000' AS DateTime), 5, 220, N'Bộ bàn ăn gỗ tự nhiên kèm 6 ghế bọc nệm, phong cách hiện đại.', N'NT07')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1101, N'Bộ nội thất phòng khách hiện đại', N'bo-noi-that-phong-khach-hien-dai', 1015, N'Sofa, bàn trà, kệ tivi', 35000000, N'noithat1.jpg', CAST(N'2024-08-25T00:00:00.000' AS DateTime), 10, 300, N'Bộ nội thất phòng khách gồm sofa, bàn trà và kệ tivi, thiết kế sang trọng.', N'NT08')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1182, N'Ghế 1 - NT01', N'ghế-1---nt01', 1009, N'Cái', 1000000, N'ghe2.jpg', CAST(N'2021-05-31T00:00:00.000' AS DateTime), 0.15, 79, N'Sản phẩm ghế chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1183, N'Bàn trang điểm 2 - NT01', N'bàn-trang-điểm-2---nt01', 1020, N'Chiếc', 1200000, N'bantrangdiem1.jpg', CAST(N'2021-07-23T00:00:00.000' AS DateTime), 0.06, 403, N'Sản phẩm bàn trang điểm chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1184, N'Kệ trang trí 3 - NT01', N'kệ-trang-trí-3---nt01', 1016, N'Cái', 500000, N'ke1.jpg', CAST(N'2023-03-12T00:00:00.000' AS DateTime), 0.2, 195, N'Sản phẩm kệ trang trí chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1185, N'Sofa 4 - NT01', N'sofa-4---nt01', 1012, N'Bộ', 13500000, N'sofa2.jpg', CAST(N'2021-03-23T00:00:00.000' AS DateTime), 0.21, 907, N'Sản phẩm sofa chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1186, N'Bàn trang điểm 5 - NT01', N'bàn-trang-điểm-5---nt01', 1020, N'Cái', 800000, N'bantrangdiem2.jpg', CAST(N'2022-10-14T00:00:00.000' AS DateTime), 0.26, 999, N'Sản phẩm bàn trang điểm chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1187, N'Bàn trang điểm 6 - NT01', N'bàn-trang-điểm-6---nt01', 1020, N'Bộ', 400000, N'bantrangdiem3.jpg', CAST(N'2022-12-15T00:00:00.000' AS DateTime), 0.21, 752, N'Sản phẩm bàn trang điểm chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1188, N'Bộ bàn ghế 7 - NT01', N'bộ-bàn-ghế-7---nt01', 1014, N'Chiếc', 5000000, N'3.jpg', CAST(N'2022-12-07T00:00:00.000' AS DateTime), 0.29, 411, N'Sản phẩm bộ bàn ghế chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1189, N'Bộ bàn ghế 8 - NT01', N'bộ-bàn-ghế-8---nt01', 1014, N'Cái', 2000000, N'4.jpg', CAST(N'2021-10-12T00:00:00.000' AS DateTime), 0.29, 53, N'Sản phẩm bộ bàn ghế chất lượng từ NCC NT01', N'NT01')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1192, N'Rèm cửa 1 - NT02', N'rèm-cửa-1---nt02', 1018, N'Bộ', 350000, N'remcua1.jpg', CAST(N'2022-03-10T00:00:00.000' AS DateTime), 0.3, 607, N'Sản phẩm rèm cửa chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1193, N'Tủ giày 2 - NT02', N'tủ-giày-2---nt02', 1019, N'Cái', 450000, N'tu2.jpg', CAST(N'2022-04-03T00:00:00.000' AS DateTime), 0.18, 37, N'Sản phẩm tủ giày chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1194, N'Bàn 3 - NT02', N'bàn-3---nt02', 1008, N'Chiếc', 900000, N'ban1.jpg', CAST(N'2021-04-16T00:00:00.000' AS DateTime), 0.13, 571, N'Sản phẩm bàn chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1195, N'Rèm cửa 4 - NT02', N'rèm-cửa-4---nt02', 1018, N'Bộ', 780000, N'remcua2.jpg', CAST(N'2021-01-18T00:00:00.000' AS DateTime), 0.26, 222, N'Sản phẩm rèm cửa chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1198, N'Giường 7 - NT02', N'giường-7---nt02', 1011, N'Bộ', 10000000, N'giuong2.jpg', CAST(N'2022-10-07T00:00:00.000' AS DateTime), 0.18, 799, N'Sản phẩm giường chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1199, N'Ghế 8 - NT02', N'ghế-8---nt02', 1009, N'Cái', 1100000, N'ghe3.jpg', CAST(N'2022-01-31T00:00:00.000' AS DateTime), 0.29, 393, N'Sản phẩm ghế chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1200, N'Sofa 9 - NT02', N'sofa-9---nt02', 1012, N'Bộ', 8800000, N'sofa3.jpg', CAST(N'2022-07-07T00:00:00.000' AS DateTime), 0.14, 452, N'Sản phẩm sofa chất lượng từ NCC NT02', N'NT02')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1202, N'Bộ bàn ghế 1 - NT03', N'bộ-bàn-ghế-1---nt03', 1014, N'Cái', 14160000, N'5.jpg', CAST(N'2021-09-12T00:00:00.000' AS DateTime), 0.26, 29, N'Sản phẩm bộ bàn ghế chất lượng từ NCC NT03', N'NT03')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1204, N'Nội thất phòng khách 3 - NT03', N'nội-thất-phòng-khách-3---nt03', 1015, N'Chiếc', 4747000, N'noithat2.jpg', CAST(N'2021-12-08T00:00:00.000' AS DateTime), 0.24, 45, N'Sản phẩm nội thất phòng khách chất lượng từ NCC NT03', N'NT03')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1205, N'Nội thất phòng khách 4 - NT03', N'nội-thất-phòng-khách-4---nt03', 1015, N'Bộ', 11622000, N'noithat3.jpg', CAST(N'2022-05-09T00:00:00.000' AS DateTime), 0.23, 651, N'Sản phẩm nội thất phòng khách chất lượng từ NCC NT03', N'NT03')
INSERT [dbo].[HangHoa] ([MaHH], [TenHH], [TenAlias], [MaLoai], [MoTaDonVi], [DonGia], [Hinh], [NgaySX], [GiamGia], [SoLanXem], [MoTa], [MaNCC]) VALUES (1210, N'Ghế 9 - NT03', N'ghế-9---nt03', 1009, N'Cái', 3802000, N'ghe4.jpg', CAST(N'2022-12-19T00:00:00.000' AS DateTime), 0.24, 586, N'Sản phẩm ghế chất lượng từ NCC NT03', N'NT03')
SET IDENTITY_INSERT [dbo].[HangHoa] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11176, N'ANATR', CAST(N'2023-08-28T00:00:00.000' AS DateTime), CAST(N'2023-09-01T00:00:00.000' AS DateTime), CAST(N'2023-09-06T00:00:00.000' AS DateTime), N'Ana Trujillo', N'757 Đường Nội Thất, Q.3, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 2, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11177, N'ANTON', CAST(N'2023-07-02T00:00:00.000' AS DateTime), CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(N'2023-07-10T00:00:00.000' AS DateTime), N'Antonio Moreno', N'711 Đường Nội Thất, Q.7, TP.HCM', N'Chuyển khoản', N'Tự nhận', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11178, N'AROUT', CAST(N'2023-06-18T00:00:00.000' AS DateTime), CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(N'2023-06-27T00:00:00.000' AS DateTime), N'Thomas Hardy', N'879 Đường Nội Thất, Q.10, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 2, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11179, N'BERGS', CAST(N'2023-06-18T00:00:00.000' AS DateTime), CAST(N'2023-06-25T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), N'Christina Berglund', N'572 Đường Nội Thất, Q.1, TP.HCM', N'Chuyển khoản', N'Tự nhận', 0, 1, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11180, N'BLAUS', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(N'2023-01-21T00:00:00.000' AS DateTime), N'Hanna Moos', N'873 Đường Nội Thất, Q.10, TP.HCM', N'Tiền mặt', N'Tự nhận', 0, 1, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11181, N'BLONP', CAST(N'2023-12-15T00:00:00.000' AS DateTime), CAST(N'2023-12-19T00:00:00.000' AS DateTime), CAST(N'2023-12-21T00:00:00.000' AS DateTime), N'Frédérique Citeaux', N'130 Đường Nội Thất, Q.2, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 1, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11182, N'BOLID', CAST(N'2023-09-06T00:00:00.000' AS DateTime), CAST(N'2023-09-12T00:00:00.000' AS DateTime), CAST(N'2023-09-17T00:00:00.000' AS DateTime), N'Martín Sommer', N'55 Đường Nội Thất, Q.5, TP.HCM', N'Chuyển khoản', N'Tự nhận', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11183, N'BONAP', CAST(N'2023-05-03T00:00:00.000' AS DateTime), CAST(N'2023-05-08T00:00:00.000' AS DateTime), CAST(N'2023-05-11T00:00:00.000' AS DateTime), N'Laurence Lebihan', N'351 Đường Nội Thất, Q.3, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11184, N'BOTTM', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(N'2023-04-23T00:00:00.000' AS DateTime), CAST(N'2023-04-26T00:00:00.000' AS DateTime), N'Elizabeth Lincoln', N'655 Đường Nội Thất, Q.3, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11185, N'BSBEV', CAST(N'2023-06-08T00:00:00.000' AS DateTime), CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(N'2023-06-17T00:00:00.000' AS DateTime), N'Victoria Ashworth', N'127 Đường Nội Thất, Q.7, TP.HCM', N'Chuyển khoản', N'Tự nhận', 0, 1, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11186, N'CACTU', CAST(N'2023-02-22T00:00:00.000' AS DateTime), CAST(N'2023-02-24T00:00:00.000' AS DateTime), CAST(N'2023-02-26T00:00:00.000' AS DateTime), N'Patricio Simpson', N'106 Đường Nội Thất, Q.1, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11187, N'CENTC', CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'2023-03-29T00:00:00.000' AS DateTime), CAST(N'2023-04-04T00:00:00.000' AS DateTime), N'Francisco Chang', N'581 Đường Nội Thất, Q.4, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 2, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11188, N'CHOPS', CAST(N'2023-12-26T00:00:00.000' AS DateTime), CAST(N'2023-12-28T00:00:00.000' AS DateTime), CAST(N'2023-12-29T00:00:00.000' AS DateTime), N'Yang Wang', N'356 Đường Nội Thất, Q.10, TP.HCM', N'Tiền mặt', N'Tự nhận', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11189, N'COMMI', CAST(N'2023-12-17T00:00:00.000' AS DateTime), CAST(N'2023-12-20T00:00:00.000' AS DateTime), CAST(N'2023-12-26T00:00:00.000' AS DateTime), N'Pedro Afonso', N'808 Đường Nội Thất, Q.6, TP.HCM', N'Chuyển khoản', N'Giao tận nơi', 0, 1, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11190, N'CONSH', CAST(N'2023-10-03T00:00:00.000' AS DateTime), CAST(N'2023-10-10T00:00:00.000' AS DateTime), CAST(N'2023-10-13T00:00:00.000' AS DateTime), N'Elizabeth Brown', N'56 Đường Nội Thất, Q.6, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11191, N'DRACD', CAST(N'2023-12-20T00:00:00.000' AS DateTime), CAST(N'2023-12-22T00:00:00.000' AS DateTime), CAST(N'2023-12-24T00:00:00.000' AS DateTime), N'Sven Ottlieb', N'45 Đường Nội Thất, Q.4, TP.HCM', N'Chuyển khoản', N'Tự nhận', 0, 1, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11192, N'DUMON', CAST(N'2023-01-21T00:00:00.000' AS DateTime), CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(N'2023-01-31T00:00:00.000' AS DateTime), N'Janine Labrune', N'304 Đường Nội Thất, Q.11, TP.HCM', N'Tiền mặt', N'Giao tận nơi', 0, 0, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11193, N'EASTC', CAST(N'2023-12-08T00:00:00.000' AS DateTime), CAST(N'2023-12-11T00:00:00.000' AS DateTime), CAST(N'2023-12-14T00:00:00.000' AS DateTime), N'Ann Devon', N'927 Đường Nội Thất, Q.2, TP.HCM', N'Chuyển khoản', N'Tự nhận', 0, 3, NULL, NULL)
INSERT [dbo].[HoaDon] ([MaHD], [MaKH], [NgayDat], [NgayCan], [NgayGiao], [HoTen], [DiaChi], [CachThanhToan], [CachVanChuyen], [PhiVanChuyen], [MaTrangThai], [MaNV], [GhiChu]) VALUES (11194, N'ERNSH', CAST(N'2023-11-25T00:00:00.000' AS DateTime), CAST(N'2023-11-29T00:00:00.000' AS DateTime), CAST(N'2023-12-04T00:00:00.000' AS DateTime), N'Roland Mendel', N'299 Đường Nội Thất, Q.6, TP.HCM', N'Tiền mặt', N'Tự nhận', 0, 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'admin', N'bcbc526aa5058fb4261f97b25320bed2', N'admin', 0, CAST(N'2003-04-01T00:00:00.000' AS DateTime), N'admin', N'0915162845', N'admin@gmail.com', N'Photo.gif', 1, 1, N'kq!QD')
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'ALFKI', N'iloveyou', N'Nguyễn Thị Mai', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'57 Trần Hưng Đạo, Hà Nội', N'0912345678', N'alfki@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'ANATR', N'iloveyou', N'Trần Thị Lan', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'2222 Nguyễn Văn Cừ, TP. HCM', N'0934567890', N'anatr@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'ANTON', N'iloveyou', N'Lê Văn Hùng', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'2312 Phạm Văn Đồng, Cần Thơ', N'0987654321', N'anton@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'AROUT', N'iloveyou', N'Phạm Tuấn Anh', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'120 Nguyễn Huệ, Huế', N'0901122334', N'arout@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BERGS', N'iloveyou', N'Nguyễn Minh Châu', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'8 Lê Lợi, Đà Nẵng', N'0944332211', N'bergs@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BLAUS', N'iloveyou', N'Trịnh Thu Hằng', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'57 Lý Thường Kiệt, Hà Nội', N'0967788990', N'blaus@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BLONP', N'iloveyou', N'Nguyễn Thùy Dung', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'24 Pasteur, TP. HCM', N'0909988776', N'blonp@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BOLID', N'iloveyou', N'Đỗ Văn Minh', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'67 Trường Chinh, Hà Nội', N'0933322111', N'bolid@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BONAP', N'iloveyou', N'Lê Ngọc Bích', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'12 Nguyễn Du, Nha Trang', N'0977334455', N'bonap@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BOTTM', N'iloveyou', N'Elizabeth Lincoln', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'23 Tsawassen Blvd.', N'(604) 555-4729', N'bottm@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'BSBEV', N'iloveyou', N'Phạm Mai Hương', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'11 Nguyễn Du, TP. HCM', N'0933445566', N'bsbev@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'CACTU', N'iloveyou', N'Trần Văn Bình', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'333 Trần Phú, Đà Nẵng', N'0977889900', N'cactu@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'CENTC', N'iloveyou', N'Hoàng Thanh Tùng', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'99 Nguyễn Trãi, Cần Thơ', N'0903445566', N'centc@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'CHOPS', N'iloveyou', N'Nguyễn Mạnh Hùng', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'29 Quang Trung, Hà Nội', N'0966778899', N'chops@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'COMMI', N'iloveyou', N'Lê Thị Bích', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'23 Hai Bà Trưng, TP. HCM', N'0933442211', N'commi@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'CONSH', N'iloveyou', N'Trần Quốc Anh', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'12 Lý Thường Kiệt, Hà Nội', N'0911882334', N'consh@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'DRACD', N'iloveyou', N'Phạm Hữu Đức', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'21 Nguyễn Văn Linh, Đà Nẵng', N'0905336677', N'dracd@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'DUMON', N'iloveyou', N'Nguyễn Thị Diễm', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'67 Nguyễn Hữu Thọ, TP. HCM', N'0944567788', N'dumon@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'EASTC', N'iloveyou', N'Võ Hồng Duyên', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'35 Lê Văn Việt, Thủ Đức', N'0977338822', N'eastc@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'ERNSH', N'iloveyou', N'Ngô Thanh Tùng', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'6 Lý Tự Trọng, Huế', N'0988665544', N'ernsh@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FAMIA', N'iloveyou', N'Cao Thị Minh', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'92 Lê Lai, Đà Lạt', N'0911225566', N'famia@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FISSA', N'iloveyou', N'Phan Đức Toàn', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'11 Lý Chính Thắng, Hà Nội', N'0933441234', N'fissa@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FOLIG', N'iloveyou', N'Nguyễn Thị Hà', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'184 Trần Nhân Tông, Quảng Ninh', N'0966331122', N'folig@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FOLKO', N'iloveyou', N'Trịnh Thị Mai Anh', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'24 Phan Đình Giót, Hà Nội', N'0909998877', N'folko@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FRANK', N'iloveyou', N'Nguyễn Văn Bình', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'43 Trần Thái Tông, TP. HCM', N'0933441122', N'frank@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FRANR', N'iloveyou', N'Lê Thị Kim Oanh', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'54 Lý Nam Đế, Huế', N'0977998822', N'franr@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FRANS', N'iloveyou', N'Phan Hoàng Việt', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'11/1 Nguyễn Trãi, Hà Nội', N'0911993344', N'frans@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'FURIB', N'iloveyou', N'Trần Đức Thành', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Jardin das Rosas, Hải Phòng', N'0944995566', N'furib@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'GALED', N'iloveyou', N'Nguyễn Quốc Tuấn', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'21 Lý Thường Kiệt, Cần Thơ', N'0933447766', N'galed@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'GODOS', N'iloveyou', N'Võ Minh Trí', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'55 Nguyễn Văn Linh, TP. HCM', N'0911882778', N'godos@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'GOURL', N'iloveyou', N'Phạm Thanh Phong', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'442 Hoàng Văn Thụ, TP. HCM', N'0909123456', N'gourl@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'GREAL', N'iloveyou', N'Hồ Minh Quân', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'2732 Tôn Đức Thắng, Quảng Ngãi', N'0977889922', N'greal@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'GROSR', N'iloveyou', N'Lương Văn Hòa', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'35 Pasteur, TP. HCM', N'0911223345', N'grosr@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'HANAR', N'iloveyou', N'Phạm Văn Tuấn', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'67 Âu Cơ, Hà Nội', N'0912334455', N'hanar@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'HILAA', N'iloveyou', N'Lê Thị Ánh Tuyết', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'22 Cách Mạng Tháng Tám, Đà Nẵng', N'0904332211', N'hilaa@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'HUNGC', N'iloveyou', N'Trần Anh Tuấn', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'11 City Garden, Hà Nội', N'0967889922', N'hungc@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'HUNGO', N'iloveyou', N'Vũ Hồng Nhung', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'8 Lê Duẩn, Huế', N'0933556677', N'hungo@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'ISLAT', N'iloveyou', N'Lý Hoàng Hà', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Khu biệt thự C, TP. HCM', N'0988776655', N'islat@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'KH0002', N'a0cd8c2ab5e0bd6f61ba4ffa626f5c3e', N'Lê Văn Thế', 1, CAST(N'2000-11-11T00:00:00.000' AS DateTime), N'85 Đà Huyền T, TP. Vinh', N'0912883456', N'asphnhtnghe@gmail.com', NULL, 0, 0, N'kt2[v')
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'khoi123', N'24adf6a41f9eeb4f29b9b0df8c6b884e', N'Lý Tiến Khôi', 0, CAST(N'2003-04-15T00:00:00.000' AS DateTime), N'Hà Nội', N'0962896311', N'lytienkhoi1598@gmail.com', N'User.jpg', 1, 0, N'WeXBn')
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'KOENE', N'iloveyou', N'Nguyễn Quốc Bảo', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'90 Mậu Thân, Cần Thơ', N'0905999876', N'koene@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LACOR', N'iloveyou', N'Đinh Văn Lâm', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'77 Lê Lợi, Nha Trang', N'0911998844', N'lacor@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LAMAI', N'iloveyou', N'Nguyễn Thị Mỹ Linh', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'1 Alsace-Lorraine, Vũng Tàu', N'0911227788', N'lamai@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LAUGB', N'iloveyou', N'Yoshi Tân Nam', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'1900 Lý Thường Kiệt, TP. HCM', N'0934553322', N'laugB@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LAZYK', N'iloveyou', N'Nguyễn Thanh Hòa', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'12 Lê Văn Lương, Hà Nội', N'0912667788', N'lazyK@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LEHMS', N'iloveyou', N'Lê Minh Hương', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'3/2 Nguyễn Đình Chiểu, Huế', N'0977889912', N'lehmS@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LETSS', N'iloveyou', N'Jaime Yorres', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'87 Polk St. Suite 5', N'(415) 555-5938', N'letss@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LILAS', N'iloveyou', N'Nguyễn Gia Lộc', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'52 Trần Hưng Đạo, Đà Nẵng', N'0911223344', N'lilas@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LINOD', N'iloveyou', N'Phạm Minh Long', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'15 Lý Tự Trọng, TP. HCM', N'0933332211', N'linod@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'LONEP', N'iloveyou', N'Fran Wilson', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'89 Chiaroscuro Rd.', N'(503) 555-9573', N'lonep@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'MAGAA', N'iloveyou', N'Lê Thanh Tuấn', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'11 Tôn Đức Thắng, Nha Trang', N'0977992233', N'magaa@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'MAISD', N'iloveyou', N'Phạm Thị Hòa', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'15 Hai Bà Trưng, Hà Nội', N'0933445566', N'maisd@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'MEREP', N'iloveyou', N'Jean Fresnière', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'43 rue St. Laurent', N'(514) 555-8054', N'merep@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'MORGK', N'iloveyou', N'Phạm Quốc Khánh', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'22 Nguyễn Văn Cừ, Cần Thơ', N'0977993344', N'morgk@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'NORTS', N'iloveyou', N'Lương Văn Hoàng', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'30 Trần Quang Khải, TP. HCM', N'0902334455', N'norts@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'OCEAN', N'iloveyou', N'Hà Minh Tuấn', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'9 Nguyễn Thái Học, Đà Nẵng', N'0911998855', N'ocean@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'OLDWO', N'iloveyou', N'Bùi Văn Nhân', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'273 Bạch Đằng, Hà Nội', N'0966447755', N'oldwo@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'OTTIK', N'iloveyou', N'Lê Kim Yến', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'22 Phan Đình Phùng, Cần Thơ', N'0909665544', N'ottik@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'PARIS', N'iloveyou', N'Vũ Thị Thảo', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'88 Phan Chu Trinh, Hà Nội', N'0932442266', N'paris@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'PERIC', N'iloveyou', N'Phạm Minh Thành', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'12 Trần Phú, TP. HCM', N'0911557799', N'peric@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'PICCO', N'iloveyou', N'Nguyễn Minh Tuệ', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'11B Điện Biên Phủ, Hải Phòng', N'0944556677', N'picco@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'PRINI', N'iloveyou', N'Trần Thanh Vũ', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'43 Nguyễn Văn Linh, Đà Nẵng', N'0966331123', N'prini@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'QUEDE', N'iloveyou', N'Lê Văn Đạt', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'12 Trần Hưng Đạo, Hà Nội', N'0909332211', N'quede@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'QUEEN', N'iloveyou', N'Ngô Hoài Thương', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'1 Nguyễn Văn Linh, TP. HCM', N'0933447799', N'queen@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'QUICK', N'iloveyou', N'Hà Văn Phúc', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'10 Trần Hưng Đạo, Huế', N'0977331144', N'quick@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'RANCH', N'iloveyou', N'Trần Hoàng Anh', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'15 Nguyễn Trãi, Hà Nội', N'0911222333', N'ranch@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'RATTC', N'iloveyou', N'Paula Wilson', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'2817 Milton Dr.', N'(505) 555-5939', N'rattc@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'REGGC', N'iloveyou', N'Lê Đình Dũng', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'33 Cách Mạng Tháng Tám, TP. HCM', N'0944332211', N'reggc@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'RICAR', N'iloveyou', N'Nguyễn Hồng Nhung', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'22 Nguyễn Thái Bình, Hà Nội', N'0966331144', N'ricar@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'RICSU', N'iloveyou', N'Trần Văn Trí', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'48 Lê Duẩn, TP. HCM', N'0933556611', N'ricsu@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'ROMEY', N'iloveyou', N'Ngô Thị Yến', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'1 Trần Nhật Duật, Huế', N'0911992345', N'romey@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SANTG', N'iloveyou', N'Lý Văn Phúc', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'88 Nguyễn Văn Cừ, Cần Thơ', N'0988991122', N'santg@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SAVEA', N'iloveyou', N'Lưu Minh Tường', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'9 Hùng Vương, Đà Nẵng', N'0977332211', N'savea@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SEVES', N'iloveyou', N'Nguyễn Đức Trọng', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'90 Nguyễn Trãi, Hà Nội', N'0966441122', N'seves@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SIMOB', N'iloveyou', N'Lê Thị Kim Anh', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'34 Nguyễn Huệ, TP. HCM', N'0933557788', N'simob@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SPECD', N'iloveyou', N'Đặng Ngọc Phúc', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'91 Trần Quang Diệu, Đà Nẵng', N'0909887766', N'specd@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SPLIR', N'iloveyou', N'Huỳnh Văn Nam', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'123 Lê Văn Sỹ, TP. HCM', N'0911447788', N'splir@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'SUPRD', N'iloveyou', N'Pascale Cartrain', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Boulevard Tirou, 255', N'(071) 23 67 22 20', N'suprd@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'THEBI', N'iloveyou', N'Nguyễn Thị Bích Hằng', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'89 Lê Hồng Phong, Vũng Tàu', N'0933445566', N'thebi@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'THECR', N'iloveyou', N'Liu Wong', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'55 Grizzly Peak Rd.', N'(406) 555-5834', N'thecr@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'TOMSP', N'iloveyou', N'Karin Josephs', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Luisenstr. 48', N'0251-031259', N'tomsp@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'TORTU', N'iloveyou', N'Miguel Angel Paolino', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Avda. Azteca 123', N'(5) 555-2933', N'tortu@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'TRADH', N'iloveyou', N'Anabela Domingues', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Av. Inês de Castro, 414', N'(11) 555-2167', N'tradh@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'TRAIH', N'iloveyou', N'Helvetius Nagy', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'722 DaVinci Blvd.', N'(206) 555-8257', N'traih@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'VAFFE', N'iloveyou', N'Palle Ibsen', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Smagsloget 45', N'86 21 32 43', N'vaffe@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'VICTE', N'iloveyou', N'Mary Saveley', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'2, rue du Commerce', N'78.32.54.86', N'victe@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'VINET', N'iloveyou', N'Paul Henriot', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'59 rue de l''Abbaye', N'26.47.15.10', N'vinet@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'WANDK', N'iloveyou', N'Rita Müller', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Adenauerallee 900', N'0711-020361', N'wandk@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'WARTH', N'iloveyou', N'Pirkko Koskitalo', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Torikatu 38', N'981-443655', N'warth@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'WELLI', N'iloveyou', N'Paula Parente', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Rua do Mercado, 12', N'(14) 555-8122', N'welli@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'WHITC', N'iloveyou', N'Karl Jablonski', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'305 - 14th Ave. S. Suite 3B', N'(206) 555-4112', N'whitc@abc.com', N'User.jpg', 1, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'WILMK', N'iloveyou', N'Matti Karttunen', 1, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'Keskuskatu 45', N'90-224 8858', N'wilmk@abc.com', N'User.jpg', 0, 0, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [DienThoai], [Email], [Hinh], [HieuLuc], [VaiTro], [RandomKey]) VALUES (N'WOLZA', N'iloveyou', N'Zbyszek Piestrzeniewicz', 0, CAST(N'2009-08-01T15:10:40.857' AS DateTime), N'ul. Filtrowa 68', N'(26) 642-7012', N'wolza@abc.com', N'User.jpg', 0, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[Loai] ON 

INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1008, N'Bàn', N'ban', N'Bàn làm việc, bàn ăn, bàn cà phê', N'Table.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1009, N'Ghế', N'ghe', N'Ghế văn phòng, ghế ăn, ghế sofa', N'Chair.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1010, N'Tủ', N'tu', N'Tủ quần áo, tủ bếp, tủ trang trí', N'Cabinet.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1011, N'Giường', N'giuong', N'Giường ngủ, giường tầng', N'Bed.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1012, N'Sofa', N'sofa', N'Sofa phòng khách, sofa góc', N'Sofa.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1014, N'Bộ bàn ghế', N'bo-ban-ghe', N'Bộ bàn ghế phòng ăn, phòng khách', N'DiningSet.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1015, N'Nội thất phòng khách', N'noi-that-phong-khach', N'Nội thất tổng hợp cho phòng khách', N'phongkhach.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1016, N'Kệ trang trí', N'ke-trang-tri', N'Kệ trang trí treo tường, đứng sàn, đa năng', N'ShelfDecor.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1017, N'Trang trí nội thất', N'trang-tri-noi-that', N'Đèn, tranh, đồng hồ treo tường và vật dụng decor', N'Decor.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1018, N'Rèm cửa', N'rem-cua', N'Rèm cửa sổ, rèm cuốn, rèm vải cao cấp', N'Curtain.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1019, N'Tủ giày', N'tu-giay', N'Tủ đựng giày dép bằng gỗ, nhựa hoặc kim loại', N'ShoeCabinet.png')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai], [TenLoaiAlias], [MoTa], [Hinh]) VALUES (1020, N'Bàn trang điểm', N'ban-trang-diem', N'Bàn trang điểm phòng ngủ hiện đại, cổ điển', N'DressingTable.png')
SET IDENTITY_INSERT [dbo].[Loai] OFF
GO
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT01', N'Nội Thất Hòa Phát', N'hoaphat.png', N'Nguyễn Văn Hùng', N'hung@hoaphat.com', N'0981234567', N'55 Giải Phóng, Hà Nội, Việt Nam', N'Nhà cung cấp nội thất văn phòng và gia đình hàng đầu Việt Nam')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT02', N'Nội Thất Xuân Hòa', N'xuanhoa.png', N'Trần Thị Mai', N'mai@xuhoa.com', N'0912345678', N'176 Cầu Giấy, Hà Nội, Việt Nam', N'Chuyên cung cấp bàn ghế và nội thất hiện đại')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT03', N'Nội Thất JYSK', N'JYSK.png', N'Phạm Quốc Anh', N'anh@jysk.vn', N'0933456789', N'123 Nguyễn Trãi, TP.HCM, Việt Nam', N'Nhà cung cấp nội thất phong cách Bắc Âu')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT04', N'Nội Thất Nhà Xinh', N'Nội Thất Nhà Xinh.png', N'Lê Minh Tuấn', N'tuan@nhaxinh.com', N'0904567890', N'45 Lê Lợi, TP.HCM, Việt Nam', N'Chuyên nội thất cao cấp cho phòng khách và phòng ngủ')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT05', N'Nội Thất Minh Long', N'Nội Thất Minh Long.png', N'Hoàng Thị Lan', N'lan@minhlong.com', N'0975678901', N'78 Trần Phú, Đà Nẵng, Việt Nam', N'Cung cấp sofa và nội thất gia đình chất lượng cao')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT06', N'Nội Thất An Cường', N'Nội Thất An Cường.png', N'Vũ Đức Hưng', N'hung@ancuong.com', N'0941234567', N'99 Phạm Văn Đồng, Hà Nội, Việt Nam', N'Chuyên cung cấp gỗ công nghiệp và nội thất hiện đại')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT07', N'Nội Thất IKEA Việt Nam', N'Nội Thất IKEA Việt Nam.png', N'Nguyễn Thị Hồng', N'hong@ikea.vn', N'0967890123', N'321 Võ Văn Kiệt, TP.HCM, Việt Nam', N'Nhà cung cấp nội thất giá rẻ, phong cách hiện đại')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenCongTy], [Logo], [NguoiLienLac], [Email], [DienThoai], [DiaChi], [MoTa]) VALUES (N'NT08', N'Nội Thất Việt Phát', N'Nội Thất Việt Phát.png', N'Trần Văn Nam', N'nam@vietphat.com', N'0935678901', N'88 Nguyễn Huệ, Huế, Việt Nam', N'Chuyên cung cấp bộ bàn ghế và nội thất phòng ăn')
GO
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [Email], [MatKhau]) VALUES (N'lvc', N'Lê Văn C', N'lvc@gmail.com', N'123')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [Email], [MatKhau]) VALUES (N'nva', N'Trần Văn A', N'tva@gmail.com', N'123')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [Email], [MatKhau]) VALUES (N'nvb', N'Nguyễn Văn B', N'nvb@gmail.com', N'123')
GO
SET IDENTITY_INSERT [dbo].[PhanCong] ON 

INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (1, N'lvc', N'BGD', CAST(N'2017-12-17T10:10:06.877' AS DateTime), 0)
INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (2, N'nva', N'BGD', CAST(N'2017-11-11T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (3, N'lvc', N'BGD', CAST(N'2017-12-17T10:15:51.303' AS DateTime), 1)
INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (4, N'nva', N'BGD', CAST(N'2017-12-17T10:15:51.333' AS DateTime), 1)
INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (5, N'nva', N'PKT', CAST(N'2017-12-17T10:16:19.203' AS DateTime), 0)
INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (6, N'nvb', N'PKT', CAST(N'2017-12-17T10:16:19.213' AS DateTime), 0)
INSERT [dbo].[PhanCong] ([MaPC], [MaNV], [MaPB], [NgayPC], [HieuLuc]) VALUES (7, N'nvb', N'PKT', CAST(N'2017-12-17T10:16:39.180' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[PhanCong] OFF
GO
SET IDENTITY_INSERT [dbo].[PhanQuyen] ON 

INSERT [dbo].[PhanQuyen] ([MaPQ], [MaPB], [MaTrang], [Them], [Sua], [Xoa], [Xem]) VALUES (16, N'BGD', 1, 0, 0, 0, 0)
INSERT [dbo].[PhanQuyen] ([MaPQ], [MaPB], [MaTrang], [Them], [Sua], [Xoa], [Xem]) VALUES (17, N'BGD', 2, 0, 0, 0, 0)
INSERT [dbo].[PhanQuyen] ([MaPQ], [MaPB], [MaTrang], [Them], [Sua], [Xoa], [Xem]) VALUES (18, N'BGD', 3, 0, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[PhanQuyen] OFF
GO
INSERT [dbo].[PhongBan] ([MaPB], [TenPB], [ThongTin]) VALUES (N'BGD', N'Ban Giám Đốc', NULL)
INSERT [dbo].[PhongBan] ([MaPB], [TenPB], [ThongTin]) VALUES (N'PKD', N'Phòng kinh doanh', NULL)
INSERT [dbo].[PhongBan] ([MaPB], [TenPB], [ThongTin]) VALUES (N'PKT', N'Phòng Kỹ thuật', NULL)
INSERT [dbo].[PhongBan] ([MaPB], [TenPB], [ThongTin]) VALUES (N'PKTo', N'Phòng Kế toán', NULL)
GO
SET IDENTITY_INSERT [dbo].[TaiKhoanNhaCungCap] ON 

INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (4, N'NT01', N'hoaphat', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (5, N'NT02', N'xuhoa', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (6, N'NT03', N'jysk', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (7, N'NT04', N'nhaxinh', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (8, N'NT05', N'minhlong', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (9, N'NT06', N'ancuong', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (10, N'NT07', N'ikea', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
INSERT [dbo].[TaiKhoanNhaCungCap] ([MaTK], [MaNCC], [TenDangNhap], [MatKhau], [NgayTao], [TrangThai]) VALUES (11, N'NT08', N'vietphat', N'123456', CAST(N'2025-06-10T15:31:03.060' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TaiKhoanNhaCungCap] OFF
GO
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai], [MoTa]) VALUES (-1, N'Khách hàng hủy đơn hàng', NULL)
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai], [MoTa]) VALUES (0, N'Mới đặt hàng', NULL)
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai], [MoTa]) VALUES (1, N'Đã thanh toán', NULL)
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai], [MoTa]) VALUES (2, N'Chờ giao hàng', NULL)
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai], [MoTa]) VALUES (3, N'Đã giao hàng', NULL)
GO
SET IDENTITY_INSERT [dbo].[TrangWeb] ON 

INSERT [dbo].[TrangWeb] ([MaTrang], [TenTrang], [URL]) VALUES (1, N'Trang chủ Admin', N'Default.aspx')
INSERT [dbo].[TrangWeb] ([MaTrang], [TenTrang], [URL]) VALUES (2, N'Quản lý Đơn hàng', N'QLDonHang.aspx')
INSERT [dbo].[TrangWeb] ([MaTrang], [TenTrang], [URL]) VALUES (3, N'Quản lý Hàng hóa', N'QLHangHoa.aspx')
SET IDENTITY_INSERT [dbo].[TrangWeb] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaiKhoan__55F68FC0CA60E9E2]    Script Date: 02/07/2025 1:15:23 SA ******/
ALTER TABLE [dbo].[TaiKhoanNhaCungCap] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BanBe] ADD  CONSTRAINT [DF_Promotions_Sent]  DEFAULT (getdate()) FOR [NgayGui]
GO
ALTER TABLE [dbo].[ChiTietHD] ADD  CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)) FOR [DonGia]
GO
ALTER TABLE [dbo].[ChiTietHD] ADD  CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[ChiTietHD] ADD  CONSTRAINT [DF_Order_Details_Discount]  DEFAULT ((0)) FOR [GiamGia]
GO
ALTER TABLE [dbo].[GopY] ADD  CONSTRAINT [DF_GopY_NgayGY]  DEFAULT (getdate()) FOR [NgayGY]
GO
ALTER TABLE [dbo].[GopY] ADD  CONSTRAINT [DF_GopY_CanTraLoi]  DEFAULT ((0)) FOR [CanTraLoi]
GO
ALTER TABLE [dbo].[HangHoa] ADD  CONSTRAINT [DF_Products_UnitPrice]  DEFAULT ((0)) FOR [DonGia]
GO
ALTER TABLE [dbo].[HangHoa] ADD  CONSTRAINT [DF_Products_ProductDate]  DEFAULT (getdate()) FOR [NgaySX]
GO
ALTER TABLE [dbo].[HangHoa] ADD  CONSTRAINT [DF_Products_Discount]  DEFAULT ((0)) FOR [GiamGia]
GO
ALTER TABLE [dbo].[HangHoa] ADD  CONSTRAINT [DF_Products_Votes]  DEFAULT ((0)) FOR [SoLanXem]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_OrderDate]  DEFAULT (getdate()) FOR [NgayDat]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_RequireDate]  DEFAULT (getdate()) FOR [NgayCan]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_ShippedDate]  DEFAULT (((1)/(1))/(1900)) FOR [NgayGiao]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_PaymentMethod]  DEFAULT (N'Cash') FOR [CachThanhToan]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_ShippingMethod]  DEFAULT (N'Airline') FOR [CachVanChuyen]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_Freight]  DEFAULT ((0)) FOR [PhiVanChuyen]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_Orders_Status]  DEFAULT ((0)) FOR [MaTrangThai]
GO
ALTER TABLE [dbo].[HoiDap] ADD  CONSTRAINT [DF_HoiDap_NgayDua]  DEFAULT (getdate()) FOR [NgayDua]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_Customers_Gender]  DEFAULT ((0)) FOR [GioiTinh]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_Customers_Birthday]  DEFAULT (getdate()) FOR [NgaySinh]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_Customers_Photo]  DEFAULT (N'Photo.gif') FOR [Hinh]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_Customers_Active]  DEFAULT ((0)) FOR [HieuLuc]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_Customers_UserLevel]  DEFAULT ((0)) FOR [VaiTro]
GO
ALTER TABLE [dbo].[PhanQuyen] ADD  CONSTRAINT [DF_PhanQuyen_Them]  DEFAULT ((0)) FOR [Them]
GO
ALTER TABLE [dbo].[PhanQuyen] ADD  CONSTRAINT [DF_PhanQuyen_Sua]  DEFAULT ((0)) FOR [Sua]
GO
ALTER TABLE [dbo].[PhanQuyen] ADD  CONSTRAINT [DF_PhanQuyen_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
ALTER TABLE [dbo].[PhanQuyen] ADD  CONSTRAINT [DF_PhanQuyen_Xem]  DEFAULT ((0)) FOR [Xem]
GO
ALTER TABLE [dbo].[TaiKhoanNhaCungCap] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[TaiKhoanNhaCungCap] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[BanBe]  WITH CHECK ADD  CONSTRAINT [FK_BanBe_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[BanBe] CHECK CONSTRAINT [FK_BanBe_KhachHang]
GO
ALTER TABLE [dbo].[BanBe]  WITH CHECK ADD  CONSTRAINT [FK_QuangBa_HangHoa] FOREIGN KEY([MaHH])
REFERENCES [dbo].[HangHoa] ([MaHH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BanBe] CHECK CONSTRAINT [FK_QuangBa_HangHoa]
GO
ALTER TABLE [dbo].[ChiTietHD]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDon] ([MaHD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHD] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[ChiTietHD]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([MaHH])
REFERENCES [dbo].[HangHoa] ([MaHH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHD] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[ChuDe]  WITH CHECK ADD  CONSTRAINT [FK_ChuDe_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChuDe] CHECK CONSTRAINT [FK_ChuDe_NhanVien]
GO
ALTER TABLE [dbo].[GopY]  WITH CHECK ADD  CONSTRAINT [FK_GopY_ChuDe] FOREIGN KEY([MaCD])
REFERENCES [dbo].[ChuDe] ([MaCD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GopY] CHECK CONSTRAINT [FK_GopY_ChuDe]
GO
ALTER TABLE [dbo].[HangHoa]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([MaLoai])
REFERENCES [dbo].[Loai] ([MaLoai])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HangHoa] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[HangHoa]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HangHoa] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_TrangThai] FOREIGN KEY([MaTrangThai])
REFERENCES [dbo].[TrangThai] ([MaTrangThai])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_TrangThai]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[HoiDap]  WITH CHECK ADD  CONSTRAINT [FK_HoiDap_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoiDap] CHECK CONSTRAINT [FK_HoiDap_NhanVien]
GO
ALTER TABLE [dbo].[PhanCong]  WITH CHECK ADD  CONSTRAINT [FK_PhanCong_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[PhanCong] CHECK CONSTRAINT [FK_PhanCong_NhanVien]
GO
ALTER TABLE [dbo].[PhanCong]  WITH CHECK ADD  CONSTRAINT [FK_PhanCong_PhongBan] FOREIGN KEY([MaPB])
REFERENCES [dbo].[PhongBan] ([MaPB])
GO
ALTER TABLE [dbo].[PhanCong] CHECK CONSTRAINT [FK_PhanCong_PhongBan]
GO
ALTER TABLE [dbo].[PhanQuyen]  WITH CHECK ADD  CONSTRAINT [FK_PhanQuyen_PhongBan] FOREIGN KEY([MaPB])
REFERENCES [dbo].[PhongBan] ([MaPB])
GO
ALTER TABLE [dbo].[PhanQuyen] CHECK CONSTRAINT [FK_PhanQuyen_PhongBan]
GO
ALTER TABLE [dbo].[PhanQuyen]  WITH CHECK ADD  CONSTRAINT [FK_PhanQuyen_TrangWeb] FOREIGN KEY([MaTrang])
REFERENCES [dbo].[TrangWeb] ([MaTrang])
GO
ALTER TABLE [dbo].[PhanQuyen] CHECK CONSTRAINT [FK_PhanQuyen_TrangWeb]
GO
ALTER TABLE [dbo].[TaiKhoanNhaCungCap]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[YeuThich]  WITH CHECK ADD  CONSTRAINT [FK_Favorites_Customers] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[YeuThich] CHECK CONSTRAINT [FK_Favorites_Customers]
GO
ALTER TABLE [dbo].[YeuThich]  WITH CHECK ADD  CONSTRAINT [FK_YeuThich_HangHoa] FOREIGN KEY([MaHH])
REFERENCES [dbo].[HangHoa] ([MaHH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[YeuThich] CHECK CONSTRAINT [FK_YeuThich_HangHoa]
GO
USE [master]
GO
ALTER DATABASE [Hshop2023] SET  READ_WRITE 
GO
