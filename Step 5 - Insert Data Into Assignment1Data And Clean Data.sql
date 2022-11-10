USE [EBUS3030_Assignment_1]
GO


INSERT INTO Assignment1Data SELECT * FROM Assignment1RawData

--  Identify any Data Anomalies 
--  1 ) Staffs with same id
SELECT Staff_ID, Count(a.Staff_ID) as Duplicate_IDs FROM (SELECT  Staff_ID,Staff_Surname,Staff_name FROM Assignment1Data
Group by Staff_ID,Staff_Surname,Staff_name) a Group by a.Staff_ID Having Count(a.Staff_ID) > 1

--  2 ) Multiple transactions having the same receipt id (Multiple customers in one transaction)
SELECT a.Receipt_Unique_Id,Count(a.Customer_Id) as Multiple_Cus FROM (SELECT Receipt_Unique_Id,Customer_Id From Assignment1Data Group By Receipt_Unique_Id,Customer_Id) a
Group By a.Receipt_Unique_Id Having Count(a.Customer_Id) > 1

--  3 ) Multiple staff within one transaction
SELECT a.Receipt_Unique_Id,Count(a.Staff_Id) as Multiple_staff FROM (SELECT Receipt_Unique_Id,Staff_Id From Assignment1Data Group By Receipt_Unique_Id,Staff_Id) a
Group By a.Receipt_Unique_Id Having Count(a.Staff_Id) > 1

SELECT t.Receipt_Unique_Id,Staff_Name,Staff_Surname FROM (SELECT a.Receipt_Unique_Id,Count(a.Staff_Id) as Multiple_staff FROM
(SELECT Receipt_Unique_Id,Staff_Id From Assignment1Data Group By Receipt_Unique_Id,Staff_Id) a
Group By a.Receipt_Unique_Id Having Count(a.Staff_Id) > 1)t
INNER JOIN Assignment1Data s on t.Receipt_Unique_Id = s.Receipt_Unique_Id
GROUP By t.Receipt_Unique_id,Staff_Name,Staff_Surname

-- Evidence of Scripts To Clean Data
-- 1 ) Add Leading Zeros to uneven values of Customer ID (UPDATE C1 to C001)in Assignment1Data
UPDATE Assignment1Data SET Assignment1Data.Customer_ID = STUFF(Assignment1Data.Customer_ID, 2, 0, REPLICATE('0',4-LEN(Assignment1Data.Customer_ID)))
 
UPDATE Assignment1Data SET Assignment1Data.Staff_ID = STUFF(Assignment1Data.Staff_ID, 2, 0, REPLICATE('0',4-LEN(Assignment1Data.Staff_ID)))

--  2 ) Add two decimal to unit price in Assignment1Data
Alter table Assignment1Data
alter column Item_Unit_Price Decimal (5,2)
 
UPDATE [dbo].[Assignment1Data]
SET [Trans_Row_Total] = CAST([Trans_Row_Total] as decimal(10, 2))
WHERE [Trans_Row_Total] - FLOOR([Trans_Row_total]) < 0.01;
ALTER TABLE [dbo].[Assignment1Data] ALTER COLUMN [Trans_Row_Total] DECIMAL(10,2);


-- 3 ) Staffs with same id
UPDATE Assignment1Data SET [Staff_Id] = 'S015A' WHERE Staff_Name = 'Molly'

-- 4 ) Multiple transactions having the same receipt id (Multiple customers in one transaction)
UPDATE Assignment1Data SET [Receipt_Unique_ID] = '21009A' WHERE Customer_Id = 'C011' and    
  Receipt_Unique_ID = '21009'
  UPDATE Assignment1Data SET [Receipt_Unique_ID] = '21719A' WHERE Customer_Id = 'C011' and   
  Receipt_Unique_ID = '21719'
  UPDATE Assignment1Data SET [Receipt_Unique_ID] = '22761A' WHERE Customer_Id = 'C012' and 
  Receipt_Unique_ID = '22761'
  UPDATE Assignment1Data SET [Receipt_Unique_ID] = '22912A' WHERE Customer_Id = 'C006' and   
  Receipt_Unique_ID = '22912'
