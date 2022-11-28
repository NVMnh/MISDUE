
create database QUANLY_CAFE
use QUANLY_CAFE

create table TAIKHOAN
(
	TenDangNhap varchar(10) not null primary key,
	MatKhau varchar(100) not null,
)

create table NHANVIEN 
(
	MaNV varchar(2) not null primary key,
	TenNV varchar(50)not null
)

create table BAN
(
	SoBan varchar(20) not null primary key,
	TinhTrang nvarchar(50) not null
)

create table NUOCUONG
(
	MaNuocUong char(3)not null primary key,
	TenMon nvarchar(100) not null,
	Gia int
)

create table HOADON
(
	MaHD char(6) not null primary key,
	MaNV varchar(2),
	NgayBan date,
	GioBan time,
	SoBan varchar(20) not null,
	
)

create table HOADONCT
(
	MaHD char(6) not null,
	MaNuocUong char(3) not null,
	SoLuong int,
	primary key(MaHD, MaNuocUong)
)

Alter table HOADONCT
Add constraint FK_HOADON foreign key(MaHD) references HOADON(MaHD)
Alter table HOADONCT
Add constraint FK_NUOCUONG foreign key(MaNuocUong) references NUOCUONG(MaNuocUong)
Alter table HOADON
Add constraint FK_BAN foreign key(SoBan) references BAN(SoBan)
Alter table HOADON
Add constraint FK_NHANVIEN foreign key(MaNV) references NHANVIEN(MaNV)


--Thêm dữ liệu
insert into TAIKHOAN
values	('abc1','csdl@2020'),
		('abc2','csdl@2020')

insert into NHANVIEN
values  ('01','Thungan1'),
		('02','Thungan2')

insert into BAN
values	('01',N'Trống'),
		('02',N'Trống'),
		('03',N'Trống'),
		('04',N'Có Khách'),
		('05',N'Trống'),
		('06',N'Có Khách'),
		('07',N'Có Khách'),
		('08',N'Trống'),
		('09',N'Có Khách'),
		('10',N'Trống'),
		('11',N'Trống'),
		('12',N'Có Khách'),
		('13',N'Trống'),
		('14',N'Trống'),
		('15',N'Có Kháchg'),
		('16',N'Trống'),
		('17',N'Có Khách'),
		('18',N'Trống'),
		('19',N'Có Khách'),
		('20',N'Có Khách')
select * from BAN

insert into NUOCUONG
values	('111',N'Cà Phê Đen', 13000),
		('112',N'Cà Phê Sữa', 17000),
		('113',N'Cà Phê Dừa', 31000),
		('114',N'Bạc Xỉu', 25000),
		('115',N'Cà Phê Trứng', 35000),
		('116',N'Cà Phê Kem Chesse', 27000),
		('117',N'Espresso', 15000),
		('118',N'Americano', 27000),
		('119',N'Cappuccino', 42000),
		('120',N'Latte', 44000),
		('121',N'Trà Đào', 29000),
		('122',N'Trà Đào Cam Sả', 35000),
		('123',N'Trà Vải', 29000),
		('124',N'Trà Táo Chanh Sả', 29000),
		('125',N'Trà Gừng Chanh Sả', 29000), 
		('126',N'Trà Cúc Cam Sả', 29000),
		('127',N'Trà Thảo Mộc Dưỡng Nhan', 45000),
		('128',N'Trà Thảo Mộc Ngủ Ngon', 45000),
		('129',N'Sữa Dừa Trân Châu Đường Đen', 32000),
		('130',N'Sữa Tươi Trân Châu Đường Đen', 30000),
		('131',N'Sữa Tươi Matcha Trân Châu Đường Đen', 32000),
		('132',N'Sữa Tươi', 21000),
		('133',N'Sữa chua Nha Đam Hạt Chia', 29000),
		('134',N'Đá Xay chocolate Dừa', 35000),
		('135',N'Sinh Tố Xoài Tươi', 33000),
		('136',N'Sinh Tố Dâu Tây Tươi', 35000),
		('137',N'Sinh Tố Kiwi', 31000),
		('138',N'Nước Chanh', 19000),
		('139',N'Nước Chanh Muối Nha Đam', 25000),
		('140',N'Chanh Sả Tắc', 21000),
		('141',N'Cam Tươi', 25000),
		('142',N'Cam Tươi Mật Ong', 29000)

