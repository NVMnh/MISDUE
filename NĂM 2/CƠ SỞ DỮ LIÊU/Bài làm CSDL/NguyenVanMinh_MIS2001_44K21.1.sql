Select * from CanHoChoThue
Update CanHoChoThue
set GiaThue= GiaThue*1.2
-----
Select * from CanHoChoThue
Update CanHoChoThue
set GiaThue=GiaThue*0.75
where DienTich > 120
-----
Update CanHoChoThue
set GiaThue = 550
where LoaiCanHo = 'A'
Update CanHoChoThue
set GiaThue = 450	
where LoaiCanHo = 'B'
Update CanHoChoThue
set GiaThue = 350	
where LoaiCanHo = 'C'
-------------------
Select * from KhachThue
Update KhachThue
set NgaySinh = '1980-10-23'
where MaKhach='000001'
-------------------
Select * from HopDongThueCanHo
Update HopDongThueCanHo
set ThoiGianThue = 0, GiaTriHopDong=0, DatTruoc=0, ConLai=0
update HopDongThueCanHo
set ThoiGianThue= IIF(DATEDIFF(MONTH,NgayThue,NgayTra)=0,1,DATEDIFF(MONTH,NgayThue,NgayTra))
update HopDongThueCanHo
set GiaTriHopDong = ThoiGianThue * GiaThue 
From HopDongThueCanHo inner join CanHoChoThue on HopDongThueCanHo.MaCanHo = CanHoChoThue.MaCanHo
-------------------
Update HopDongThueCanHo
Set DatTruoc = iif(ThoiGianThue>12, GiaTriHopDong*0.4, 
iif(ThoiGianThue >= 6 and ThoiGianThue <=12, GiaTriHopDong*0.7, GiaTriHopDong*0.8))
-------------------
Update HopDongThueCanHo
Set ConLai = GiaTriHopDong + GiaTriHopDong*0.1 - DatTruoc


Select * from KhachThue
Select * from CanHoChoThue
Select * from HopDongThueCanHo