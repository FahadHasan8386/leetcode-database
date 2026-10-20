
Select c.name as Customers from Customers c
Left join Orders o
ON o.customerId = c.id 
where o.customerId is null;