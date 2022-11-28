--1. Trả về tên chi nhánh ngân hàng nếu biết mã của nó
--input: br_id
--output: br_name

create proc spTenCN @ma char(5), @ten nvarchar(50) out
as
begin
	select	@ten = br_name
	from	branch
	where	br_id = @ma
end

declare @name nvarchar(50)
exec	spTenCN 'VB001', @name out
print	@name

--2. Trả về tên, địa chỉ và sđt của KH nếu biết mã khách
--input: cust_id
--output: cust_name, cust_ad, cust_phone

create proc pThongTinKH @mak char(6), @ten nvarchar(50) out, @diachi nvarchar(150) out, @sdt varchar(15) out
as
begin
	select	@ten = cust_name , @diachi = cust_ad , @sdt = cust_phone
	from	customer
	where	Cust_id = @mak
end

declare	@ten nvarchar(50), @diachi nvarchar(150), @sdt varchar(15)
exec	pThongTinKH '000001', @ten out, @diachi out, @sdt out
print	@ten
print	@diachi
print	@sdt

--3. In ra ds KH của 1 chi nhánh cụ thể nếu biết mã chi nhánh đó.
--input: mã chi nhánh 
--output: danh sách khách hàng
create proc pDS @maCN char(5)
as
begin
	select	cust_name, cust_phone, cust_ad
	from	customer		
	where	customer.Br_id = @maCN
end

exec	pDS 'VT009'


--4. Kiểm tra thông tin khách hàng đã tồn tại trong hệ thống hay chưa nếu biết họ tên và sđt.
-- Tồn tại trả về 1, không tồn tại trả về 0
---input: họ tên, số điện thoại
----op: có tồn tại trong hệ thống, không
create proc pTest @name nvarchar(50), @phone varchar(15), @ret numeric(1) out
as
begin
	declare	@ktra char(6)
	select	@ktra = count(*)
	from	customer
	where	Cust_name = @name and Cust_phone = @phone
	if		@ktra >0
		begin
			set @ret = 1
		end
		else
		begin
			set @ret = 0
		end
end

declare	@ret numeric(1)
exec	ptest N'Trương Nhật Minh', '0354217772', @ret out
print	@ret


--5. Cập nhật số tiền trong tài khoản nếu biết mã số tài khoản và số tiền mới. 
--thành công trả về 1, thất bại trả về 0.
create proc pupdate @maTK char(10), @tien numeric(15,0), @ret numeric (1) out
as
begin
		update	account
		set		ac_balance = @tien
		where	Ac_no = @matk
		if @@ROWCOUNT >0
		begin
			set @ret = 1
		end
		else
		begin
			set @ret = 0
		end
end

declare	@ret numeric(1)
exec	pupdate '100000001', '10000000', @ret out
print	@ret

--6. Cập nhật địa chỉ của khách hàng nếu biết mã số của họ. Thành công trả về 1, thất bại trả về 0
create proc pupdatedc @makh char(6),@admoi nvarchar(150), @ret numeric(1) out
as
begin
	update	customer
	set		Cust_ad = @admoi
	where	Cust_id = @makh
	if		@@ROWCOUNT > 0
	begin
		set @ret = 1
	end
	else
	begin
		set @ret = 0
	end
end

declare	@ktra char(1)
exec	pupdatedc '000001', N'101 Núi Thành, Đà Nẵng', @ktra out
print	@ktra

select * from customer

--7. Trả về số tiền có trong tài khoản nếu biết mã tài khoản
create proc spMoney @MaTK char(10), @tien numeric(15,0) out
as
begin
	select	@tien = ac_balance 
	from	account
	where	Ac_no = @matk
end

declare	@tien numeric(15,0)
exec	spMoney '1000000002', @tien out
print	@tien

--8. Trả về số lượng khách hàng, tổng tiền trong các tài khoản nếu biết mã chi nhánh
alter proc spKtra @MaCN char(5), @slkh int out, @tongtien numeric(15,0) out
as
begin
	select	@slkh = count(*), @tongtien = sum(ac_balance)
	from	Branch b join customer c on b.BR_id= c.Br_id join account a on c.Cust_id=a.cust_id
	where	b.Br_id = @MaCN
end

declare	@slkh int, @tongtien numeric(15,0)
exec	spKtra 'VT009', @slkh out, @tongtien out
print	N'Số lượng khách hàng:' + cast(@slkh as nvarchar(50))
print	N'Tổng tiền:' + cast(@tongtien as nvarchar(50))

--9. Ktra 1 giao dịch có bất thường hay không nếu biết mã giao dịch. 
--Giao dịch bất thường: giao dịch gửi diễn ra ngoài giờ hành chính, 
--gd rút diễn ra vào thời điểm 0 am - 3 am

