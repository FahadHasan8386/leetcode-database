Select Max(num) As num
from(
    Select num from MyNumbers
    Group BY num 
    Having count(num) = 1
) as t;
