----------------Q1
create database SALSE 
use  SALSE 
create table Items (Ino	char (6) not null primary key, Iname varchar(50) not null ,  TaxRate float not null,
UnitPrice int not null, AmountAvailable float not null)
create table Customers (Cno char (6) not null primary key, Cname varchar(50) not null, Caddress varchar(150) not null,
Email varchar(50) not null)
create table Orders (Ono char (4) not null ,Ino	char (6) not null, Odate datetime not null,Cno char (6) not null,
 Amount float not null, Tax float , Total float)
 Alter Table Orders
Add Constraint PK_Orders Primary key(Ono, Ino)
 Alter Table Orders 
Add Constraint FK_Items Foreign Key(Ino) References Items(Ino)
Alter Table Orders 
Add Constraint FK_Customers Foreign Key(Cno) References Customers(Cno)
------------------Q2
Insert into Items
Values ('000001', 'ADIDAS', 0.1, 100, 150),
('000002', 'NIKE', 0.1, 200, 250),
('000003', 'CONVERSE', 0.1, 300, 350),
('000004', 'VANS', 0.1, 400, 450),
('000005', 'YEEZY', 0.1, 500, 550)
Select * from Items
Insert into Customers 
Values ('000011', 'Nguyen Van Minh', 'Tam Kỳ', 'minh1@gmail.com'),
('000012', 'Nguyen Van B', 'Điên Bàn', 'minh2@gmail.com'),
('000013', 'Nguyen Thi C', 'Đà Nẵng', 'minh3@gmail.com'),
('000014', 'Nguyen Van D', 'Huế', 'minh4@gmail.com'),
('000015', 'Nguyen Thi E', 'Sài Gòn', 'minh5@gmail.com')
Select * from Customers
Insert into Orders
Values ('1101', '000001', '2019-03-01', '000011', 100, 0.1, 500),
('1102', '000002', '2019-03-02', '000012', 200, 0.1, 600),
('1103', '000003', '2019-03-03', '000013', 300, 0.1, 700),
('1104', '000004', '2019-04-04', '000014', 400, 0.1, 800),
('1105', '000005', '2019-04-05', '000015', 500, 0.1, 900)
Select * from Orders
------------------Q3
Update Orders
set Total = 0, Tax = 0
Update Orders
set Total = Amount* UnitPrice
From Orders inner join Items on Orders.Ino = Items.Ino
------------------Q4
Update Orders
set Tax = Total * TaxRate
From Orders inner join Items on Orders.Ino = Items.Ino
------------------Q5
Select top 2 *from Orders
where (MONTH(Odate) = 3 and YEAR(Odate) = 2019)
order by Amount DESC
------------------Q6
Select * from Orders
where Ono = '1101'
------------------Q7
Select DATEPART(QUARTER,Orders.Odate) as Quarter_2019, Iname as [Item name],
 Sum(Amount) as [Sum of Amount]
from Orders inner join Items on Orders.Ino=Items.Ino
group by DATEPART(QUARTER,Orders.Odate), Iname
order by Quarter_2019 ASC
