Select *from CanHoChoThue
where LoaiCanHo = 'A'
-------
Select TenKhach, GioiTinh, Ngaysinh 
from KhachThue 
where MaKhach = 'KH001'
-------
Select *from CanHoChoThue
where (LoaiCanHo='A' or LoaiCanHo='B') and SoPhongNgu=2
--------------
Select *from HopDongThueCanHo
where (month(NgayThue)= 10 or month(NgayThue)= 11 or month(NgayThue)=12) and year(NgayThue)=2019
--------------
Select KhachThue.*from HopDongThueCanHo inner join KhachThue on HopDongThueCanHo.MaKhach=KhachThue.MaKhach
where SoHopDong='HD0011'
--------------
Select *from HopDongThueCanHo
Where (MONTH(NgayThue) = 1 or month(NgayThue)= 2 or month(NgayThue)=3) and year(NgayThue)=2019
order by ThoiGianThue DESC 
--------------
Select LoaiCanHo, count(*) as SoCanHo
from CanHoChoThue
group by LoaiCanHo
--------------
Select top 2 *from CanHoChoThue
order by GiaThue asc
--------------
Select TenKhach, GioiTinh, LoaiCanHo, GiaThue, NgayThue, ThoiGianThue, GiaTriHopDong
from HopDongThueCanHo inner join KhachThue on HopDongThueCanHo.MaKhach=KhachThue.MaKhach 
inner join CanHoChoThue on HopDongThueCanHo.MaCanHo=CanHoChoThue.MaCanHo
where MONTH(NgayThue) = 10 and year(NgayThue) = 2019
--------------
Select *from HopDongThueCanHo
where MONTH(NgayTra) = 3 and year(NgayTra) = 2020
order by NgayTra asc
--------------