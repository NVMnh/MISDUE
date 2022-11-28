	/*1. Tạo hàm sau:
	a) Tạo mã nhân viên mới theo quy tắc: mã nhân viên mới = max(mã nhân viên cũ) + 1.
	Có chèn những số '0' đằng trước nếu độ dài chưa đủ độ dài
	b) Kiểm tra một mã nhân viên đã tồn tại trong bảng NHANVIEN hay chưa?
	Input: mã nhân viên
	Output: 1(có tồn tại), 0(chưa tồn tại)
	*/
	--1a)
	create function fNewNVID()
	returns varchar(5)
	begin
			declare @MaNVMAX varchar(5), @lenMAX int, @len int, @newID varchar(5)
			set @MaNVMAX = (select max(cast(right(manv, 4) as int)) from nhanvien) + 1
			set @len = len(@MaNVMAX)
			set @lenMAX = (select top 1 len(manv) from nhanvien)
			if @len < @lenMAX - 1
				begin
					set @newID = 'N'+replicate('0',@lenMAX - @len - 1) + cast(@MaNVMAX as varchar)
				end
			else
				begin
	set @newID = 'N' + cast(@MaNVMAX as varchar)
	end
	return @newID
	end
	select dbo.fnewNVID()
	--1b
	create function fCheckNV(@manv char(5))
	returns numeric(1)
	begin
	declare @count int = 0
	select @count = count(*) from nhanvien where manv = @manv
	if @count > 0
	return 1
	return 0
	end
	select dbo.fCheckNV('N9991')
	/*
	2. Tạo thủ tục thêm mới nhân viên như mô tả dưới đây:
	Input: mã nhân viên, tên nhân viên, ngày sinh, địa chỉ, lương, giới tính, mã phòng ban, số điện thoại, Email
	Output: 1(nếu thêm mới thành công), 0(nếu thêm mới thất bại)
	Process:
	B1: Kiểm tra mã nhân viên đã tồn tại chưa? Nếu đã tồn tại, đưa ra thông báo lỗi và kết thúc
	B2: Tạo mới mã nhân viên --YÊU CẦU SAI, BỎ QUA BƯỚC NÀY
	B3: Thêm mới 1 record vào bảng NHANVIEN với các giá trị input đã cho. Nếu thành công trả về 1, thất bại trả về
	0
	*/
	create proc pInsertNV @manv char(5), @tennv nvarchar(50), @ngaysinh date, @diachi nvarchar(250), @luong money,
	@gioitinh bit, @mapb char(3), @sodt varchar(12), @email varchar(100), @out int out
	as
	begin
	declare @TonTai int, @newID varchar(5)
	set @TonTai = dbo.fCheckNV(@manv) --goi ham da tao o bai tren
	if @TonTai = 1
	begin
	set @out = 0
	return
	end
	insert into nhanvien values(@manv, @tennv, @ngaysinh, @diachi, @luong, @gioitinh, @mapb, @sodt, @email)
	if @@rowcount <= 0
	begin
	set @out = 0
	end
	return 1
	end
	declare @ret int
	exec pInsertNV 'N9999', N'Cao Thị Nhâm', '01/01/2000', N'An Hải Bắc', 900000, 0, 'A01',
	'0988363808','nhamct@abc.com', @ret out
	print @ret
	------------đề--------
	--1. Xây dựng hàm tìm FID mới
	--IP: None
	--OP: FID mới
	--Process: FID mới = max(FID cũ)  + 1

	create function fNewFID ()
	returns int 
	as
	begin
		declare @newID int
		select @newID = max(FID) + 1 from Feeds
		return @newID
	end

	select dbo.fNewFID()

	--Câu 2: 
	create function fCheckTime1(@FID bigint )
	returns numeric
	as
	begin
		declare @FTime time, @FDate date, @FHour int
		select @FTime = FTime, @FDate = FDate From Feeds
		where FID = @FID
		if DATEDIFF (dd,@FDate, GETDATE()) <0
			return 0
		else if (CONVERT (TIME, GETDATE()) < @FTime) and DATEDIFF(DD,@FDate, getdate()) =0
			return 0
		return 1
	end

------cau 3
create proc pInsertFeeds @ngay date, @gio time, @diadiem nvarchar(100), @noidung nvarchar(1000), 
@email varchar(100), @ret int out
as
begin
--a
	declare @check int 
	set @check = dbo.fCheckTime2(@ngay, @gio)
	if @check = 0
	begin
		set @ret = 0
		return
	end
--b
	if @noidung is null
	begin
		set @ret = 0
		return
	end
--c
	if not exists (select email from accounts where email = @email)
	begin
		set @ret = 0
		return
	end
--d
	declare @newID numeric
	set @newID = dbo.fNewID()

	insert into feeds values(@newID, @ngay, @gio, @diadiem, @noidung, 0,0,0, @email)
	if @@ROWCOUNT = 0
		set @ret = 0
	else
		set @ret = 1
end

-----cau 4
create trigger tUpdatecommentNo
on COMMENTS
after delete, insert
as
begin
	declare @them int, @xoa int, @fid numeric
	select @them= CID from inserted
	select @xoa = CID from deleted

	if @them is not null --insert
	begin
		select @fid = fid from inserted
		update feeds set commentNO = commentNO + 1
		where FID @fid
	end
	else
	begin --delete
	select @fid = fid from deleted
	update feeds set commentNO - 1
	where FID @fid
end

-----cau 5
create trigger tDelComment
on Feeds
instead of delete
as
begin
	delete Comments where FID = (select FID from deleted)
	delete Feeds where Fid = (select FID from deleted)
end