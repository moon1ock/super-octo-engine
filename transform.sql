insert into author (select y.v, z.v from Pub x, Field y, Field z where y.p = 'author' and x.k=y.k and y.k=z.k and x.p='www' and y.v= name and z.p = 'url');






select v from Field where p = 'author',
	select z.v from Pub x, Field y, Field z where x.k=y.k and y.k=z.k and x.p='www' and y.v= name and z.p = 'url'

insert into author (name, homepage)
select 
