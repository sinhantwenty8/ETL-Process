USE [EBUS3030_Assignment_1]
GO
 
INSERT INTO DimTime
(Date_ID, Date_Month, Date_Quarter, Date_Year)
SELECT distinct Cast(Assignment1Data.[Sale_Date] AS date), Datepart(month, Assignment1Data.[Sale_Date]), Datepart(quarter, Assignment1Data.[Sale_Date]), Datepart(year, Assignment1Data.[Sale_Date])
FROM Assignment1Data ORDER BY Cast(Assignment1Data.[Sale_Date] AS date)

Insert into DimCustomer
(Customer_ID, Customer_Name, Customer_Surname,Customer_Loyalty)
SELECT distinct Assignment1Data.[Customer_ID], Assignment1Data.[Customer_Name], Assignment1Data.[Customer_Surname],Assignment1Data.[Customer_Loyalty]
From Assignment1Data

Insert into DimLocation
(Location_ID, Location_Name)
SELECT distinct Assignment1Data.[Staff_Office_ID], Assignment1Data.[Staff_Office_Location_Name] From Assignment1Data

Insert into DimStaff
(Staff_ID, Staff_Name, Staff_Surname,Staff_Office_Key)
SELECT distinct Assignment1Data.[Staff_ID],Assignment1Data.[Staff_Name],Assignment1Data.[Staff_Surname],
(SELECT DimLocation.[Location_Key] FROM DimLocation INNER JOIN Assignment1Data 
ON Assignment1Data.[Staff_Office_ID] = DimLocation.[Location_ID] GROUP BY  DimLocation.[Location_Key])
FROM Assignment1Data


Insert into DimItem (Item_ID, Item_Description,Item_Unit_Price)
(select distinct Cast(Assignment1Data.[item_ID]as int), Assignment1Data.[Item_Description] ,
Assignment1Data.[Item_Unit_Price]
from Assignment1Data) ORDER BY Cast(Assignment1Data.[Item_ID] As int)

 
Insert into FactSale
( Receipt_ID,Sale_Date_Key,Customer_Key,Staff_Key,Trans_Row_ID,Item_Key,Item_Unit_Price,
Item_Quantity,Trans_Row_Total,Receipt_Total_Sale_Amount,Discount_Given)
SELECT  x.[Receipt_Unique_Id ], d.Date_Key, c.Customer_Key, s.Staff_Key, x.Trans_Row_ID,
i.Item_Key, i.Item_Unit_Price, x.Item_Quantity,x.Trans_Row_Total,z.TotalSale,y.Discount_Given
FROM
Assignment1Data x
inner join DimStaff s
    on s.Staff_ID = x.[Staff_Id]
inner Join DimLocation a
    on x.[Staff_Office_ID] = a.Location_ID
inner join DimCustomer c
    on x.[Customer_ID] = c.Customer_ID
inner join DimTime d
    on x.[Sale_Date] = d.Date_ID
inner join DimItem i
    on x.item_id = i.Item_ID
 inner join (SELECT Receipt_Unique_ID,IIF(count(Receipt_Unique_ID) > 5 , 1,0) as Discount_Given from Assignment1Data Group By Receipt_Unique_ID ) y
    on x.Receipt_Unique_ID = y.Receipt_Unique_ID
 inner join (SELECT Receipt_Unique_ID,SUM(Trans_Row_Total)as TotalSale FROM Assignment1Data GROUP BY Receipt_Unique_ID) z
    on x.Receipt_Unique_Id = z.Receipt_Unique_ID
ORDER BY x.[Receipt_Unique_Id ]
Go
