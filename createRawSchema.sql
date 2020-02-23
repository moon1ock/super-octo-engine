drop table if exists Pub cascade;
create table Pub (k text, p text);


drop table if exists Field cascade;
create table Field (k text, i text, p text, v text);
copy Pub from '/Users/andriylunin/Documents/CS_work/DBMS/PS1/pubFile.txt';
copy Field from '/Users/andriylunin/Documents/CS_work/DBMS/PS1/fieldFile.txt';
