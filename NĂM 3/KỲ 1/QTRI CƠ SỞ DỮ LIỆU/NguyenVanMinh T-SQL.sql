---Cau1:chuyển đổi đầu số điện thoại di động theo quy định của
---bộ Thông tin và truyền thông cho một khách hàng bất kì,
---ví dụ với: Dương Ngọc Long
select	*	from customer where Cust_name like N'Dương Ngọc Long'

declare @sdt nvarchar(100)
select @sdt = cust_phone
from customer
where Cust_name like N'Dương Ngọc Long'
if (@sdt like '016%') ---viettel
begin 
	Update customer
	set @sdt = '03' + RIGHT(@sdt,8)
	print @sdt
end
 else if @sdt like '012[0-2]%' or @sdt like '0126%' or @sdt like '0128%' ---moobi
begin
	update customer
	set @sdt = '07' + RIGHT(@sdt,8)
	print @sdt
end
else if @sdt like '012[3-5]%' or @sdt like '0127%' or @sdt like '0129%' ---vina
begin
	update customer
	set @sdt = '08' +right(@sdt,8)
	print @sdt
end
else if @sdt like '0186%' 
begin
	update customer 
	set @sdt = '056' + right(@sdt,7)
end
else if @sdt like '0188%' 
begin
	update customer 
	set @sdt = '058' + right(@sdt,7)
end
else
begin
	print @sdt
end

--cau 2)Trong vòng 1 năm trở lại đây Nguyễn Lê Minh Quân có thực hiện giao dịch nào không? Nếu có, hãy trừ 50.000 phí duy trì tài khoản. 
declare @icount int
set @icount = (select count(*) from transactions join account on transactions.ac_no = account.ac_no
												 join customer on account.Cust_id = customer.Cust_id
			  where cust_name = N'Nguyễn Lê Anh Quân'
			  and year(getdate()) - year(t_date) = 1)
if @icount > 0
begin 
	update account set ac_balance = ac_balance - 50000
	from account join customer on account.cust_id= customer.Cust_id
	where Cust_name = N'Nguyễn Lê Anh Quân'
end 
else
begin
	print N'Nguyễn Lê Anh Quân không thực hiện giao dịch nào trong vòng 1 năm trở lại đây'
end

--cau 3:Trần Quang Khải thực hiện giao dịch gần đây nhất vào thứ mấy? (thứ hai, thứ ba, thứ tư,…, chủ nhật) và vào mùa nào
--(mùa xuân, mùa hạ, mùa thu, mùa đông)?
declare @t_date date
set @t_date = (select top 1 t_date from transactions join account on transactions.ac_no = account.ac_no
													  join customer on account.Cust_id = customer.Cust_id
				where cust_name = N'Trần Quang Khải'
				order by t_date desc)
if DATEPART(dw, @t_date) = 1
	print N'Chủ Nhật'	
else if DATEPART(dw, @t_date) = 2
	print N'Thứ hai'
else if DATEPART(dw, @t_date) = 3
	print N'Thứ ba'
else if DATEPART(dw, @t_date) = 4
	print N'Thứ tư'
else if DATEPART(dw, @t_date) = 5
	print N'Thứ năm'
else if DATEPART(dw, @t_date) = 6
	print N'Thứ sáu'
else 
	print N'Thứ bảy'

if DATEPART(quarter, @t_date) = 1
	print N'Mùa Xuân'
else if DATEPART(quarter, @t_date) = 2
	print N'Mùa Hè'
else if DATEPART(quarter, @t_date) = 3
	print N'Mùa Thu'
else if DATEPART(quarter, @t_date) = 4
	print N'Mùa Đông'

--Cách 2:
Declare @thu int, @quy int, @thu1 nvarchar(50), @quy1 nvarchar(50)
Set @thu  = (select top 1 DATEPART(dw,t_date)
from transactions join account on transactions.ac_no=account.Ac_no
				  join customer on customer.Cust_id = account.cust_id
where Cust_name=N'Trần Quang Khải'
order by t_date DESC, t_time DESC)
Set @quy = (select top 1 DATEPART(q,t_date)
from transactions join account on transactions.ac_no=account.Ac_no
				  join customer on customer.Cust_id = account.cust_id
				  where Cust_name=N'Trần Quang Khải'
				order by t_date DESC, t_time DESC)