insert into HOADON(MaHD, MaNV, NgayBan, GioBan, SoBan)
values	('191101', '01', '2020-11-20', '19:40', '04'),
		('191102', '01', '2020-11-20', '20:40', '16'),
		('191103', '01', '2020-11-20', '19:30', '09'),
		('191104', '01', '2020-11-20', '18:40', '08'),
		('191105', '01', '2020-11-20', '20:10', '06'),
		('191106', '01', '2020-11-20', '20:11', '14'),
		('201101', '02', '2020-11-21', '21:15', '04'),
		('201102', '02', '2020-11-21', '20:17', '19'),
		('201103', '02', '2020-11-21', '19:48', '12'),
		('201104', '02', '2020-11-21', '19:36', '02')

insert into HOADONCT(MaHD, MaNuocUong, SoLuong)
values	('191101', '128', '1'),
		('191101','123',' 1'),
		('191101','124', '1' ),
		('191101','125', '1'),
		('191101','138', '1'),
		('191102','134', '1'),
		('191103','128', '1'),
		('191103','130', '2'),
		('191103','131', '1'),
		('191104','128', '1'),
		('191104','123', '1'),
		('191104','124', '1'),
		('191104','125', '1'),
		('191104','138', '1'),
		('191105','111', '1'),
		('191106','116', '1'),
		('191106','126', '1'),
		('201101','118','2'),
		('201102','137','1'),
		('201102','136','2'),
		('201102','118','1'),
		('201103','138', '1'),
		('201103','132',' 1'),
		('201104','131', '1'),
		('201104','130',' 1'),
		('201104','139', '1')

select * from HOADON
select * from HOADONCT
select * from NHANVIEN






create transaction tgUpdateNuocUong
on NUOCUONG
for update
as
begin
	declare @Gia1 int,@Gia2 int, @TenMon nvarchar(100),@MaNuocUong varchar(10);
	select @Gia1 = Gia from deleted
	select @Gia2 = Gia from inserted 
	update NUOCUONG set Gia = @Gia2 where TenMon =@TenMon
	update HOADONCT set Gia = @Gia2 where MaNuocUong =@MaNuocUong
	
end

Update NUOCUONG set Gia= 15000 where TenMon= 'Cà Phê Đen'
 select * from NUOCUONG where TenMon = 'Cà Phê Đen'
 select * from HOADONCT where MaNuocUong='TC111'

	---------------------------------------------------
-- INDEX
Create index iMaNuocUong
on NUOCUONG (MaNuocUong)


-- Hàm tự thêm mã hóa đơn mới
go
create function fMaHoaDon()
returns int
as
begin
	declare @newMaHD int
	select @newMaHD = max(MaHD) + 1 from HOADON
	return @newMaHD
end

select dbo.fMaHoaDon()
-- Hàm tự thêm mã nước uống mới
go
create function fMaDoUong()
returns int
as
begin
	declare @newMaNU int
	set @newMaNU = (select max(MaNuocUong) +  1 from NUOCUONG)
	return @newMaNU
end

select dbo.fMaDoUong()
go


-- Hàm thêm nước uống
go
alter proc spThemNuoc (@TenMon nvarchar(500), @Gia int)
as
begin 
	insert into NUOCUONG values (dbo.fMaDoUong(), @TenMon, @Gia)
end


exec spThemNuoc
go

select * from NUOCUONG


