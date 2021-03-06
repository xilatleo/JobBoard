/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2012 (11.0.2100)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
ALTER TABLE [dbo].[UserDetails] DROP CONSTRAINT [FK_UserDetails_AspNetUsers]
GO
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT [FK_OpenPositions_Positions]
GO
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT [FK_OpenPositions_Locations]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT [FK_Applications_UserDetails]
GO
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT [FK_Applications_OpenPositions]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[UserDetails]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[Positions]
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[OpenPositions]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[Locations]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[Applications]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 10/15/2019 9:09:30 AM ******/
DROP TABLE [dbo].[__MigrationHistory]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[OpenPositionID] [int] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[ApplicationDate] [date] NOT NULL,
	[ManagerNotes] [varchar](2000) NULL,
	[IsDeclined] [bit] NOT NULL,
	[ResumeFileName] [varchar](75) NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[StoreNumber] [varchar](10) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [char](2) NOT NULL,
	[ManagerID] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpenPositions](
	[OpenPositionID] [int] IDENTITY(1,1) NOT NULL,
	[PositionID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
 CONSTRAINT [PK_OpenPositions] PRIMARY KEY CLUSTERED 
(
	[OpenPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Positions](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[JobDescription] [varchar](max) NULL,
 CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 10/15/2019 9:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetails](
	[UserID] [nvarchar](128) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[ResumeFileName] [varchar](75) NOT NULL,
 CONSTRAINT [PK_UserDetails] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201910150244435_InitialCreate', N'JobBoard.UI.MVC.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EE338127D5F60FF41D0D3EE2263E532DDE80DEC19A49D6426BB9D0BDA4963DF1AB4443B424BA446A2320916F365FB309F34BFB0458992255E74B115DB1934D0B0C8E2A962B148168BC5FCF1BFDFC73F3E8781F584E3C4A764621F8D0E6D0B13977A3E594EEC942DBEFB60FFF8C35FFF32BEF0C267EB4B4177C2E9A0254926F62363D1A9E324EE230E51320A7D37A6095DB0914B430779D4393E3CFCA77374E46080B001CBB2C69F53C2FC10671FF039A5C4C5114B51704D3D1C24A21C6A6619AA7583429C44C8C513FB5F74FE91A2D81B3D5C8DAEBF4C47790BDB3A0B7C04D2CC70B0B02D4408658881ACA70F099EB19892E52C820214DCBF4418E8162848B0E8C3E98ABC6B770E8F79779C55C302CA4D1346C39E804727423F8EDC7C2D2DDBA5FE408317A069F6C27B9D6971625F79382BFA4C035080CCF0741AC49C78625F972CCE92E806B351D17094435EC600F72B8DBF8DAA880756E77607A53D1D8F0EF9BF036B9A062C8DF184E094C52838B0EED279E0BBFFC62FF7F41B269393A3F9E2E4C3BBF7C83B79FF3D3E7957ED29F415E86A05507417D308C7201B5E94FDB72DA7DECE911B96CD2A6D72AD802DC1D4B0AD6BF4FC0993257B844973FCC1B62EFD67EC1525C2B81E880F33091AB13885CF9B3408D03CC065BDD3C893FFDFC0F5F8DDFB41B8DEA0277F990DBDC41F264E0CF3EA330EB2DAE4D18FF2E9551BEFAF82EC32A621FFAEDB575EFB7546D3D8E59DA146927B142F31AB4B377656C6DBC9A439D4F0665DA0EEBF69734955F3D692F20EAD33130A16DB9E0D85BCAFCBB7B3C59D45110C5E665A5C234D06A7DFB04612C28125D1AD4CE8A8AB0911E8DA9F7945BC08911F0CB02476E0021EC9C28F435CF6F223050344A4B7CC7728496045F07E46C96383E8F07300D167D84D6330D4194361F4EADCEE1E29C1376938E7F6BF3D5E830DCDFDAFF412B98CC61784B7DA18EF1375BFD1945D10EF1C31FCC0DC02907FDEFB61778041C439735D9C249760CCD89B5270B80BC02BC24E8E7BC3F1456AD72EC934407EA8F749A4E5F46B41BAF24BF4148A6F6220D3F9274DA27EA24B9F7413B520358B9A53B48A2AC8FA8ACAC1BA492A28CD826604AD72E65483797CD9080DEFF265B0FBEFF36DB6799BD6828A1A67B042E29F30C1312C63DE1D620CC76435025DD68D5D380BD9F071A6AFBE37659CBEA0201D9AD55AB3215B04869F0D19ECFECF864C4C287EF23DEE9574380815C400DF895E7FC66A9F739264DB9E0EB56E6E9BF976D600D374394B12EAFAD92CD084C04400A32E3FF870567B3423EF8D1C11818E81A1FB7CCB8312E89B2D1BD52D39C70166D83A73F310E114252EF254354287BC1E82153BAA46B05564A42EDC3F149E60E938E68D103F042530537DC2D469E113D78F50D0AA25A965C72D8CF7BDE421D79CE30813CEB055135D98EB03215C80928F34286D1A1A3B158B6B364483D76A1AF336177635EE4A7C622B36D9E23B1BEC52F86FAF6298CD1ADB827136ABA48B00C6A0DE2E0C549C55BA1A807C70D93703954E4C0603152ED5560CB4AEB11D18685D256FCE40F3236AD7F197CEABFB669EF583F2F6B7F54675EDC0366BFAD833D3CC7D4F68C3A0058E55F33C9FF34AFCCC34873390539CCF12E1EACA26C2C16798D543362B7F57EB873ACD20B2113501AE0CAD05545C072A40CA84EA215C11CB6B944E78113D608BB85B23AC58FB25D88A0DA8D8D56BD10AA1F9F25436CE4EA78FB267A5352846DEE9B050C1D11884BC78D53BDE4129A6B8ACAA982EBE701F6FB8D23131180D0A6AF15C0D4A2A3A33B8960AD36CD792CE21EBE3926DA425C97D3268A9E8CCE05A1236DAAE248D53D0C32DD84845F52D7CA0C956443ACADDA6AC1B3B79C69428183B86D4AAF1358A229F2C2BA956A2C49AE57956D3EF66FD938FC21CC371134D0E52296DC989D1182DB1540BAC41D24B3F4ED83962688E789C67EA850A99766F352CFF05CBEAF6A90E62B10F14D4FC77DEC270895FDB6F558744E05C422F43EED564A1748D0DE89B5B3CFD0D0528D644EFA73448436276B2CCADF33BBC6AFBBC4445183B92FC8A13A5684C7175EBEAEF3438EAC41870A04A3F66FDC1324398545E78A155A59B3C53334A11A8AAA29882573B1B3C9343D37BC0647FB1FF78B522BCCEFC12492A550051D413A392E7A08055EABAA3D65351AA98F59AEE8852BE491552AAEA216535ABA42664B5622D3C8346F514DD39A879245574B5B63BB226A3A40AADA95E035B23B35CD71D5593745205D65477C75E65A0C80BE91EEF60C653CC465B587ED8DD6C0F3360BCCEAA38CC1658B9D3AF02558A7B62895B7B054C94EFA545194F7C1B59541EE7D8CCA20C18E615A876235E5F801AAFF1CD98B56BEEDA22DF74CD6FC6EB67B7AF6A1DCAA14F2629B997873FE990371607AEF64736CA092C27B1AD428DB0C1BF240C87234E309AFD124C031FF3E5BC20B846C45FE084E5A91DF6F1E1D1B1F446677FDECB3849E2059A03ABE9D14C7DCCB690A5459E50EC3EA258CD99D8E04DC90A5409475F110F3F4FECFF66AD4EB3C806FF95151F5857C903F17F49A1E23E4EB1F59B9A033A4C8E7D87571DA5A0BFBD89E712DD557EF59FAF79D303EB3686E9746A1D4A8A5E67F8EB8F287A499337DD409AB59F56BCDDD9567BAFA0459566CBFACF13E63E1BE4694221E5DF42F4FCF7BEA2699F1F6C84A879623014DE202A343D215807CBF87CC0834F963D1FE8D759FD73827544333E25F0497F30F92141F765A868B9C37D487368DAC69294E9B935117BA3ACCC5DEF4D4ABEF646135DCDC9EE013768DEF5662ECA1BCB671E6CEBD4A42B0F86BD4BBB7FF51CE57D494B5E39EDBBCD46DE660272C3E5D29F2AEF780F32E534993FBBCF2EDEB6AD99A2C07B9EA2D92F8778CF8C4D6CF3BBCF14DEB6B19902C47B6E6CBDF281F7CCD676B57FEED8D23A6FA13BCFEE5513950CB739BA28725BF66E1E7287E3FF9C8211E41E65FEE8529F2ED694EADAC2704562666ACE5393192B1347E1AB5034B3EDD757B1E1377656D034B335647736F116EB7F236F41D3CCDB9033B98BBC636DD6A22E17BC651D6B4AA57A4B79C6B59EB4A4B5B7F9AC8D57F36F29AD7810A5D4668FE176F9ED64110FA29221A74E8FAC61F5A218F6CECADF6C84FD3BF1972B08FE171C09766BBB6649734516B4D8BC25890A122942738D19F2604B3D8B99BF402E836A1E80CE5E8D67413D7E0D32C7DE15B94D599432E8320EE7412DE0C59D8026FE596A745DE6F16DC4BF9221BA0062FA3C707F4B3EA67EE095725F6A62420608EE5D88702F1F4BC6C3BECB9712E986928E40427DA553748FC32800B0E496CCD0135E473630BF4F7889DC975504D004D23E1075B58FCF7DB48C5198088C557BF8041BF6C2E71FFE0F3D7264D2BA540000, N'6.2.0-61023')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'7e0e2a2d-6147-40b3-a6fa-8b51f3baeae3', N'Admin')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3696a1ea-7f36-409d-81ff-5990c30fcb89', N'7e0e2a2d-6147-40b3-a6fa-8b51f3baeae3')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'3696a1ea-7f36-409d-81ff-5990c30fcb89', N'admin@example.com', 0, N'AMuyGtvCk63SP95xcxUcZDc/EDvUK6qRtOgqdggQwUvKKajYnm1HpGIcjDvzUvLknw==', N'58714281-0790-4892-80c3-f75164a62089', NULL, 0, 0, NULL, 0, 0, N'admin@example.com')
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (1, N'QVR', N'OverlandPark', N'KS', N'Drew')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (2, N'WPK', N'KansasCity', N'MO', N'Alex')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (3, N'AAA', N'OverlandPark', N'KS', N'Will')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (4, N'AAB', N'Laurence', N'MO', N'Han')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (5, N'AAB', N'Lenexa', N'KS', N'Willis')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (6, N'AAC', N'Independence', N'MO', N'Tom')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (7, N'AAD', N'Leawood', N'KS', N'Quan')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (8, N'AAF', N'LeeSummit', N'MO', N'Danielle')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (9, N'ABA', N'Olathe', N'KS', N'Gwen')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (10, N'ABB', N'Lenexa', N'KS', N'Rodrigo')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (11, N'ABC', N'BlueSpring', N'MO', N'John')
INSERT [dbo].[Locations] ([LocationID], [StoreNumber], [City], [State], [ManagerID]) VALUES (12, N'ABD', N'Gladstone', N'MO', N'Wyren')
SET IDENTITY_INSERT [dbo].[Locations] OFF
SET IDENTITY_INSERT [dbo].[OpenPositions] ON 

INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (10, 1, 1)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (11, 1, 2)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (12, 2, 4)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (13, 3, 2)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (14, 4, 6)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (15, 5, 8)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (16, 6, 10)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (17, 4, 2)
INSERT [dbo].[OpenPositions] ([OpenPositionID], [PositionID], [LocationID]) VALUES (18, 9, 11)
SET IDENTITY_INSERT [dbo].[OpenPositions] OFF
SET IDENTITY_INSERT [dbo].[Positions] ON 

INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (1, N'Device & Computer Repair Technician', N'Serves customers by diagnosing, troubleshooting and repairing devices while ensuring customer satisfaction. Soldering and console experience would be best.')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (2, N'UBreakIFix Store Manager', N'Are you looking for a dynamic career path with a rapidly growing company? Since 2009, UBREAKIFIX has grown to over 500 stores across the U.S. and we’re currently looking for new members to join our team! Are you tech-savvy? Do you enjoy working with smart phones, tablets, and/or computer hardware? Come join one of the largest and most reputable electronics repair companies in the US.')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (3, N'UI/UX Designer/Developer', N'Qualifications: At least five (5) years professional experience in web design and development or equivalent related experience and/or training; or equivalent combination of education and experience.')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (4, N'Mobile Application Developer', N'Essential Qualifications')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (5, N'Associate Software Engineer', N'What you''ll do...')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (6, N'Dietary Aide/Server', N'Armour Oaks Senior Living is seeing the following:')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (7, N'Chef', N'Primary Responsibilities:')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (8, N'Sales Associate', N'Overview')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (9, N'Call Center Marketing Representatives ', N'DON’T START A JOB; START YOUR CAREER. CUSTOMER SERVICE IS THE NEW MARKETING…………….')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (10, N'Real Estate Marketing Assistant', N'MarketingAssistant')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (11, N'Project Scheduler - Entry Level', N'Executive Assistant REQUIREMENTS:')
INSERT [dbo].[Positions] ([PositionID], [Title], [JobDescription]) VALUES (12, N'Entry level marketing', N'This is a 100% commission based opening for an all around innovative marketing and sales position in the exciting field of residential and commercial lending.')
SET IDENTITY_INSERT [dbo].[Positions] OFF
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_OpenPositions] FOREIGN KEY([OpenPositionID])
REFERENCES [dbo].[OpenPositions] ([OpenPositionID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_OpenPositions]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_UserDetails] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserDetails] ([UserID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_UserDetails]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[OpenPositions]  WITH CHECK ADD  CONSTRAINT [FK_OpenPositions_Locations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[OpenPositions] CHECK CONSTRAINT [FK_OpenPositions_Locations]
GO
ALTER TABLE [dbo].[OpenPositions]  WITH CHECK ADD  CONSTRAINT [FK_OpenPositions_Positions] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Positions] ([PositionID])
GO
ALTER TABLE [dbo].[OpenPositions] CHECK CONSTRAINT [FK_OpenPositions_Positions]
GO
ALTER TABLE [dbo].[UserDetails]  WITH CHECK ADD  CONSTRAINT [FK_UserDetails_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[UserDetails] CHECK CONSTRAINT [FK_UserDetails_AspNetUsers]
GO