set @thu1 = case @thu when 1 then N'Chủ nhật'
					 when 2 then N'Thứ hai'
					 when 3 then N'Thứ ba'
					 when 4 then N'Thứ bốn'
					 when 5 then N'Thứ năm'
					 when 6 then N'Thứ sáu'
					 else N'Thứ bảy'
					 end
set @quy1 = case @quy when 1 then N'Mùa xuân'
					 when 2 then N'Mùa hạ'
					 when 3 then N'Mùa thu'
					 else N'Mùa đông'
					 end
print @thu1
print @quy1
---------------------------------------------------------------------------
--4. Đưa ra nhận xét về nhà mạng mà Lê Anh Huy đang sử dụng?(Viettel, Mobie phone, Vinaphone, Vietnamobie, khác)
declare @sdt nvarchar(100)
select @sdt = cust_phone
from customer
where Cust_name like N'Lê Anh Huy'
if @sdt like '03[2-9]%' or @sdt like '086%'or @sdt like '09[6-8]%'
begin 
	print N'Lê Anh Huy đang sử nhà mạng Viettel'
end
else if @sdt like '089%' or @sdt like '090%' or @sdt like '093%' 
		or @sdt like '070%' or @sdt like '07[6-9]%'
begin
	Print N'Lê Anh Huy đang sử nhà mạng Mobi Phone'
end
else if @sdt like  '08[1-5]%' or @sdt like '088%' or @sdt like '091%' or @sdt like '094%' 
begin
	print N'Lê Anh Huy dùng hãng VINAPHONE'
end
else if @sdt like N'092' or @sdt like '058' or @sdt like '056'
begin
	print N'Lê Anh Huy dùng hãng Vietnamobie'
end
else 
begin
	print N'Lê Anh Huy dùng hãng Khác'
end

--5. Số điện thoại của Trần Quang Khải là số tiền, số lùi ha số lộn xộn.
-- Định nghĩa: trừ 3 số đầu tiên, các số còn lại tăng dần gọi là số, ví dụ: 098356789 là số tiến
declare @sodt nvarchar(100)
select @sodt = cust_phone
from customer
where Cust_name like N'Trần Quang Khải'

if @sdt like N'___%'


--6.	Hà Công Lực thực hiện giao dịch gần đây nhất vào buổi nào(sáng, trưa, chiều, tối, đêm)?
declare @t_date date, @t_time time, @buoi nvarchar(50)
set @t_date = (select top 1 t_date from customer join account on account.cust_id = customer.Cust_id 
									join transactions on transactions.ac_no = account.Ac_no 
									where Cust_name = N'Hà Công Lực'
									order by t_date desc)
set @t_time = (select top 1 t_time from customer join account on account.cust_id = customer.Cust_id 
									join transactions on transactions.ac_no = account.Ac_no 
									where Cust_name = N'Hà Công Lực' and t_date = @t_date
									order by t_date desc)
set @buoi = case when  DATEPART(HOUR,@t_time) between 5 and 10 then N'Sáng'
				 when DATEPART(HOUR,@t_time) between 10 and 13 then N'Trưa'
				 when DATEPART(HOUR,@t_time) between 13 and 19 then N'Chiều'
				 when DATEPART(HOUR,@t_time) between 19 and 24 then N'Tối'
				 else N'Đêm' end
print cast(@t_time as nvarchar(50)) + ' ' + cast(@buoi as nvarchar(50));

--7.	Chi nhánh ngân hàng mà Trương Duy Tường đang sử dụng thuộc miền nào?
-- Gợi ý: nếu mã chi nhánh là VN  miền nam, VT  miền trung, VB  miền bắc, còn lại: bị sai mã
Go
declare @br_id nchar(10)
set @br_id = (	select left(Branch.Br_id,2) from customer join Branch on Branch.BR_id = customer.Br_id 
				where Cust_name = N'Trương Duy Tường')
if (@br_id = 'VN')
	print N'Miền Nam';
else if (@br_id = 'VT')
	print N'Miền Trung';
else if (@br_id = 'VB')
	print N'Miền Bắc';
else 
	print 'Bị sai mã'
Go
--8.	Căn cứ vào số điện thoại của Trần Phước Đạt, hãy nhận định anh này dùng dịch vụ di động của hãng nào:
-- Viettel, Mobi phone, Vina phone, hãng khác.
declare @sdt nvarchar(100)
select @sdt = cust_phone
from customer
where Cust_name like N'Trần Phước Đạt'
if @sdt like '03[2-9]%' or @sdt like '086%'or @sdt like '09[6-8]%'
begin 
	print N'Trần Phước Đạt đang sử nhà mạng Viettel'
