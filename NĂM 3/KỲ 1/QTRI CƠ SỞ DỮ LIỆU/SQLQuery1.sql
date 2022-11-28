--1
select count(Cust_name) as SoLuongKhach
from customer join Branch on customer.Br_id = Branch.BR_id
where Cust_ad = N'%Quảng Nam' and BR_name = N'Vietcombank Đà Nẵng'	
--2
select Cust_name, ac_balance, BR_name
from customer join Branch on customer.Br_id = Branch.BR_id
			  join account on customer.Cust_id = account.cust_id
where BR_name = N'Vietcombank Vũng Tàu'
--3
select count(*) SoLuongKhach 
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where DATEPART(quarter, t_date) = 1 and YEAR(t_date) = 2012
--4
select DATEPART(month, t_date), count(*) Soluonggiaodich, sum(t_amount) tongtiengiaodich
from transactions
where year(t_date) = 2014
order by DATEPART(month, t_date)
--8
select cust_name, max(t_amount) Sotien
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where YEAR(t_date) = 2016 and BR_name = N'Vietcombank Huế'
group by Cust_name
--9
select max(t_amount) tienguinhieunhat
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where t_type = 1
--10
select Cust_name
from customer join Branch on customer.Br_id = Branch.BR_id
where Branch.BR_id in (select BR_id from customer 
												where Cust_name = N'Phan Nguyên')
--11
select t_id, t_date, t_time
from transactions
where DATEPART(hour, t_time) in (select DATEPART(hour, t_time)
								from transactions join account on transactions.ac_no = account.Ac_no
												  join customer on account.cust_id = customer.Cust_id
								where Cust_name = N'Lê Nguyễn Hoàng Văn' and t_date = '2016/12/02')

--13
select t_date, t_id
from transactions
where transactions.t_date in (select t_date from transactions where t_id = '0000000217')--14select t_id, t_typefrom transactionswhere transactions.t_type in (select t_type from transactions where t_id = '0000000387')--16select account.Ac_no, ac_typefrom account join transactions on transactions.ac_no = account.Ac_nowhere account.ac_no not in (select account.Ac_no from transactions join account on transactions.ac_no = account.Ac_no							where month(getdate()) - 6 <= month(t_date))--17select cust_name, sum(t_amount) as Sotien, Branch.BR_name, count(t_id) solangui 
from customer join Branch on Branch.BR_id= customer.Br_id
              join account on account.cust_id= customer.Cust_id
              join transactions on transactions.ac_no= account.Ac_no
where Cust_name = N'Phạm Duy Khánh'and t_type = 1 
									   and t_date between getdate() and '2017/01/01'
group by Branch.BR_ad
--18
select count(t_id) sogiaodich, AVG(t_amount) luongtientrungbinh, YEAR(t_date) as SoNamgiaodich
from transactions
group by t_date
--19
select count(t_id) Soluongiaodich, iif(transactions.t_date between '00:00' and '06:00', 'ban dem', 'ban ngay') as N'Dem/Ngay', transactions.t_id
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where YEAR(t_date) = 2017 and Branch.BR_name = N'Vietcombank Hà Nội' or Branch.BR_name = N'Vietcombank Sài Gòn'
group by transactions.t_id, t_date