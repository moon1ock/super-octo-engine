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


/* insert into publications(pubkey) select distinct k from Field; */

/* insert into publications (title) select f.v from Field f where f.p = 'title' and publications.pubkey = f.k; */


create table keys (pk text); -- have a table of unique distinct keys
insert into keys (pk) select distinct k from Field; -- populate the table

create table tmpublyear (pk text, year int); -- table of key | yaar
-- use these tables to full outer join with the other ones and have key | year | publications

insert into tmpublyear (pk, year) select distinct pk, cast(v as int) from Field f, Keys k where k.pk = f.k and f.p = 'year';

create table tmpubltitle (pk text, title text);
insert into tmpubltitle (pk, title) select distinct pk, v from Field f, Keys k where k.pk = f.k and f.p = 'title';


create table publications (pubkey text not null, title text, year int); -- use this table to store the full join of the above two


insert into publications (pubkey, year, title) select tmpubltitle.pk, tmpublyear.year, tmpubltitle.title from tmpublyear full outer join tmpubltitle on tmpubltitle.pk = tmpublyear.pk where tmpublyear.year is NOT NULL and tmpubltitle.title IS NOT NULL;
-- after this we have a table of publications, their years, and respective keys
-- due to a bug in the initial database, we decided to delete ` books/daglib/0079308 ` record, as it repeats twice and compromises the uniqueness of keys

delete from publications where pubkey = 'books/daglib/0079308'; -- now, lets impose the constraint of uniqueness onto publications

alter table publications add constraint 