--Mã hóa tai khoản khi tạo mới
go
create trigger tg_MK 
on TAIKHOAN
for insert
as
begin
	update TAIKHOAN
	set MatKhau = (Select CONVERT(nvarchar(100), HASHBYTES ('MD5',i.MatKhau),1)
			  from inserted i)
	where TenDangNhap =(select i.TenDangNhap from inserted i)
end

insert into TAIKHOAN (TenDangNhap, MatKhau)
values  ('abc4','csdl@1234')
select * from TAIKHOAN
-- Mã hóa khi update lại mật khẩu

----------------BẢNG HÓA ĐƠN
---Thêm mới hóa đơn
go
alter proc spThemHD (@MaNV varchar(2),@ngayban date, @gioban time, @kiemtra int out)	
as
begin
-- Kiểm tra mã nhân viên có quá 2 kí tự không
	declare @icount int
	set @icount = (select count(MaNV) from NHANVIEN)
	set @ngayban = getdate()
	set @gioban = current_timestamp
	insert into HOADON(MaHD, MaNV, NgayBan, GioBan)
	values (dbo.fMaHoaDon(), @MaNV, @ngayban, @gioban)
	if @@ROWCOUNT > 0 
		set @kiemtra = 1
	else
		set @kiemtra = 0
end

declare @ok int
exec spThemHD  '01', @ok out
print @ok

--Sửa Hóa đơn
create proc spSuaHD (@MAHD char(6), @MaNV varchar(2), @Ban int)	
as
begin
	update HOADON set MaNV = @MaNV, SoBan = @Ban
	where MaHD = @MaHD
end

exec spSuaHD

---Xóa hóa đơn
create proc spXoaHD (@MaHD char(6))
as
begin
	delete from HOADON where MaHD = @MaHD
	delete from HOADONCT where MaHD = @MaHD
end

exec spXoaHD '191106'
select * from HOADON
-- Tìm kiếm hóa đơn
create proc spTimKiemHD ()


---Thêm mới hóa đơn chi tiết
create proc spThemHDCT (@MaHD char(6), @TenMon nvarchar(100), @SoLuong int)
as
begin
	if (dbo.fThemHDCT(@MaHD, @TenMon) = 1)
	begin
		return
	end
	else 
	begin
		Insert Into HOADONCT(MaHD, TenMon, SoLuong)
		Values (@MaHD, @TenMon, @SoLuong)
	end
end

-- Sửa hóa đơn chi tiết
create proc spSuaHDCT (@MaHD char(6), @TenMon nvarchar(100), @SoLuong int)
As
Begin
	Update HOADONCT
	set  MaHD = @MaHD, TenMon = @TenMon, SoLuong = @SoLuong
	where MaHD = @MaHD and TenMon = @TenMon
End

--Xóa hóa đơn chi tiết
create proc spXoaHDCT(@MaHD char(6), @TenMon varchar(100))
as
begin
	Delete From HOADONCT where MaHD = @MaHD and TenMon = @TenMon
end
----------------BẢNG NHÂN VIÊN
--Lấy dữ liệu bảng nhân viên 
create proc PDuLieu
as
begin 
	select * from NHANVIEN
end 
--test
exec PDuLieu

--Thêm nhân viên 
create proc pNhanVien (@MaNV varchar(2),@TenNV varchar(50),@ret bit out)
as
begin
--Kiểm tra Mã Nhân Viên đã tồn tại chưa 
if not exists(select count(*) from NHANVIEN where MaNV=@MaNV)
begin 
	set @ret = 0
	print'Đã xảy ra lỗi'
	return 
end
--Thêm thành công trả về 1, thất bại trả về 0
declare @them bit
insert into NHANVIEN values(@MaNV,@TenNV)
if @@ROWCOUNT >0
	set @ret = 1
else 
	set @ret =0
end
--test
declare @them bit
exec pNhanVien'04','Thungan4',@them out
print @them

--Tìm kiếm thông tin nhân viên 
create proc pTimKiem(@MaNV varchar(2)= null, @TenNV varchar(50)= null)
as
begin 
 select * from NHANVIEN
 where (@MaNV is null or MaNV like '%' +@MaNV +'%')
 and(@TenNV is null or TenNV like '%' +@TenNV +'%')
