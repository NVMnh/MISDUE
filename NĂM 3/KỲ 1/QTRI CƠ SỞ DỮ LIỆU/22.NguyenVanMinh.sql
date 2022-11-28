--Câu 1. Viết hàm kiểm tra thẻ độc giả có được phép mượn sách hay không nếu biết MaThe.
--(Thẻ được phép mượn sách là thẻ có NgayHetHan > ngày hiện tại).
--input: Mã thẻ
--ouput: được phép mượn hoặc không được phép mượn
create function fMaThe (@mathe int)
returns nvarchar(20)
as
begin
	declare @ketqua nvarchar(20)
	if (select NgayHetHan 
		from DOC_GIA
		where MaThe = @mathe) > CONVERT(date,GETDATE())
	begin
		set @ketqua = N'Được phép mượn!'
	end
	else
		set @ketqua = N'Không được phép mượn!'		
	return @ketqua
end

select dbo.fMaThe(1)

--Câu 2. Viết hàm trả về số lượng sách mà độc giả đã mượn mà chưa trả nếu biết mã thẻ của họ. 
--(sách mượn chưa trả thì cột NgayTra có giá trị NULL).

create function fTrasach (@mathe int)
returns int
as
begin
	declare @ketqua int = (select sum(SoLuong) from MUON
							where MaThe = @mathe and NgayTra is null
							group by MaThe)
	return @ketqua
end

select dbo.fTrasach(1)

--Câu 3:
create proc pThemMoi @TenSach nvarchar(200), @LoaiSach int, @TongSach int, 
			@TenTG nvarchar(200), @NamXB int,
			@SoTrang int, @GiaTien int, @TinhTrang int
as
begin
	declare @demloaisach int, @sachmoi int
	set @demloaisach = (select COUNT(*) from LOAI_SACH where MaLoai = @LoaiSach)
	--
	if (@TongSach < 1 or @SoTrang < 1 or @GiaTien < 1)
	begin
		print '0'
		return
	end
	--
	if @demloaisach < 1
	begin
		print '0'
		return
	end
	--
	if LEN(@TenSach) < 11
	begin
		print '0'
		return
	end
	set @sachmoi = (select MAX(MaSach) from SACH) + 1
	--
	insert into SACH(MaSach, TenSach, LoaiSach, TongSach, TenTG, NamXB, SoTrang, SoLuongTon, GiaTien, TinhTrang)
	values (@sachmoi, @TenSach, @LoaiSach, @TongSach, @TenTG, @NamXB, @SoTrang, @TongSach, @GiaTien, @TinhTrang)
end


--Câu 4. Khi thêm mới dữ liệu cho bảng SACH, hãy đảm bảo rằng tình trạng sách luôn khác 3 (3: sách cũ nát)

create trigger tThemmoi
on SACH
for insert
as 
begin
	declare @tinhtrang int
	select TinhTrang = @tinhtrang 
	from inserted
	if @tinhtrang  = 3
	begin
		print N'Sách cũ nát'
		rollback
	end
end

--Câu 5. Sau khi thêm mới dữ liệu cho bảng MUON, hãy cập nhật tiền phạt: 
--Nếu ngày trả <= ngày hẹn trả thì tiền phạt bằng 0, 
--ngược lại: Tiền phạt = (ngày trả - ngày hẹn trả)*5000

create trigger tTienphat
on MUON
after insert
as
begin
	declare @tienphat int
	set @tienphat = (select TienPhat from inserted)
	if (select NgayHenTra from inserted) >= (select NgayTra from inserted)
	begin
		update MUON 
		set TienPhat = 0 
		from MUON join inserted on MUON.MaThe = inserted.MaThe 
								and MUON.MaSach = inserted.MaSach
	end
	else
	begin
		update MUON 
		set MUON.TienPhat = datediff(day, inserted.NgayTra, inserted.NgayHenTra)*5000 
		from MUON join inserted on MUON.MaThe = inserted.MaThe 
								and MUON.MaSach = inserted.MaSach
	end
end

select * from MUON
insert into MUON (MaSach, MaThe, NgayMuon, NgayHenTra, NgayTra) 
values(17,17,'2020-11-21','2020-11-28','2020-11-30')

