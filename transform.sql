insert into author values ((select v from Field where p = 'author') as "name", (select z.v from Pub x, Field y, Field z where x.k=y.k and y.k=z.k and x.p='www' and y.v= name and z.p = 'url') as "homepage");






insert into author (name, homepage)
select 
