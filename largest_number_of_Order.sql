SELECT customer_number 
From Orders 
Group By Customer_number
Order by Count(*) DESC
Limit 1;
