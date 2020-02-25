-- here have a table author | key
create table tmpAuthors (name text, key text);
-- DO NOT DROP tmpAuthors just yet, will be needed later!
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
drop sequence q;
---DONE WITH AUTHORS



-- deal with publication

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

alter table publications add constraint pubkey unique(pubkey);


-- add pubie
alter table publications add pubid numeric;
create sequence q;
update publications set pubid = nextval('q');


-- table publication \ name
create table own (key text, name text);
insert into own (key, name) select k, v from field f where f.p = 'author';

-- search through names and lace them with authors
create table written (key text, id numeric);

insert into written (key, id) select own.key, authors.id from own left join authors on own.name = authors.name where own.key IS NOT NULL and authors.id IS NOT NULL;

-- at this moment the written table has keys to articles and id's to authors, all that is left is joining the id and pubid on key! way to go

create table authored (id numeric, pubid numeric);
insert into authored (id, pubid) select written.id, publications.pubid from written left join publications on written.key = publications.pubkey where written.id is not NULL and publications.pubid is not null;
drop table written;
-- relation author - authered is done
-- make the article table

create table tmparticles (pubkey text);
insert into tmparticles (pubkey) select k from pub p where p.p = 'article'; -- keep all the article keys for convenience

create table atcjr (key text, journal text);

insert into atcjr (key, journal) select tmparticles.pubkey, field.v from tmparticles left join field on tmparticles.pubkey = field.k where field.p = 'journal' and tmparticles.pubkey is not null and field.v is not null; -- this will return pubkey to articles | journal table

create table atcvol (key text, journal text, volume text);


insert into atcvol (key, journal, volume) select atcjr.key, atcjr.journal, field.v from atcjr left join field on atcjr.key = field.k where field.p = 'volume' and atcjr.key is not null and field.v is not null;
-- this is the table of articles with jornals and volumes


create table atcmonth (key text, journal text, volume text, month text);
insert into atcmonth (key, journal, volume, month) select atcvol.key, atcvol.journal, atcvol.volume, field.v from atcvol left join field on atcvol.key = field.k where field.p = 'month';

-- just a reminder, we DO NOT LOOK at any faulty records, i.e those that do not have a month or volume specified, since our database is textbook perfect and we decided that we do want to keep the records clean and free of NULLs
-- now we can finish the articles table


insert into articles (pubkey, journal, volume, month , nmbr) select atcmonth.key, atcmonth.journal, atcmonth.volume, atcmonth.month, field.v from atcmonth left join field on atcmonth.key = field.k where field.p = 'number';




create table articles (pubkey text, journal text, volume text, month text, nmbr text);
-- at this moment the articles table is complete and we may drop all the side tables
drop table tmparticles, atcjr, atcvol, atcmonth;



--- lets deal with incollections now in an analohous way!
create table tmpinc (pubkey text);
insert into tmpinc (pubkey) select k from pub p where p.p = 'incollection';


create table incbk (pubkey text, booktitle text);
insert into incbk (pubkey, booktitle) select tmpinc.pubkey, field.v from tmpinc left join field on tmpinc.pubkey = field.k where field.p = 'booktitle';

-- after doing the below listed queries we did realize that no incollections in our verison of database seem to have an idbn value so we decided to drop it, and not deal with it

/* create table ib (key text, booktitle text, isbn text); */
/* insert into ib (key, booktitle, isbn) select incbk.pubkey, incbk.booktitle, field.v from incbk full join field on incbk.pubkey = field.k where     field.p = 'isbn'; */



create table incollection (key text, booktitle text, publisher text);
insert into incollection (key, booktitle, publisher) select incbk.pubkey, incbk.booktitle, field.v from incbk full join field on incbk.pubkey = field.k where field.p = 'publisher' and incbk.pubkey is not null;


drop table tmpinc, incbk;

-- analogously dealing with the left inproceedings and books


create table tp (pubkey text);
insert into tp (pubkey) select k from pub p where p.p = 'inproceedings';



create table tpbk (pubkey text, booktitle text);
insert into tpbk (pubkey, booktitle) select tp.pubkey, field.v from tp left join field on tp.pubkey = field.k where field.p = 'booktitle';


create table inproceedings(pubkey text, booktitle text, editor text);
insert into inproceedings (pubkey, booktitle, editor) select tpbk.pubkey, tpbk.booktitle, field.v from tpbk full join field on tpbk.pubkey = field.k where field.p = 'editor' and tpbk.pubkey is not null;

drop table tp, tpbk;




create table bk (pubkey text);
insert into bk (pubkey) select k from pub p where p.p = 'book';


create table pbk (pubkey text, publisher text);
insert into pbk (pubkey, publisher) select bk.pubkey, field.v from bk left join field on bk.pubkey = field.k where field.p = 'publisher';



create table book (pubkey text, publisher text, isbn text);
insert into book (pubkey, publisher, isbn) select pbk.pubkey, pbk.publisher, field.v from pbk full join field on pbk.pubkey = field.k where field.p = 'isbn' and pbk.pubkey is not null;

drop table bk, pbk;
-- done with books

/*DATABASE IS DONE*/









