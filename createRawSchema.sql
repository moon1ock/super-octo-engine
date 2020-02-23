drop table if exists Pub cascade;
create table Pub (k text, p text);


drop table if exists Field cascade;
create table Field (k text, i text, p text, v text);
copy Pub from '/Users/mikolajdebicki/Desktop/super-octo-engine/pubFile.txt';
copy Field from '/Users/mikolajdebicki/Desktop/super-octo-engine/fieldFile.txt';