end
--test
declare @Timkiem varchar(100)
exec @Timkiem = dbo.pTimKiem
 @TenNV='Thungan1'
--Sửa thông tin nhân viên 
create proc pUpdateNV (@MaNV varchar(2) , @TenNV varchar(50))
as
begin 
	select * from NHANVIEN
	update NHANVIEN set MaNV = @MaNV ,TenNV =@TenNV where MaNV =@MaNV
end
--test

exec pUpdateNV'01','Thungan1'
select * from NHANVIEN
--Xóa thông tin nhân viên 
create proc pXoa (@MaNV varchar(2))
as
begin 
	delete NHANVIEN where MaNV =@MaNV
end 
--test
exec pXoa'03'
select * from NHANVIEN


-----------BẢNG NƯỚC UỐNG
----Bảng Nước Uống
--Lấy dữ liệu
create proc PDuLieuNuoc
as
begin 
	select * from NUOCUONG
end 


create proc pNuocUong (@TenMon nvarchar(100),@Gia int,@ret bit out)
as
begin
--Kiểm tra Mã Nước Uống đã tồn tại chưa
	if not exists(select count(*) from NUOCUONG)
	begin 
		set @ret = 0
		print'Đã xảy ra lỗi'
		return 
	end
--Thêm thành công trả về 1, thất bại trả về 0
	declare @them bit
	insert into NUOCUONG values(dbo.fMaDoUong(),@TenMon,@Gia)
	if @@ROWCOUNT >0
		set @ret = 1
	else 
		set @ret =0
end
--test
declare @ret bit
exec pNuocUong 'Coca','10000',@ret out
print @ret

--Tìm kiếm thông tin nước uống
create proc pTimKiemNuoc(@MaNuocUong char(3)= null, @TenMon nvarchar(100)= null,@Gia int = null)
as
begin 
 select * from NUOCUONG
 where (@MaNuocUong is null or MaNuocUong like '%' +@MaNuocUong +'%')
 and(@TenMon is null or TenMon like '%' +@TenMon +'%')
 and(@Gia is null or Gia like '%' +@Gia +'%')

end
--test
declare @TimkiemNuoc varchar(100)
exec @TimkiemNuoc = dbo.pTimKiemNuoc
 @MaNuocUong='114'
--Sửa thông tin nước uống
create proc pUpdateNuoc(@MaNuocUong char(3), @TenMon nvarchar(100),@Gia int)
as
begin 
	select * from NUOCUONG
	update NUOCUONG set Gia =@Gia where MaNuocUong=@MaNuocUong
end
--test

exec pUpdateNuoc'115','Cà Phê Trứng','37000'
select * from NUOCUONG
--Xóa thông tin nước uống
create  proc pXoaNuoc (@MaNuocUong varchar(2))
as
begin 
	delete NUOCUONG where MaNuocUong =@MaNuocUong
end 
--test
exec pXoaNuoc'125'
select * from NUOCUONG


Create trigger Tg_ThanhTien
on dbo.HoaDonCT
for insert, update 
as
begin 
	declare @MaHD char(6), @MaNuocUong char(3),@KT int,@ThanhTien int
	set @MaHD = (select MaHD from inserted )
	set @MaNuocUong = (select MaNuocUong from inserted )
	set @KT = (Select count(MaHD) from HOADON where MaHD = @MaHD)
	if @KT >0
	begin 
	update HOADONCT set @ThanhTien = (select(inserted.SoLuong * NUOCUONG.Gia)as ThanhTien from inserted join dbo.NUOCUONG 
									on NUOCUONG.MaNuocUong = HOADONCT.MaNuocUong 
									where MaHD=@MaHD)
					where MaNuocUong=@MaNuocUong and HOADONCT.MaHD =@MaHD
	end
end

insert dbo.NUOCUONG 
values
