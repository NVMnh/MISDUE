----------Cau 1
create database QL_KS
use QL_KS
create table PHONG(MaPhong char(6) not null primary key, LoaiPhong varchar(15) not null,
GiaThue float not null)
create table KHACHTHUE(MaKhach char(6) not null primary key, HoTen varchar(50) not null, 
QuocTich varchar(50) not null, NgaySinh date not null, GioiTinh bit not null)
create table HOADON(SoHoaDon char(6) not null primary key, MaPhong char(6) not null,
MaKhach char(6) not null, NgayDen date not null, NgayDi date not null, ThoiGianThue int, 
TienPhong float, TongTien float)
---
alter table HOADON
add constraint FK_PHONG foreign key (MaPhong) references PHONG(MaPhong)

alter table HOADON
add constraint FK_KHACHTHUE foreign key (MaKhach) references KHACHTHUE(MaKhach)

------Cau 2
insert into PHONG(MaPhong, LoaiPhong, GiaThue)
values ('CC0001','A',40000000),
('TT0002','B',20000000),
('TT0003','B',20000000),
('BD0004','C',10000000),
('BD0005','C',10000000)

insert into KHACHTHUE(MaKhach, HoTen, QuocTich, NgaySinh, GioiTinh)
values ('KH0011','Nguyen Van Minh','VietNam','2000/10/31', 1),
('KH0012','Nguyen Quoc Thien','My','2000/10/28', 1),
('KH0013','Ho Thi Thanh Tam','Nga','2000/11/21', 0),
('KH0014', 'Nguyen Quang Thanh','Anh','2000/9/19', 1),
('KH0015','Nguyen Le Nhat Linh','Phap','2000/8/7', 0)

insert into HOADON(SoHoaDon, MaPhong, MaKhach, NgayDen, NgayDi)
values ('000001','CC0001','KH0011','2018-03-26','2018-05-26'),
('000002','TT0002','KH0012','2018-07-01','2018-08-01'),
('000003','TT0003','KH0013','2018-06-20','2018-11-20'),
('000004','BD0004','KH0014','2018-05-01','2018-12-31'),
('000005','BD0005','KH0015','2018-08-15','2018-09-15')
select * from HOADON
select * from PHONG
select * from KHACHTHUE
--------Cau 3
update PHONG
set GiaThue=iif(LoaiPhong='A', GiaThue*1.15, iif(LoaiPhong='B', GiaThue*1.1, GiaThue*1.05))
-------Cau 4
update HOADON
set ThoiGianThue=0, TienPhong=0, TongTien=0

update HOADON
set ThoiGianThue= iif(datediff(day, NgayDen, NgayDi)=0,1,datediff(day, NgayDen, NgayDi))
-------Cau 5
update HOADON
set TienPhong = ThoiGianThue*GiaThue
from HOADON inner join PHONG on HOADON.MaPhong = PHONG.MaPhong
-------Cau 6
update HOADON
set TongTien=TienPhong + (TienPhong * 1.1)
------Cau 7
select KHACHTHUE.* from HOADON inner join KHACHTHUE on HOADON.MaKhach = KHACHTHUE.MaKhach
where month(NgayDen) = 10 and year(NgayDen) = 2019
-------Cau 8
select LoaiPhong, count(*) as SoPhongThue
from PHONG
group by LoaiPhong
------Cau 9
select Count(*) as SoLanThue, Sum(ThoiGianThue) as TongThoiGianThue, Sum(TienPhong) as TongTienPhong
from HOADON 
where (MONTH(NgayDen) = 1 or MONTH(NgayDen)= 2 or MONTH(NgayDen) = 3)  and YEAR(NgayDen) = 2019
group by MaPhong
-------cau 10
select HoTen, QuocTich, NgayDen, ThoiGianThue, LoaiPhong
from HOADON inner join PHONG on HOADON.MaPhong=PHONG.MaPhong 
inner join KHACHTHUE on HOADON.MaKhach=KHACHTHUE.MaKhach