end
else if @sdt like '089%' or @sdt like '090%' or @sdt like '093%' 
		or @sdt like '070%' or @sdt like '07[6-9]%'
begin
	Print N'Trần Phước Đạt đang sử nhà mạng Mobi Phone'
end
else if @sdt like  '08[1-5]%' or @sdt like '088%' or @sdt like '091%' or @sdt like '094%' 
begin
	print N'Trần Phước Đạt dùng hãng VINAPHONE'
end
else	
begin
	print N'Trần Phước Đạt dùng hãng Khác'
end

--9.	Hãy nhận định Lê Anh Huy ở vùng nông thôn hay thành thị.
-- Gợi ý: nông thôn thì địa chỉ thường có chứa chữ “thôn” hoặc “xóm” hoặc “đội” hoặc “xã” hoặc “huyện”
GO
DECLARE  @diachi NVARCHAR(100)
SELECT  @diachi = Cust_ad
FROM dbo.customer WHERE Cust_name=N'Lê Anh Huy'
IF @diachi LIKE N'%Thôn%' OR @diachi LIKE N'%Xóm%' OR @diachi LIKE N'%Huyện%' OR @diachi LIKE N'%Đội%'
BEGIN 
	PRINT N'Nông thôn'
END
ELSE
BEGIN
	PRINT N'Thành thị'
END
GO
--10.	Hãy kiểm tra tài khoản của Trần Văn Thiện Thanh,
-- nếu tiền trong tài khoản của anh ta nhỏ hơn không hoặc bằng không nhưng 6 tháng gần đây không có giao dịch
-- thì hãy đóng tài khoản bằng cách cập nhật ac_type = ‘K’
DECLARE @taikhoan NVARCHAR(100), @tg DATE , @type CHAR(10), @dem NVARCHAR(100)

SELECT @taikhoan = ac_balance , @tg=t_date , @type= t_type , @dem=t_id
FROM dbo.customer	JOIN dbo.account ON account.cust_id = customer.Cust_id
					JOIN dbo.transactions ON transactions.ac_no = account.Ac_no
WHERE Cust_name=N'Trần Văn Thiện Thanh' 
IF @taikhoan < 0  OR  ( @taikhoan = 0  AND @tg between dateadd(mm,-6,getdate()) and getdate() AND COUNT(@dem)=0 )

BEGIN
	UPDATE dbo.transactions
	SET t_type = 'k'
	FROM dbo.customer	JOIN dbo.account ON account.cust_id = customer.Cust_id
						JOIN dbo.transactions ON transactions.ac_no = account.Ac_no
	WHERE Cust_name=N'Trần Văn Thiện Thanh'
	PRINT N'Đã đóng tài khoản'
END
ELSE
BEGIN
	PRINT N'Giữ nguyên tài khoản'
END

--11.	Mã số giao dịch gần đây nhất của Huỳnh Tấn Dũng là số chẵn hay số lẻ? 

declare @num int
set @num = ( select top 1 t_id from customer	join account on account.cust_id = customer.Cust_id 
									join transactions on transactions.ac_no = account.Ac_no 
									where Cust_name = N'Huỳnh Tấn Dũng'
									order by t_id desc)
print @num
if @num%2 = 0
	print N'Số chẵn'
else
	print N'Số lẻ'

--Cau12: Có bao nhiêu giao dịch diễn ra trong tháng 9/2016 
--với tổng tiền mỗi loại là bao nhiêu (bao nhiêu tiền rút, bao nhiêu tiền gửi)
declare	@id nvarchar(100), @TTGui numeric, @TTRut numeric

set		@id = (	select	count(*)
				from	transactions
				where	datepart(mm,t_date)=9 and datepart(yy,t_date)=2016)
	print	N'Tổng số lần giao dịch là: ' + @id
set		@TTGui = (	select	sum(t_amount)
					from	transactions
					where	t_type = 1 and datepart(mm,t_date)=9 and datepart(yy,t_date)=2016)
	print	N'Tổng số tiền gửi là: ' + cast(@TTGui as nvarchar(100))
