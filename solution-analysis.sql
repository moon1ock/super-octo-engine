-- QUERY 1
drop table if exists tmppub;
create table tmppub (id numeric, num numeric);
insert into tmppub (id, num) select id, count(*) as cnt from authored group by id order by cnt desc limit 120;

drop table if exists answer;
create table answer (name text, cnt numeric);
insert into answer (name, cnt) select name, num from tmppub left outer join authors on tmppub.id = authors.id;

select distinct name,cnt from answer order by cnt desc limit 20;
drop table tmppub, answer;
/*
         name          | cnt
-----------------------+------
 H. Vincent Poor       | 1844
 Mohamed-Slim Alouini  | 1459
 Philip S. Yu          | 1379
 Lajos Hanzo           | 1268
 Wen Gao 0001          | 1214
 Victor C. M. Leung    | 1167
 Hai Jin 0001          | 1118
 Witold Pedrycz        | 1072
 Thomas S. Huang       | 1045
 Zhu Han               | 1029
 Luca Benini           | 1012
 Dacheng Tao           | 1009
 Elisa Bertino         |  985
 Jiawei Han 0001       |  974
 Leonard Barolli       |  973
 Chin-Chen Chang 0001  |  931
 Georgios B. Giannakis |  918
 Nassir Navab          |  918
 Luc Van Gool          |  904
 Licheng Jiao          |  902
(20 rows)*/


-- Query 2
select ad.aid as authorId, a.name as topAuthorsSTOC, count(ad.aid) as numberofpubs from authored ad, author a where ad.id = a.id and ad.pubid in (select inp.pubid from inproceedings inp where booktitle = "STOC") group by ad.aid, a.name order by count(ad.aid) desc limit 20;


<<<<<<< HEAD

 -- Query 4
 select floor(year/10)*10 as dec, count(pubid) from publication group by dec;
=======
-- Query 4
select floor(year/10)*10 as dec, count(pubid) from publication group by dec;
>>>>>>> 40eb914251627841d08eb4b21eccf8723f01cad4

 /*
 dec  |  count
------+---------
 1910 |       1
 1930 |      56
 1940 |     192
 1950 |    1844
 1960 |   11988
 1970 |   41501
 1980 |  128790
 1990 |  443871
 2000 | 1404089
 2010 | 2891712
 2020 |   30949
(11 rows)
 */

<<<<<<< HEAD


-- query 5
 create table colab (id numeric, cnt numeric);

insert into colab (id, cnt) select i.id, count(distinct c.id) from authored i, authored c where i.id != c.id and i.pubid = c.pubid group by i.id;

create table topcolabs (name text, cnt numeric);
insert into topcolabs (name, cnt) select distinct kauthors.name, colab.cnt from authors left join colab on authors.id=colab.id where authors.name is not NULL and colab.cnt is not null order by colab.cnt desc;
/*
select * from topcolabs limit 20;
name            | cnt
---------------------------+------
 Noga Alon                 | 1223
 Athanasios V. Vasilakos   | 1085
 Schahram Dustdar          | 1025
 Carole A. Goble           |  978
 Leonidas J. Guibas        |  939
 Gerhard Weikum            |  881
 H. Vincent Poor           |  873
 Christos Faloutsos        |  870
 Christos H. Papadimitriou |  858
 Steffen Staab             |  835
 Richard M. Karp           |  817
 Moshe Y. Vardi            |  806
 Ian T. Foster             |  796
 Samuel Madden             |  772
 Erik D. Demaine           |  764
 Michael J. Franklin       |  763
 Yolanda Gil               |  751
 Stefano Ceri              |  740
 Elisa Bertino             |  733
 Michael I. Jordan         |  731
(20 rows)
 */
=======
-- QUERY 5
>>>>>>> 40eb914251627841d08eb4b21eccf8723f01cad4
