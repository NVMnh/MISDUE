--cau1
select count(*)
from customer join Branch on customer.Br_id= Branch.BR_id
where Cust_ad like N'%Quảng Nam' and BR_name = N'Vietcombank Đà Nẵng'

--cau 2
select Cust_name, ac_balance, BR_name 
from customer join Branch on customer.Br_id = Branch.BR_id
			  join account on customer.Cust_id = account.cust_id
where BR_name = N'Vietcombank Vũng Tàu'

--cau 3
select count(*) SoKhachHang
from transactions join account on transactions.ac_no = account.Ac_no
			      join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where (YEAR(t_date) = 2012 and DATEPART(QUARTER, t_date) = 1) and t_type = 0 and BR_name like 'Vietcombank%'

--cau 4
select DATEPART(month, t_date), count(*) SoLuongGiaoDich, sum(t_amount) TongSoTienGiaoDich
from transactions
where YEAR(t_date) = 2014 
group by DATEPART(month, t_date)

--cau 5
select BR_name, sum(t_amount) as TongTienGui
from customer join account on customer.Cust_id= account.cust_id
              join Branch on customer.Br_id= Branch.BR_id
			  join transactions on transactions.ac_no = account.Ac_no
where t_type= 1
group by Branch.BR_ad, Branch.BR_name
order by sum(t_amount) desc

--cau 6
select cust_name, Cust_phone
from customer join Branch on Branch.BR_id = customer.Br_id
              join account on account.cust_id= customer.Cust_id
where Branch.BR_name= N'Vietcombank Bình Dương'
      and account.Ac_no not in(select Ac_no from transactions where year(getdate()) - year(t_date)<= 3)

--cau 7
select count(t_id) as SoLuongGiaoDich, avg(t_amount) as LuongTienGiaoDichTrungBinh, sum(t_amount) as TongTienGiaoDich, 
       max(t_amount) as LuongTienGiaoDichNhieuNhat, min(t_amount) as LuongTienGiaoDichItNhat
from transactions
group by datepart(quarter, t_date)

--cau 8
select cust_name, MAX(t_amount) SoTienGiaoDich
from transactions join account on transactions.ac_no = account.Ac_no
                  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where year(t_date) = 2016 and BR_name like N'%Huế'
group by Cust_name

--cau 9
select Cust_name, sum(t_amount) as SoTienNhieuNhat
from customer join account on customer.cust_id = account.cust_id 
              join  transactions  on account.ac_no = transactions.ac_no
Where t_type =1 and  year(t_date) = 2017
and t_amount = (select top 1 sum(t_amount)
                  from account join customer on customer.Cust_id =account.cust_id
							   join transactions on transactions.ac_no = account.Ac_no
							   where t_type =1 and YEAR(t_date) = 2017
							   group by customer.Cust_id
							   order by sum(t_amount) desc)
group by Cust_name

--Câu 10
select cust_name
from customer join Branch on customer.Br_id= Branch.BR_id 
where Branch.BR_id in(select BR_id from customer where Cust_name= N'Phan Nguyên')

--Câu 11
select t_id, t_time, t_date
from transactions
where datepart(hour, t_time) in (select datepart(hour, t_time) from transactions 
                                        join account on account.Ac_no= transactions.ac_no
                                        join customer on customer.Cust_id= account.cust_id
								        where Cust_name= N'Lê Nguyễn Hoàng Văn' and t_date= '2016-12-02')

--Câu 12
select cust_id, cust_name, Cust_ad
from customer 
where REVERSE(LEFT(reverse(cust_ad), CHARINDEX(',', REVERSE(replace(cust_ad,'-', ',')))-1))
in (select REVERSE(left(reverse(cust_ad), CHARINDEX(',', REVERSE(replace(cust_ad,'-', ',')))-1))
      from customer
where cust_name= N'Trần Văn Thiện Thanh')

--Câu 13
select t_id, t_time, t_date
from transactions
where  t_date in (select t_date from transactions
                  where t_id =  '0000000217')


--Câu 14
select t_id, t_type
from transactions
where t_type in (select t_type from transactions
                 where t_id = '0000000387')

--Câu 15
select Branch.BR_id, count(t_id) as SoGiaoDich
from transactions join account on account.Ac_no= transactions.ac_no
                  join customer on customer.Cust_id= account.cust_id
				  join Branch on Branch.BR_id= customer.Br_id
where t_type= 1 and month(t_date) = 12 and year(t_date)= 2015
group by Branch.BR_id
having count(t_id) > (select count(t_id) from transactions
	                                        join account on account.Ac_no= transactions.ac_no
											join customer on customer.Cust_id= account.cust_id
											join Branch on Branch.BR_id= customer.Br_id
						where Branch.BR_name= N'Vietcombank Đà Nẵng')

--Câu 16
select account.Ac_no
from account  join transactions on transactions.ac_no= account.Ac_no
where account.Ac_no not in(select Ac_no from transactions where month(getdate()) - 6 <= month(t_date))

--Câu 17
select cust_name, branch.br_name, count(t_id) as SoLuongGiaoDich, sum(t_amount) as TongTien
from customer join Branch on Branch.BR_id= customer.Br_id
              join account on account.cust_id= customer.Cust_id
              join transactions on transactions.ac_no= account.Ac_no
where cust_name= N'Phạm Duy Khánh' and t_type= 1
      and t_date between '2017/01/01' and GETDATE()
group by Branch.BR_ad    

