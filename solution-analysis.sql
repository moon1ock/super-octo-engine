select * from Field a, Field b where a.p = 'author' and b.k = 'booktitle' and a.k = b.k and b.v = 'SIGMOD conference' limit 10;



-- QUERY 1

insert into tmppub (id, num) select id, count(*) as cnt from authored group by id order by cnt desc limit 120;

create table answer (name text, cnt numeric);

insert into answer (name, cnt) select name, num from tmppub left outer join authors on tmppub.id = authors.id;

select distinct name,cnt from answer order by cnt desc limit 20;
drop tmppub, answer;
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




 -- QUERY 5




