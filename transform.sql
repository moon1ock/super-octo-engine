-- here have a table author | key
create table tmpAuthors (name text, key text);

insert into tmpAuthors (name, key) select v,k from Field f where f.p = 'author';




-- have a table key | homepage

create table tmpHomepages (homepage text, key text);

insert into tmpHomepages (key, homepage) select k, v from Field f where f.p = 'url' and f.k like 'homepage%';

-- create table authors and concatenate the tmp tables to get the actual set of authors

create table authors (id int primary key, name text, homepage text);

insert into authors (name, homepage) select tmpauthors.name, tmphomepages.homepage from tmpAuthors left outer join tmphomepages limit 10;



-- we know that every author is uniquely identified by their homepage! so we'll just need the id mapped from homepage and pubid to make the Authored statement