--Câu 18
select count(t_id) as SoLuongGiaoDich, avg(t_amount) as LuongTienGiaoDichTrungBinh, year(t_date) as NamGiaoDich
from transactions 
group by  year(t_date)

--Câu 19
select iif(transactions.t_time between '00:00' and '06:00', 'Ban dem', 'Ban ngay') as N'Ngay/Dem', 
       count(*) as 'SoLuongGiaoDich' , transactions.t_id
from transactions join account on account.ac_no = transactions.ac_no
                  join customer on customer.cust_id = account.cust_id
                  join Branch  on customer.Br_id = Branch.Br_id 
where year(t_date) = 2017 and BR_name = N'Vietcombank Sài Gòn' or BR_name = N'Vietcombank Hà Nội'
group by t_time, transactions.t_id

--Câu 20
select customer.Cust_id, cust_name
from customer join account on account.cust_id= customer.Cust_id
              join transactions on transactions.ac_no= account.Ac_no
where account.Ac_no not in(select transactions.ac_no from transactions 
			      where year(t_date)= 2017)
group by customer.Cust_name, customer.Cust_id

--Câu 21
select t_id, t_type, t_amount, t_date
from transactions join account on account.Ac_no= transactions.ac_no
                  join customer on customer.Cust_id= account.cust_id
				  join Branch on Branch.BR_id= customer.Br_id
where month(t_date)< 4 and Branch.BR_id like N'VT%'

--Câu 22 
select cust_name, cust_phone, t_id, t_type, t_amount, t_date
from customer join account on account.cust_id= customer.Cust_id
              join transactions on transactions.ac_no= account.Ac_no
where Cust_phone like '093%' and Cust_phone like '%02'

--Câu 23
select top 2 count(t_id) as SoLuongGiaoDich, Branch.BR_name, Branch.BR_id
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where t_type = 1 and DATEPART(quarter,t_date)=3 and YEAR(t_date) = 2017 
GROUP BY  Branch.BR_id, Branch.BR_name
order by count(t_id) asc

--Câu 24
select top 2 count(t_id) as SoLuongGiaoDich, Branch.BR_name, Branch.BR_id
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where t_type = 1 and YEAR(t_date) = 2017 
GROUP BY  Branch.BR_id, Branch.BR_name
order by count(t_id) desc

--Câu 25
select top 1 t_amount, cust_name, Branch.BR_name
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where t_type = 1 and DATEPART(quarter,t_date)=4
GROUP BY  t_amount, Cust_name, Branch.BR_name
order by t_amount desc

--Câu 26
select Br_name, t_id, t_type, t_time
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where t_type= 1 and t_time between '11:30' and '13:30'

--Câu 27
select t_id, t_time
from transactions
where t_time not between '08:00' and '11:30'               
  and t_time not between '13:30' and '17:30'
   or t_time between '14:01' and '07:00'
--Câu 28
select t_id, t_time, t_date
from transactions
where t_time between '00:00' and '03:00' and year(t_date)= 2017

--Câu 29
select count(customer.Cust_id)
from account join customer on customer.Cust_id= account.cust_id
where cust_ad like N'%ĐĂK LĂK'
having count(account.Ac_no) >1

--Câu 30
select count(t_id)* 3000 as TongTienPhi
from transactions 
where year(t_date) between '2012' and '2017' and t_type = 0

--Câu 31
select customer.Cust_id as 'Ma_KH', 
       (left ((Cust_name), charindex (' ',(Cust_name),0)-1)) as 'Ho',
       reverse(left (reverse(Cust_name), charindex (' ',reverse(Cust_name),0)-1)) as 'Ten',
	   ac_balance as 'SoDuTaiKhoan' 
from customer join account on customer.cust_id = account.cust_id
where left ((Cust_name), charindex (' ',(Cust_name),0)-1) like  N'Trần'

--Câu 32
select customer.Cust_id, Cust_name, sum(t_amount) as 'TongTienRut', ac_balance
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
where t_type = 0  and month(t_date) = 12 and year(t_date) = 2017 and ac_balance < 100000
group by customer.Cust_id, Cust_name, ac_balance
having sum(t_amount) > 100000000

--Câu 33
select account.* from account 
join transactions on account.ac_no = transactions.ac_no
where ac_balance <> (select(select sum(t_amount) from transactions where t_type =1) 
                 - (select sum(t_amount) from transactions where t_type =0))
				 p
--Câu 34
select account.Ac_no, t_id, t_type, t_amount, t_date, t_time, Branch.BR_id, BR_name
from transactions join account on transactions.ac_no = account.Ac_no
				  join customer on account.cust_id = customer.Cust_id
				  join Branch on customer.Br_id = Branch.BR_id
where ac_balance<0 and account.Ac_no in (select ac_no from transactions)

--Câu 35
select distinct customer.Cust_id, customer.Cust_name,  sum(account.ac_balance) as N'Sum_ac_balance', t_type,
       iif (t_type=1, sum(t_amount), sum(t_amount)) as 'TongTienGuiRut'
from customer join account on customer.cust_id = account.cust_id
              join transactions on account.ac_no = transactions.ac_no 
group by customer.Cust_id, customer.Cust_name, transactions.t_type

--Câu 36
select Branch.BR_name, Avg(transactions.t_amount) as 'Avg_t'
from transactions join account on account.ac_no = transactions.ac_no
                  join customer on customer.cust_id = account.cust_id
                  join Branch on  customer.Br_id = Branch.Br_id
where t_time between '13:00' and '17:00' and (t_type)=0
group by Branch.BR_name, DATEPART(day,t_date)
order by avg(transactions.t_amount) desc				   

