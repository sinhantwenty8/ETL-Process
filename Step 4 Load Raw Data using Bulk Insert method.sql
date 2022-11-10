Set dateformat dmy;
GO
 
USE [EBUS3030_Assignment_1]
GO
 
BULK INSERT ASSIGNMENT1RAWDATA
 
FROM '/AssignmentOne2022RealData.csv'
WITH
(
   FIRSTROW = 2,
   FIELDTERMINATOR = ',', 
   ROWTERMINATOR = '\n',   
   TABLOCK
)
 
Go
