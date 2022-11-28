create database THUECANHO
use ThueCanHo 
create table KhachThue (MaKhach char(6) not null primary key, TenKhach varchar(50) not null, GioiTinh bit not null, 
DiaChi varchar(300) not null, DienThoai char(10) not null, NgaySinh date not null)
create table HopDongThueCanHo (SoHopDong char(6) not null primary key, MaKhach char(6) not null, MaCanHo char(6) not null,
NgayThue date not null, NgayTra date not null, ThoiGianThue datetime, GiaTriHopDong int, DatTruoc int, ConLai int)
create table CanHoChoThue (MaCanHo char(6) not null primary key, LoaiCanHo varchar(15) not null, DienTich varchar(10) not null, SoPhongNgu int not null, GiaThue varchar(10) not null)
Alter Table HopDongThueCanHo
Add Constraint FK_KhachThue Foreign Key(MaKhach) References KhachThue(MaKhach)
Alter Table HopDongThueCanHo
Add Constraint FK_CanHoChoThue Foreign Key(MaCanHo) References CanHoChoThue(MaCanHo)
-----------------------------------------------------
Insert Into KhachThue
Values ('000001','Nguyen Van Minh',1, 'TamKy','0354275464','2000-10-31'),
('000002','Ngyen Van B',1, 'TamKy','0905500000','2000-02-29'),
('000003','Nguyen Thi C',0, 'DaNang','0935500000','2000-02-28'),
('000004','Nguyen Van D',1,'Hue','0979500000','2000-02-27'),
('000005','Nguyen Thi E',0,'QuangTri','0123500000','2000-02-26')
Select * from KhachThue
-----
Insert Into CanHoChoThue
Values ('CCPS01','Cao cap','100m2',3,'20trieu'),
('CCPS02','Cao cap','110m2',3,'21trieu'),
('CCPS03','Cao cap','120m2',3,'22trieu'),
('BTPS01','Binh Thuong','60m2',2,'6trieu'),
('BTPS02','Binh Thuong','50m2',2,'5trieu')
Select * from CanHoChoThue
------
Insert Into HopDongThueCanHo (SoHopDong, MaKhach, MaCanHo, NgayThue, NgayTra)
Values ('S00001','000001','CCPS01','2018-02-01','2018-03-01'),
 ('S00002','000002','CCPS02','2018-02-01','2018-03-01'),
 ('S00003','000003','CCPS03','2018-02-01','2018-03-01'),
 ('S00004','000004','BTPS01','2018-02-01','2018-03-01'),
 ('S00005','000005','BTPS02','2018-02-01','2018-03-01')
 Select * from HopDongThueCanHo
 -----------------------------------
 Alter table KhachThue
 Add Email varchar(50)
 --------------------------------
 Alter table CanHoChoThue
 Drop column SoPhongNgu




