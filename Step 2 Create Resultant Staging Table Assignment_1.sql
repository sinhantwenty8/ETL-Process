USE [EBUS3030_Assignment_1]
GO
 
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
DROP TABLE IF EXISTS Assignment1Data;
 
CREATE TABLE [dbo].[Assignment1Data](
   [Sale_Date] [datetime] NULL,
   [Customer_Loyalty][bit] NULL,
   [Receipt_Unique_Id ] [nvarchar](255) NULL,
   [Customer_ID] [nvarchar](255) NULL,
   [Customer_Name] [nvarchar](255) NULL,
   [Customer_Surname] [nvarchar](255) NULL,
   [Staff_Id] [nvarchar](255) NULL,
   [Staff_Name] [nvarchar](255) NULL,
   [Staff_Surname] [nvarchar](255) NULL,
[Staff_Office_ID] [nvarchar](255) NULL,
[Staff_Office_Location_Name] [nvarchar] (255) NULL,
[Trans_Row_ID] [int] NULL,
   [Item_ID] [nvarchar](255) NULL,
   [Item_Description] [nvarchar](255) NULL,
[Item_Quantity] [int] NULL,
   [Item_Unit_Price] [float] NULL,
   [Trans_Row_Total] [float]NULL
 
) ON [PRIMARY]
GO
 

 
 
