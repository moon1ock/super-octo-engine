select p, count(*) from Pub p group by p.p;



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

	