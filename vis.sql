drop table if exists tmppub;
create table tmppub (id numeric, num numeric);
insert into tmppub (id, num) select id, count(*) as cnt from authored group by id order by cnt desc;

drop table if exists answer;
create table answer (name text, cnt numeric);
insert into answer (name, cnt) select name, num from tmppub left outer join authors on tmppub.id = authors.id;

\copy (select distinct name,cnt from answer order by cnt desc) To '/Users/mikolajdebicki/Desktop/super-octo-engine/pub.csv' With CSV
drop table tmppub, answer;

-- Both plots decay exponentially