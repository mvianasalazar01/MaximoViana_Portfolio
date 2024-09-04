#Data cleaning
use income;

select *
from ushouseholdincome;

#looking for duplicates 
SELECT row_id, id,
row_number() over(partition by(id)) as count
from ushouseholdincome;

#subquery to identify the duplicates by the number of the row id
select row_id
from 
(
SELECT row_id, id,
row_number() over(partition by(id)) as count
from ushouseholdincome
) as duplicate
where count > 1;

#returning the row_id number of the duplicates and then deleting it 

delete from ushouseholdincome 
where row_id in (
	select row_id
		from 
		(
			SELECT row_id, id,
			row_number() over(partition by(id)) as count
			from ushouseholdincome
		) as duplicate
where count > 1);

#looking for mispelling across the state name category

select state_name, count(state_name)
from ushouseholdincome
group by (state_name)
;

UPDATE ushouseholdincome
set state_name = 'Georgia'
where state_name = 'georia'
;



