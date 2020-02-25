-- here have a table author | key
create table tmpAuthors (name text, key text);

insert into tmpAuthors (name, key) select v,k from Field f where f.p = 'author';




-- have a table key | homepage

create table tmpHomepages (homepage text, key text);

insert into tmpHomepages (key, homepage) select k, v from Field f where f.p = 'url' and f.k like 'homepage%';

-- create table authors and concatenate the tmp tables to get the actual set of authors

create table authors (name text NOT NULL, homepage text NOT NULL);
 -- the NOT NULL constraints have tp be imposed due to some
insert into authors (name, homepage) select tmpauthors.name, tmphomepages.homepage from tmpauthors left outer join tmphomepages on tmpauthors.key=tmphomepages.key where tmpauthors.name IS NOT NULL AND tmphomepages.homepage IS NOT NULL;

-- we know that every author is uniquely identified by their homepage! so we'll just need the id mapped from homepage and pubid to make the Authored statement
alter table authors add id numeric;
create sequence q;
update authors set id = nextval('q');
alter table authors add constraint authors_pk primary key (id);
---DONE WITH AUTHORS

-- *********DO NOT FORGET TO DROP ADDITIONAL TABLES LATER ************-----

-- deal with publication

create table publications (pubid numeric unique not null, pubkey text not null unique, title text not null, year int not null);