set		@TTRut = (	select	sum(t_amount)
					from	transactions
					where	t_type = 0 and datepart(mm,t_date)=9 and datepart(yy,t_date)=2016)
	print	N'Tổng số tiền gửi là: ' + cast(@TTRut as nvarchar(100))

--Cau12: Ở Hà Nội ngân hàng Vietcombank có bao nhiêu chi nhánh và có bao nhiêu khách hàng? 
--Trả lời theo mẫu: “Ở Hà Nội, Vietcombank có … chi nhánh và có …khách hàng”
declare @CN int, @KH int
select	@CN = count(*)
from	Branch
where	BR_name = N'Vietcombank Hà Nội'
select	@KH = count(customer.Cust_id)
from	Branch join customer on Branch.BR_id=customer.Br_id
where	BR_name = N'Vietcombank Hà Nội'
print	N'Ở Hà Nội, Vietcombank có ' + cast(@CN as nvarchar(5)) + N' chi nhánh và có ' + cast(@KH as nvarchar(5)) + N' khách hàng'

select * from Branch where BR_name = N'Vietcombank Hà Nội'

--Cau13. Tài khoản có nhiều tiền nhất là của ai, số tiền hiện có trong tài khoản đó là bao nhiêu? 
--TK đó thuộc chi nhánh nào

declare	@money numeric, @CN nvarchar(100), @name nvarchar(100)
select @name = Cust_name, @money = ac_balance, @CN = BR_name
from account a join customer c on a.cust_id=c.Cust_id
				join Branch b on c.Br_id=b.BR_id
where	ac_balance = (	select max(ac_balance) from	account a )
print	N'Tài khoản có nhiều tiền nhất là của ' + cast(@name as nvarchar(100)) 
		+ N', Số tiền hiện có trong tài khoản là ' +cast(@money as nvarchar(100))
print N'Thuộc chi nhánh ' +cast(@CN as nvarchar(100))


--Cau14. Có bao nhiêu khách hàng ở Đà Nẵng?
declare	@KH nvarchar(100)
select	@KH = count(*)
from	customer
where	Cust_ad like N'%Đà Nẵng%'
print	N'Có ' + @KH + N' khách hàng ở Đà Nẵng'

GO
declare	@money numeric, @CN nvarchar(100), @name nvarchar(100)
select @name = Cust_name, @money = ac_balance, @CN = BR_name
from account a join customer c on a.cust_id=c.Cust_id
				join Branch b on c.Br_id=b.BR_id
where	ac_balance = (	select max(ac_balance)
						from	account a )
print	N'Tài khoản có nhiều tiền nhất là của ' + cast(@name as nvarchar(100)) 
		+ N', Số tiền hiện có trong tài khoản là ' +cast(@money as nvarchar(100))
print N'Thuộc chi nhánh ' +cast(@CN as nvarchar(100))
GO

--15.	Có bao nhiêu khách hàng ở Đà Nẵng?

declare	@KH nvarchar(100)
select	@KH = count(*)
from	customer
where	Cust_ad like N'%Đà Nẵng%'
print	N'Có ' + @KH + N' khách hàng ở Đà Nẵng'

--16.	Có bao nhiêu khách hàng ở Quảng Nam nhưng mở tài khoản Sài Gòn
Go
declare	@KH nvarchar(100)
select	@KH = count(*)
from	account a	join customer c on a.cust_id=c.Cust_id
					join Branch b on c.Br_id=b.BR_id
where	Cust_ad like N'%Quảng Nam%' and BR_ad like N'%Sài Gòn%'
print	N'Có ' + @KH + N' KH ở Quảng Nam nhưng mở tài khoản Sài gòn'
GO

--17.	Ai là người thực hiện giao dịch có mã số 0000000387, thuộc chi nhánh nào? Giao dịch này thuộc loại nào?

declare @name nvarchar(100), @CN nvarchar(100), @loai numeric
select	@name = Cust_name, @CN = BR_name, @loai = t_type
from	transactions t	join account a on t.ac_no=a.Ac_no
						join customer c on a.cust_id=c.Cust_id
						join Branch b on c.Br_id=b.BR_id
where	t_id = 0000000387
print	@name + N' là người thực hiện giao dịch có mã số ‘0000000387’,thuộc chi nhánh ' + @CN
if		@loai = 1
begin
	print N'Giao dịch này thuộc loại gửi tiền'
end
else
begin
	print N'Giao dịch này thuộc loại rút tiền'