alter proc pktra @magd char(10), @ktrgd nvarchar(50) out
as
begin
	declare	@loai char(1), @tg time
	select	@loai = t_type, @tg = t_time
	from	transactions
	where	t_id = @magd
	if		( @loai = 1 and datepart(hh,@tg) not between '7' and '17')
			or ( @loai = 0 and datepart(hh,@tg) between '0' and '3') 
	begin
			set @ktrgd = N'Có giao dịch bất thường'
	end
	else
	begin
			set @ktrgd = N'Không có giao dịch bất thường'
	end
end

declare		@kq nvarchar(50)
exec		pktra '0000000202', @kq out
print		@kq



--10. Tính mã gd mới. Mã gd tiếp theo được tính như sau: MAX(mã gd đang có) + 1. 
--Hãy đảm bảo sl ký tự luôn đúng với quy định về mã gd

alter proc	pGetTranID @ret varchar(10) out
as
begin
	declare	@newID varchar(10), @lenID numeric(2), @numOfZero numeric(2), @zero varchar(10)
	set		@zero = ''	--Khởi tạo giá trị cho chuỗi các số 0
	set		@newID = (select max(cast(t_id as numeric)) from transactions) + 1	--Tìm giá trị của ID mới
	set		@lenID = (select top 1 len(t_id) from transactions)	--Tìm độ dài của t_id
	set		@numOfZero = @lenID - len(@newID)

	while	@numOfZero > 0	-- tạp ra 1 chuỗi các số 0 điền vào trước giá trị ID
	begin
		set	@zero = @zero + '0'
		set	@numOfZero = @numOfZero - 1
	end
	set		@ret = @zero + @newID
end

--test
declare @ret varchar(10)
exec	pGetTranID @ret out
print	@ret

--12
--input: mã khách hàng, loại tài khoản, số tiền trong tài khoản
--process: a) kiểm tra mã khách hàng đã tồn tài trong bản customer? Nếu chưa, ngừng xử lý
--		   b) Kiểm tra loại tài khoản có hợp lệ hay không? Nếu không, ngừng xử lý
--		   c.	Kiểm tra số tiền có hợp lệ không? Nếu NULL thì để mặc định là 50000, nhỏ hơn 0 thì ngừng xử lý.
--		   d.	Tính số tài khoản mới. Số tài khoản mới bằng MAX(các số tài khoản cũ) + 1
--		   e.	Thêm mới bản ghi vào bảng ACCOUNT với dữ liệu đã có.
--ouput:

create proc themmoitk @cust_id varchar(10), @ac_type int, ac_balance int, @rep varchar(10) ouutput
as
begin
	declare @iCount int = 0
	set @iCount = (select count(*) from account join customer on account.cust_id = customer.Cust_id
							where customer.Cust_id = @cust_id)
	if @iCount > 0
		set @ac_type = (select ac_type from account)
			if @ac_type > 1
				set @ac_balance (select ac_balance from account where ac_type = 1)
					if @ac_balance is null
						set @ac_balance = 0
						

					else if (ac_balance > 0)
					begin
						print 'Stop'
						return
					end
					else
					begin
						print 'Stop'
					end
end

----13.	Kiểm tra thông tin khách hàng đã tồn tại trong hệ thống hay chưa nếu biết họ tên và số điện thoại.
----Tồn tại trả về 1, không tồn tại trả về 0
alter function fktra (@ten nvarchar(50), @sdt varchar(15))
returns	numeric
as
begin
	declare	@ktra numeric(12)
	select	@ktra = count(*)
	from	customer
	where	Cust_name = @ten and Cust_phone = @sdt
	if		@ktra >0
	set		@ktra = '1'
	else
	set		@ktra = '0'
	return	@ktra
end

select	dbo.fktra (N'Hà Công Lực','01283388103')
----14.	Tính mã giao dịch mới. Mã giao dịch tiếp theo được tính như sau:
---MAX(mã giao dịch đang có) + 1. 
----Hãy đảm bảo số lượng kí tự luôn đúng với quy định về mã giao dịch
alter proc spTaotk (@Cust_id varchar(10), @ac_type varchar(1), @ac_balance int, @kt int out)
as
	begin
		set @kt = (select Count(*) from customer where Cust_id = @Cust_id)
	if @kt <= 0
		begin
			set @kt = 0
			return
		end
	if (@ac_type <> '0' and @ac_type <> '1')
		begin
			set @kt = 0
			return
		end
	if @ac_balance <= 0
		begin
			set @kt = 0
			return
		end
	else if @ac_balance is null
		set @ac_balance = 50000
declare @Ac_no varchar(20)
set @Ac_no = (select max(Ac_no) from account) + 1
insert into account values (@Ac_no,@ac_balance,@ac_type,@Cust_id)
if @@ROWCOUNT > 0
set @kt = 1
else
set @kt = 0
end
--test
declare @kt int
exec spTaotk'000001','1',90000, @kt out
print @kt

