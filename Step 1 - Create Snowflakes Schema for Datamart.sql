 USE MASTER
GO
IF DB_ID (N'EBUS3030_Assignment_1') IS NOT NULL DROP DATABASE EBUS3030_Assignment_1;
GO
CREATE DATABASE EBUS3030_Assignment_1;
GO
Use EBUS3030_Assignment_1;
GO
 
DROP TABLE IF EXISTS FactSales;
DROP TABLE IF EXISTS DimCustomer;
DROP TABLE IF EXISTS DimStaff;
DROP TABLE IF EXISTS DimDate;
DROP TABLE IF EXISTS DimItem;     
GO
CREATE TABLE DimCustomer (
 Customer_Key int identity not null,                
 Customer_ID nvarchar(255) not null,               
 Customer_Name nvarchar(30) not null,
 Customer_Surname nvarchar(30) not null,                
Customer_Loyalty bit not null,
Primary Key (Customer_Key)
)
CREATE TABLE DimItem (               
 Item_Key int identity not null,               
 Item_ID nvarchar(255) not  null,                   
 Item_Description nvarchar(35) not null,
 Item_Unit_Price float not null,
Primary Key (Item_Key)
)
CREATE TABLE DimTime (
 Date_Key int identity not null,
 Date_ID date not null,                         
 Date_Month int not null,                  
 Date_Quarter int not null,
 Date_Year int not null,
Primary Key (Date_Key)
)
CREATE TABLE DimLocation (
 Location_Key int identity not null,       
 Location_ID nvarchar(255) not  null,
 Location_Name nvarchar(20)not null,
Primary Key (Location_Key)              
)
CREATE TABLE DimStaff (
 Staff_Key int identity not null,               
 Staff_ID nvarchar(255) not null,                       
 Staff_Name nvarchar(30) not null,            
 Staff_Surname nvarchar(30) not null,
 Staff_Office_Key int not  null,
 Primary Key (Staff_Key),
 FOREIGN KEY (Staff_Office_Key) REFERENCES DimLocation (Location_Key)
 )
CREATE TABLE FactSale (
 Sale_Key int identity not null,                       
 Receipt_ID nvarchar(255) not null,        
 Sale_Date_Key int not null,                       
 Customer_Key int not null,
 Staff_Key int not null,
 Trans_Row_ID int not null,
 Item_Key Int not null,
 Item_Unit_Price float not null,
 Item_Quantity int not null,
 Trans_Row_Total float not null,
 Receipt_Total_Sale_Amount float not null,
 Discount_Given bit not null,
FOREIGN KEY (Item_Key) REFERENCES DimItem (Item_Key),
FOREIGN KEY (Sale_Date_Key)  REFERENCES DimTime (Date_Key),
FOREIGN KEY (Customer_Key) REFERENCES DimCustomer (Customer_Key),
FOREIGN KEY (Staff_Key) REFERENCES DimStaff (Staff_Key)
)                       
GO
 
 
