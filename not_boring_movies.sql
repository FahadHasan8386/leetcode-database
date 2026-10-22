Select id , movie , description ,rating
From Cinema
where id % 2 != 0
and description <> 'boring'
order By rating DESC;