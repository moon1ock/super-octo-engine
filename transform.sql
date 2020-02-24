-- here have a table author | key
create table tmpAuthors (name text, key text);

insert into tmpAuthors (name, key) select v,k from Field f where f.p = 'author';




-- have a table key | homepage

create table tmpHomepages (homepage text, key text);

insert into tmpHomepages (homepage, key) select v,k from Field f where f.p = 'url' and f.k like 'homepage%';

-- create table authors and concatenate the tmp tables to get the actual set of authors

create table author (id int primary key, name text, homepage text);





