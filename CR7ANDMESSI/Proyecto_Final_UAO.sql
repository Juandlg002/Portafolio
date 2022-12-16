Use PROYECTO1
select * 
from MESSI

---RONALDO STATS---
Select  * 
from MESSI
where Matchday is NULL

alter table messi
add Goal_id bigint identity(1,1)

alter table ROnaldo
add Goal_id bigint identity(1,1)

select *
from RONALDO
where Type like 'Penalty %'

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 5

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 30

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 33

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 35

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 37

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 38

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 39

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 40

update RONALDO
set Type = 'Header'
where TYPE = ''
and Goal_id = 41

update RONALDO
set Type = 'Right-footed shot'
where TYPE = 'Penalty rebound'
and Goal_id = 42

update RONALDO
set Type = 'Right-footed shot'
where TYPE = ''
and Goal_id = 43

update RONALDO
set Type = 'Left-footed shot'
where TYPE = ''
and Goal_id = 57

update RONALDO
set Type = 'Left-footed shot'
where TYPE = ''
and Goal_id = 62

update RONALDO
set Goal_assist = 'Solo'
where Goal_assist = ''

update RONALDO
set Type = 'Right-footed shot'
where  Goal_id = 674

---MESSI STATS---
Select  * 
from MESSI
Where type is NULL or Type = ''

alter table messi
add Goal_id bigint identity (1,1)

update Messi
set type = 'Hand'
where Goal_id = 23
   
Update MESSI
set Type = 'Left-footed shot'
where goal_id =53

Update MESSI
set Type = 'Right-footed shot'
where goal_id =351

Update MESSI
set Type = 'Left-footed shot'
where goal_id =383

Update messi	
set Goal_assist = 'Solo'
where Goal_assist is Null

SELECT *
FROM MESSI