end

--Cau18. Hiển thị ds KH gồm: Họ và tên, sđt và số lượng tài khoản đang có. Nhận xét
--Nếu < 1 TK => Bất thường, còn lại Bình thường ?

declare @DS table  (name nvarchar(50),
					phone varchar(15),
					SLTK int,
					Note nvarchar(30))
Insert into @DS select Cust_name, Cust_phone, COUNT(Ac_no), IIF(COUNT(ac_no) < 1, N'Bất thường', N'Bình thường')
				from customer join account on customer.Cust_id = account.cust_id
				group by Cust_name, Cust_phone

select * from @DS
--Cau19. Viết đoạn code nhận xét tiền trong TK của ông Hà Công Lực
-- <1000 => ít  ;   < 50000 => TB   ;   còn lại => nhiều.
declare	@money numeric
select	@money = ac_balance
from	account a join customer c on a.cust_id=c.Cust_id
where	Cust_name like N'Hà Công Lực'
if		@money < 100000
begin
	print N'Tiền trong TK của ông Hà Công Lực ít'
end
else
if		@money < 5000000 and @money >=100000
begin
	print N'Tiền trong TK của ông Hà Công Lực trung bình'
end
else
begin
	print N'Tiền trong TK của ông Hà Công Lực nhiều'
end

--20.	Hiển thị danh sách các giao dịch của chi nhánh Huế với các thông tin: mã giao dịch,
-- thời gian giao dịch, số tiền giao dịch, loại giao dịch (rút/gửi), số tài khoản.
--*Ví dụ:
--Mã giao dịch	   Thời gian G     Số tiền GD	  Loại GD	Số tài khoản
--00133455	    2017-11-30 09:00	3000000	        Rút	     04847374948



--21.	Kiểm tra xem khách hàng Nguyễn Đức Duy có ở Quang Nam hay không?

declare	@que nvarchar(100)
select	@que = Cust_ad
from	customer
where	Cust_name like N'Nguyễn Đức Duy'
if		@que like N'%Quảng Nam%'
begin
	print N'Nguyễn Đức Duy có quê ở Quang Nam'
end
else
begin
	print N'Nguyễn Đức Duy không có quê ở Quang Nam'
end

--22.	Điều tra số tiền trong tài khoản ông Lê Quang Phong có hợp lệ hay không? 
--(Hợp lệ: tổng tiền gửi – tổng tiền rút = số tiền hiện có trong tài khoản). 
--Nếu hợp lệ, đưa ra thông báo “Hợp lệ”, ngược lại hãy cập nhật lại tài khoản
--sao cho số tiền trong tài khoản khớp với tổng số tiền đã giao dịch (ac_balance = sum(tổng tiền gửi) – sum(tổng tiền rút)




--23.	Chi nhánh Đà Nẵng có giao dịch gửi tiền nào diễn ra vào ngày chủ nhật hay không?
-- Nếu có, hãy hiển thị số lần giao dịch, nếu không, hãy đưa ra thông báo “không có”



--24.	Kiểm tra xem khu vực miền bắc có nhiều phòng giao dịch hơn khu vực miền trung ko?
-- Miền bắc có mã bắt đầu bằng VB, miền trung có mã bắt đầu bằng VT
--------------------------------------------------
--------------------VÒNG LẶP----------------------
--------------------------------------------------

--1.In ra dãy số lẻ từ 1 – n, với n là giá trị tự chọn
declare @i int = 1, @n int = 20
while (@i < @n  )
begin
	if(@i%2 = 1)
		print @i
	set @i =@i + 1
end
go

--2.In ra dãy số chẵn từ 0 – n, với n là giá trị tự chọn
declare @i int = 0, @n int = 20
while (@i <= @n  )
begin
	if(@i%2 = 0)
		print @i
	set @i =@i + 1
end
go

--5.	In bảng cửu chương

DECLARE @sonhan INT = 2
DECLARE @sodem2 INT 
DECLARE @tich INT
	WHILE (@sonhan <= 9 )
		BEGIN
			SET @sodem2 = 1
			WHILE (@sodem2 <= 10)
		BEGIN
			SET @tich = @sonhan * @sodem2
		PRINT convert(varchar,@sonhan) + ' * ' + convert(varchar,@sodem2)+ ' = ' +convert(varchar,@tich)
		SET @sodem2 +=1
END
SET @sonhan+= 1
END


