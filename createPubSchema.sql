Drop table if exists author cascade;
Create table author (
	id int primary key,
	name char(20),
	homepage char(20)
);

Drop table if exists publication cascade;
Create table publication (
	pubid int primary key,
	pubkey char(20),
	title char(20),
	year int
);

Drop table if exists article cascade;
Create table article (
	pubid int,
	journal char(20),
	month char(20),
	volume int,
	number int,
	foreign key (pubid) references publication (pubid)
);

Drop table if exists book cascade;
Create table book (
	pubid int,
	publisher char(20),
	isbn int,
	foreign key (pubid) references publication (pubid)

);

Drop table if exists in incollection cascade;
Create table incollection (
	pubid int,
	booktitle char(20),
	publisher char(20),
	isbn int,
	foreign key (pubid) references publication (pubid)
);

Drop table if exists inproceedings cascade;
Create table inproceedings (
	pubid int,
	booktitle char(20),
	editor char(20),
	foreign key (pubid) references publication (pubid)
);
