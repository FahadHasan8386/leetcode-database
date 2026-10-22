Select s.name from SalesPerson s
    where s.sales_id NOT IN(
        Select o.sales_id
        from Orders o
        join Company c On o.com_id = c.com_id
        where c.name = 'RED'
    );
    