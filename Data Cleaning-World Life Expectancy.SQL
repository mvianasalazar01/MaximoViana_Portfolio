use worldlife;

#creating a new name to asign a unique ID
SELECT row_id,CONCAT(country, '.', year) AS user
FROM worldlifeexpectancy2
;

alter table worldlifeexpectancy2
add column user varchar(60) after year
;

update worldlifeexpectancy2
set user = CONCAT(country, '.', year)
;

select*
from worldlifeexpectancy2;

#looking for duplicates based on the row ID 
delete from worldlifeexpectancy2
where row_id in (select row_id
from
	(
	select row_id, 
	row_number() over(partition by (user) order by user) as count
	from worldlifeexpectancy2
	) as papa
where count > 1)
;


#codigo que cuenta los row number para que darles un id
select user, 
row_number() over()
from worldlifeexpectancy2
group by user;

#codigo que da la posicion exacta de las casillas vacias en funcion del row_id
select row_id, country
from worldlifeexpectancy2
where status = '';

select status
from worldlifeexpectancy2
where row_id in (select row_id
from worldlifeexpectancy2
where status  = '');

select country, status
from worldlifeexpectancy2
where row_id in (select row_id
				from worldlifeexpectancy2
				where status = '')
;

UPDATE worldlifeexpectancy2 t1
 JOIN worldlifeexpectancy2 t2
	on t1.country = t2.country
    set t1.status = 'Developing'
    WHERE t1.status = ''
    and t2.status = 'Developing'
    and t2.status <> ''
    ;
    
UPDATE worldlifeexpectancy2 t1
 JOIN worldlifeexpectancy2 t2
	on t1.country = t2.country
    set t1.status = 'Developed'
    WHERE t1.status = ''
    and t2.status = 'Developed'
    and t2.status <> ''
    ;

select*
from worldlifeexpectancy2;

select t1.country , t1.year, t1.`life expectancy`,
t2.country , t2.year ,t2.`life expectancy`,
t3.country , t3.year ,t3.`life expectancy`
from worldlifeexpectancy2 t1
	join worldlifeexpectancy2 t2
		on t1.country = t2.country
        and t1.year = t2.year +1
	join worldlifeexpectancy2 t3
		on t1.country = t3.country
        and t1.year = t3.year -1
;

 update worldlifeexpectancy2 t1
 join worldlifeexpectancy2 t2
		on t1.country = t2.country
        and t1.year = t2.year +1
	join worldlifeexpectancy2 t3
		on t1.country = t3.country
        and t1.year = t3.year -1
	set t1.`life expectancy` = round((t2.`life expectancy`+t3.`life expectancy`)/2)
		where t1.`life expectancy` = ''
        ;
