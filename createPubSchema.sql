Drop table if exists author cascade;
Create table author (
	-- id int primary key,
	name text,
	homepage text
);

Drop table if exists publication cascade;
Create table publication (
	pubid int primary key,
	pubkey text,
	title text,
	year int
);

Drop table if exists article cascade;
Create table article (
	pubid int,
	journal text,
	month text,
	volume numeric,
	number numeric,
	/* foreign key (pubid) references publication (pubid) */
);

Drop table if exists book cascade;
Create table book (
	pubid int,
	publisher text,
	isbn numeric,
	/* foreign key (pubid) references publication (pubid) */

);

Drop table if exists incollection cascade;
Create table incollection (
	pubid int,
	booktitle text,
	publisher text,
	isbn numeric,
	/* foreign key (pubid) references publication (pubid) */
);

Drop table if exists inproceedings cascade;
Create table inproceedings (
	pubid int,
	booktitle text,
	editor text,
	/* foreign key (pubid) references publication (pubid) */
);
