create database [ATM]
USE [ATM]
GO
/****** Object:  Table [dbo].[ACCOUNT_TRANSFER]    Script Date: 4/20/2020 9:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT_TRANSFER](
	[TransferID] [nchar](5) NOT NULL,
	[ACCnoSource] [nchar](5) NULL,
	[ACCnoDestination] [nchar](5) NULL,
	[TransferTime] [datetime] NULL,
	[Amount] [int] NULL,
 CONSTRAINT [PK_ACCOUNT_TRANSFER] PRIMARY KEY CLUSTERED 
(
	[TransferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ACCOUNTS]    Script Date: 4/20/2020 9:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNTS](
	[ACCno] [nchar](5) NOT NULL,
	[Cno] [nchar](5) NULL,
	[DateExpired] [date] NULL,
	[PIN] [nchar](10) NULL,
	[Balance] [int] NULL,
	[WorkingStatus] [bit] NULL,
 CONSTRAINT [PK_ACCOUNTS] PRIMARY KEY CLUSTERED 
(
	[ACCno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CUSTOMERS]    Script Date: 4/20/2020 9:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMERS](
	[Cno] [nchar](5) NOT NULL,
	[Cname] [nvarchar](50) NULL,
	[Caddress] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_CUSTOMERS] PRIMARY KEY CLUSTERED 
(
	[Cno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TRANSACTIONS]    Script Date: 4/20/2020 9:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSACTIONS](
	[TranID] [nchar](5) NOT NULL,
	[ACCno] [nchar](5) NULL,
	[TranTime] [datetime] NULL,
	[WithDraw] [int] NULL,
 CONSTRAINT [PK_TRANSACTIONS] PRIMARY KEY CLUSTERED 
(
	[TranID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[ACCOUNT_TRANSFER] ([TransferID], [ACCnoSource], [ACCnoDestination], [TransferTime], [Amount]) VALUES (N'TF001', N'AC001', N'AC002', CAST(N'2020-04-05 13:31:43.757' AS DateTime), 500)
INSERT [dbo].[ACCOUNT_TRANSFER] ([TransferID], [ACCnoSource], [ACCnoDestination], [TransferTime], [Amount]) VALUES (N'TF002', N'AC004', N'AC002', CAST(N'2020-04-06 09:16:10.893' AS DateTime), 700)
INSERT [dbo].[ACCOUNT_TRANSFER] ([TransferID], [ACCnoSource], [ACCnoDestination], [TransferTime], [Amount]) VALUES (N'TF003', N'AC001', N'AC002', CAST(N'2020-04-06 10:21:27.030' AS DateTime), 1000)
INSERT [dbo].[ACCOUNT_TRANSFER] ([TransferID], [ACCnoSource], [ACCnoDestination], [TransferTime], [Amount]) VALUES (N'TF004', N'AC001', N'AC002', CAST(N'2020-04-06 10:27:46.317' AS DateTime), 1000)
INSERT [dbo].[ACCOUNT_TRANSFER] ([TransferID], [ACCnoSource], [ACCnoDestination], [TransferTime], [Amount]) VALUES (N'TF005', N'AC001', N'AC002', CAST(N'2020-04-06 10:38:14.397' AS DateTime), 200)
INSERT [dbo].[ACCOUNT_TRANSFER] ([TransferID], [ACCnoSource], [ACCnoDestination], [TransferTime], [Amount]) VALUES (N'TF006', N'AC002', N'AC003', CAST(N'2020-04-08 15:52:46.870' AS DateTime), 300)
INSERT [dbo].[ACCOUNTS] ([ACCno], [Cno], [DateExpired], [PIN], [Balance], [WorkingStatus]) VALUES (N'AC001', N'C0001', CAST(N'2020-12-31' AS Date), N'678909    ', 1200, 1)
INSERT [dbo].[ACCOUNTS] ([ACCno], [Cno], [DateExpired], [PIN], [Balance], [WorkingStatus]) VALUES (N'AC002', N'C0002', CAST(N'2021-10-15' AS Date), N'654321    ', 200, 1)
INSERT [dbo].[ACCOUNTS] ([ACCno], [Cno], [DateExpired], [PIN], [Balance], [WorkingStatus]) VALUES (N'AC003', N'C0003', CAST(N'2020-12-25' AS Date), N'123123    ', 800, 1)
INSERT [dbo].[ACCOUNTS] ([ACCno], [Cno], [DateExpired], [PIN], [Balance], [WorkingStatus]) VALUES (N'AC004', N'C0004', CAST(N'2020-01-18' AS Date), N'456123    ', 500, 1)
INSERT [dbo].[CUSTOMERS] ([Cno], [Cname], [Caddress], [Email]) VALUES (N'C0001', N'Chuc', N'Danang', N'chuc@gmail.com')
INSERT [dbo].[CUSTOMERS] ([Cno], [Cname], [Caddress], [Email]) VALUES (N'C0002', N'Khoa', N'Hue', N'khoa@gmail.com')
INSERT [dbo].[CUSTOMERS] ([Cno], [Cname], [Caddress], [Email]) VALUES (N'C0003', N'Ha', N'Danang', N'ha@gmail.com')
INSERT [dbo].[CUSTOMERS] ([Cno], [Cname], [Caddress], [Email]) VALUES (N'C0004', N'Thuy', N'Quangnam', N'thuy@gmail.com')
INSERT [dbo].[CUSTOMERS] ([Cno], [Cname], [Caddress], [Email]) VALUES (N'C0005', N'Tan', N'Hue', N'tan@gmail.com')
INSERT [dbo].[TRANSACTIONS] ([TranID], [ACCno], [TranTime], [WithDraw]) VALUES (N'Tr001', N'AC001', CAST(N'2020-04-15 19:53:06.860' AS DateTime), 700)
INSERT [dbo].[TRANSACTIONS] ([TranID], [ACCno], [TranTime], [WithDraw]) VALUES (N'Tr002', N'AC002', CAST(N'2020-04-15 19:53:06.860' AS DateTime), 500)
INSERT [dbo].[TRANSACTIONS] ([TranID], [ACCno], [TranTime], [WithDraw]) VALUES (N'Tr003', N'AC003', CAST(N'2020-04-15 19:53:06.860' AS DateTime), 300)

Select * from ACCOUNT_TRANSFER
select * from ACCOUNTS
create trigger TRG_ACCOUNT_TRANSFER
on ACCOUNT_TRANSFER
for insert
as
	begin
		update ACCOUNTS
		set ACCOUNTS.Balance = ACCOUNTS.Balance - inserted.Amount
		from ACCOUNTS inner join inserted on ACCOUNTS.ACCno=inserted.ACCnoSource
		update ACCOUNTS
		set ACCOUNTS.Balance = ACCOUNTS.Balance + inserted.Amount
		from ACCOUNTS inner join inserted on ACCOUNTS.ACCno=inserted.ACCnoDestination
	end

Insert into ACCOUNT_TRANSFER
values ('TF007', 'AC002', 'AC004', getdate(), 500)

Insert into ACCOUNT_TRANSFER
values ('TF008', 'AC001', 'AC003', getdate(), 400)



	

