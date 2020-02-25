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

-- here it is apparent that STOC is a booktitle in inproceedings; so have to only iterate over those
-- time to use the tpbk table that we kept from the database formation


-- join tpbk and authored to get the ids

create table stocref (pubkey text);

insert into stocref (pubkey) select pubkey from tpbk where tpbk.booktitle = 'STOC';

create table answer (id numeric, name text, cnt numeric);

insert into answer ( name, id , cnt) select distinct authors.name, authors.id, count(authored.id) from authored, authors where authored.id = authors.id and authored.pubid in (select publications.pubid from publications, stocref where stocref.pubkey = publications.pubkey) group by authors.name, authors.id order by count(authored.id) desc;

create table asw (name text, cnt numeric);
insert into asw (name, cnt) select distinct name, cnt from answer order by cnt desc limit 20;
/*
select * from asw;
           name            | cnt
---------------------------+-----
 Avi Wigderson             |  58
 Robert Endre Tarjan       |  33
 Ran Raz                   |  30
 Noam Nisan                |  28
 Moni Naor                 |  28
 Uriel Feige               |  28
 Rafail Ostrovsky          |  27
 Mihalis Yannakakis        |  25
 Santosh S. Vempala        |  25
 Frank Thomson Leighton    |  25
 Oded Goldreich 0001       |  25
 Venkatesan Guruswami      |  24
 Christos H. Papadimitriou |  24
 Prabhakar Raghavan        |  24
 Moses Charikar            |  23
 Mikkel Thorup             |  21
 Madhu Sudan               |  21
 Sanjeev Khanna            |  21
 Baruch Awerbuch           |  21
 Eyal Kushilevitz          |  21
(20 rows)

 */
drop table answer, asw;
truncate table stocref;

insert into stocref (pubkey) select pubkey from tpbk where tpbk.booktitle = 'VLDB';

create table answer (id numeric, name text, cnt numeric);

insert into answer ( name, id , cnt) select distinct authors.name, authors.id, count(authored.id) from authored, authors where authored.id = authors.id and authored.pubid in (select publications.pubid from publications, stocref where stocref.pubkey = publications.pubkey) group by authors.name, authors.id order by count(authored.id) desc;

create table asw (name text, cnt numeric);
insert into asw (name, cnt) select distinct name, cnt from answer order by cnt desc limit 20;

/*select * from asw;
         name          | cnt
-----------------------+-----
 H. V. Jagadish        |  35
 Raghu Ramakrishnan    |  30
 David J. DeWitt       |  29
 Rakesh Agrawal 0001   |  27
 Hector Garcia-Molina  |  27
 Jeffrey F. Naughton   |  26
 Michael J. Carey 0001 |  26
 Surajit Chaudhuri     |  26
 Gerhard Weikum        |  25
 Christos Faloutsos    |  25
 Michael Stonebraker   |  24
 Divesh Srivastava     |  23
 Nick Koudas           |  22
 Michael J. Franklin   |  21
 Philip S. Yu          |  21
 Jiawei Han 0001       |  21
 Abraham Silberschatz  |  21
 Jennifer Widom        |  20
 Philip A. Bernstein   |  20
 Umeshwar Dayal        |  20
(20 rows)*/




drop table answer, asw;
truncate table stocref;

insert into stocref (pubkey) select pubkey from tpbk where tpbk.booktitle = 'SIGGRAPH';

create table answer (id numeric, name text, cnt numeric);

insert into answer ( name, id , cnt) select distinct authors.name, authors.id, count(authored.id) from authored, authors where authored.id = authors.id and authored.pubid in (select publications.pubid from publications, stocref where stocref.pubkey = publications.pubkey) group by authors.name, authors.id order by count(authored.id) desc;

create table asw (name text, cnt numeric);
insert into asw (name, cnt) select distinct name, cnt from answer order by cnt desc limit 20;

/*select * from asw;
        name         | cnt
---------------------+-----
 Donald P. Greenberg |  40
 Pat Hanrahan        |  32
 David Salesin       |  30
 Henry Fuchs         |  17
 Marc Levoy          |  17
 John F. Hughes      |  15
 Hugues Hoppe        |  15
 Andrew P. Witkin    |  14
 Demetri Terzopoulos |  12
 Norman I. Badler    |  12
 Andries van Dam     |  12
 Tomoyuki Nishita    |  11
 James H. Clark 0001 |  10
 James F. Blinn      |  10
 Eugene Fiume        |  10
 Adam Finkelstein    |  10
 Nelson L. Max       |  10
 Steven J. Gortler   |  10
 Hans-Peter Seidel   |   9
 Greg Turk           |   9
(20 rows)
*/


 -- Query 4
 select floor(year/10)*10 as dec, count(pubid) from publication group by dec;

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



-- Query 5
 create table colab (id numeric, cnt numeric);

insert into colab (id, cnt) select i.id, count(distinct c.id) from authored i, authored c where i.id != c.id and i.pubid = c.pubid group by i.id;

create table topcolabs (name text, cnt numeric);
insert into topcolabs (name, cnt) select distinct authors.name, colab.cnt from authors left join colab on authors.id=colab.id where authors.name is not NULL and colab.cnt is not null order by colab.cnt desc;
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
