create table Pub (k text, p text);
create table Field (k text, i text, p text, v text);
copy Pub from '/Users/azza/Dropbox/NYUADDB/Spring2020/PS-1/pubFile.txt';
copy Field from '/Users/azza/Dropbox/NYUADDB/Spring2020/PS-1/fieldFile.txt';
