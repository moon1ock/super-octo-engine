select * from Field a, Field b where a.p = 'author' and b.k = 'booktitle' and a.k = b.k and b.v = 'SIGMOD conference' limit 10;
