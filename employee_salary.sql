Select e.name ,b.bonus  
From Employee e Left join  Bonus b
    on e.empId = b.empId
where b.bonus < 1000
    or b.bonus is null;    
