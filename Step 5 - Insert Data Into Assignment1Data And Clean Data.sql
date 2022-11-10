USE [EBUS3030_Assignment_1]
GO

INSERT INTO Assignment1Data SELECT * FROM Assignment1RawData

UPDATE Assignment1Data SET Assignment1Data.Customer_ID = STUFF(Assignment1Data.Customer_ID, 2, 0, REPLICATE('0',4-LEN(Assignment1Data.Customer_ID)))
 
UPDATE Assignment1Data SET Assignment1Data.Staff_ID = STUFF(Assignment1Data.Staff_ID, 2, 0, REPLICATE('0',4-LEN(Assignment1Data.Staff_ID)))

Alter table Assignment1Data
alter column Item_Unit_Price Decimal (5,2)
 
UPDATE [dbo].[Assignment1Data]
SET [Trans_Row_Total] = CAST([Trans_Row_Total] as decimal(10, 2))
WHERE [Trans_Row_Total] - FLOOR([Trans_Row_total]) < 0.01;
ALTER TABLE [dbo].[Assignment1Data] ALTER COLUMN [Trans_Row_Total] DECIMAL(10,2);

UPDATE Assignment1Data SET [Staff_Id] = 'S015A' WHERE Staff_Name = 'Molly'

UPDATE Assignment1Data SET [Receipt_Unique_ID] = '21009A' WHERE Customer_Id = 'C011' and    
  Receipt_Unique_ID = '21009'
  UPDATE Assignment1Data SET [Receipt_Unique_ID] = '21719A' WHERE Customer_Id = 'C011' and   
  Receipt_Unique_ID = '21719'
  UPDATE Assignment1Data SET [Receipt_Unique_ID] = '22761A' WHERE Customer_Id = 'C012' and 
  Receipt_Unique_ID = '22761'
  UPDATE Assignment1Data SET [Receipt_Unique_ID] = '22912A' WHERE Customer_Id = 'C006' and   
  Receipt_Unique_ID = '22912'
