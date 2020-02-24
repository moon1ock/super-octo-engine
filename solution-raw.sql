
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



