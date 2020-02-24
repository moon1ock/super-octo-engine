
select p, count(*) from Pub p group by p.p;

/*
       p       |  count
---------------+---------
 article       | 2203997
 book          |   17760
 incollection  |   60493
 inproceedings | 2553803
 mastersthesis |      12
 phdthesis     |   75524
 proceedings   |   43392
 www           | 2451080
(8 rows) */



select f from (select distinct Field.p as f, Pub.p as p from field inner join pub on Field.k=Pub.k) as Groups group by f having count(f)=8;
/*   f
--------
 author
 ee
 note
 title
 year
(5 rows)*/

create index idx_pub on Pub (k);
create index idx_field on Field (k);

	