drop table if exists tmppub;
create table tmppub (id numeric, num numeric);
insert into tmppub (id, num) select id, count(*) as cnt from authored group by id order by cnt desc;

drop table if exists answer;
create table answer (name text, cnt numeric);
insert into answer (name, cnt) select name, num from tmppub left outer join authors on tmppub.id = authors.id;

\copy (select distinct name,cnt from answer order by cnt desc) To '/Users/mikolajdebicki/Desktop/super-octo-engine/pub.csv' With CSV
drop table tmppub, answer;



create table colab (id numeric, cnt numeric);
insert into colab (id, cnt) select i.id, count(distinct c.id) from authored i, authored c where i.id != c.id and i.pubid = c.pubid group by i.id;

create table topcolabs (name text, cnt numeric);
insert into topcolabs (name, cnt) select distinct authors.name, colab.cnt from authors left join colab on authors.id=colab.id where authors.name is not NULL and colab.cnt is not null order by colab.cnt desc;

\copy (select * from topcolabs) To '/Users/mikolajdebicki/Desktop/super-octo-engine/col.csv' With CSV
drop table colab, topcolabs;

-- Both plots decay exponentially