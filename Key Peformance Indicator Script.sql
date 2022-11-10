-- Most earnings brought in
Select f.Staff_Key, sum(Item_Unit_Price * Item_quantity) Total_Sale,s.Staff_ID,s.Staff_Name,s.Staff_Surname 
from FactSale as f INNER JOIN DimStaff as s on f.Staff_Key =s.Staff_Key group by f.Staff_Key,Staff_ID,s.Staff_Name,s.Staff_Surname 
order by sum(Item_Unit_Price*Item_Quantity) desc

-- Most customers handled
SELECT a.Staff_Key,b.Staff_ID,b.Staff_Name,Count(a.Customer_Key)Cus_Nums FROM (SELECT Staff_Key,Customer_Key FROM FactSale Group By Staff_Key,Customer_Key)
a Inner Join DimStaff b on a.Staff_Key = b.Staff_Key 
Group by a.Staff_Key,b.Staff_Name,b.Staff_ID 
Order By Cus_Nums DESC


-- Most quantity of items sold
SELECT a.Staff_Key, b.Staff_ID, b.Staff_Name, b.Staff_Surname,
sum(isnull(Item_Quantity, 0)) AS [Total Quantity]
FROM FactSale AS a
LEFT JOIN DimStaff AS b ON a.Staff_Key = b.Staff_Key
GROUP BY a.Staff_Key, b.Staff_ID, b.Staff_Key, b.Staff_Name, b.Staff_Surname
ORDER BY sum (Item_Quantity) DESC

-- Most transactions handled
SELECT a.Staff_Key,b.Staff_ID,b.Staff_Name,b.Staff_Surname,
Count(a.Receipt_ID)Most_Trans FROM (SELECT Staff_Key,Receipt_ID FROM FactSale GROUP BY Staff_Key,Receipt_ID)a 
INNER JOIN DimStaff b on a.Staff_Key = b.Staff_Key
GROUP BY a.Staff_Key, b.Staff_Name,b.Staff_Surname, b.Staff_ID
ORDER BY Most_Trans DESC