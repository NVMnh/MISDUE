select * from CUST0MSERS$
select * from ORDERS$
select * from PRODUCTS$
--------------Q1
select  Region, ProductID, Sum(Sales) as Sum_Sales
from ORDERS$
GROUP BY Region, ProductID
ORDER BY Region, Sum_Sales DESC 
------------Q2
select Product, Count(*) as Number_of_Sales, Sum(Units) as Sum_Units, Sum(COGS) as Sum_COGS,
Sum(Sales) as Sum_Sales, Sum(Sales - COGS) as Sum_Profit
from ORDERS$ inner join PRODUCTS$ on ORDERS$.ProductID = PRODUCTS$.ProductID
GROUP BY Product
------------Q3
select top 3 ProductID,Product, Description, Supplier, [Suggested Price], Price,
[Suggested Price] - Price as PriceDifference from PRODUCTS$
ORDER BY PriceDifference DESC 
------------Q4
select * from CUST0MSERS$
where Fname like 'M%'
------------Q5
select * from PRODUCTS$
where ProductID <> all(select ProductID from ORDERS$ where MONTH(OrderDate) = 1 and year(OrderDate) = 2011)
ORDER BY ProductID
------------Q6
select * from PRODUCTS$
where ProductID = any(select ProductID from ORDERS$ where MONTH(OrderDate) = 1 and year(OrderDate) = 2011)
ORDER BY ProductID
------------Q7
select Product, Sum(Units) as Sum_Units_Q1_2011 
from PRODUCTS$ inner join ORDERS$ on PRODUCTS$.ProductID = ORDERS$.ProductID
Group by Product
------------Q8
Select Product, Sum(Sales) As 'Sum_Sales_Month34_2011',Sum(COGS) As 'Sum_COGS_Month34_2011'
FROM ORDERS$
Inner Join PRODUCTS$
ON ORDERS$.ProductID = PRODUCTS$.ProductID
where (Month(OrderDate) between 3 and 4) and Year(OrderDate) = 2011
Group by Product
ORDER BY Sum(Sales) DESC
------------Q9
Select Supplier , Count(*) As Count_Item_Supply
From PRODUCTS$
Group By Supplier
Union
Select '3', Count(*) From PRODUCTS$
ORDER BY Count(*) ASC 
------------Q10
select Product, DATEPART(QUARTER,ORDERS$.OrderDate) as By_QUARTER ,
 Sum(Units) as Sum_Units_by_Quarter
 from ORDERS$ inner join PRODUCTS$ on ORDERS$.ProductID=PRODUCTS$.ProductID
 Group By Product, DATEPART(QUARTER,ORDERS$.OrderDate) 
 ORDER BY By_QUARTER
 






 
