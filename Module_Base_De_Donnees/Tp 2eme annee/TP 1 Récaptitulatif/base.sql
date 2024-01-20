create database base;
use base;
create table societe(
codesoc int primary key,
nomsoc varchar(20),
adressesoc varchar(20)
);

create table candidat(
numcand int primary key,
nomcand varchar(20) not null,
prenomcand varchar(20) not null,
datecand date,
codesoc int,
constraint fk1_soc foreign key (codesoc) references societe (codesoc)on delete cascade on update cascade
);

create table stage(
numstage int primary key,
intitulestage varchar(20)
);

create table formateur(
codeform int primary key check(codeform rlike '[0-9]{5}'),
nomform varchar(20),
prnomform varchar(20),
adresseform varchar(20),
dateform date
);

create table module(
nummod int primary key,
nommode varchar(20),
massehor float check (massehor > 0),
codeform int,
constraint fk1_form foreign key (codeform) references formateur (codeform) on delete cascade on update cascade
);

create table composition(
numstage int,
nummod int,
primary key(numstage, nummod),
constraint fk2_stage foreign key (codeform) references formateur (codeform)on delete cascade on update cascade,
constraint fk2_module foreign key (codeform) references formateur (codeform)on delete cascade on update cascade
);

create table sessions(
numsess int primary key,
datedebut date,
datefin date,
numstage int,
constraint fk1_sess foreign key (numstage) references stage (numstage)on delete cascade on update cascade
);

create table enseigne(
nummod int,
codeform int,
numsess int,
primary key(nummod, codeform, numsess),
constraint fk3_module foreign key (nummod) references module (nummod)on delete cascade on update cascade,
constraint fk2_form foreign key (codeform) references formateur (codeform)on delete cascade on update cascade,
constraint fk3_stage foreign key (numsess) references sessions (numsess)on delete cascade on update cascade
);

create table inscrit(
numcand int,
numsess int,
dateinsc date,
primary key(numcand,numsess),
constraint fk1_cand foreign key (numcand) references candidat (numcand)on delete cascade on update cascade,
constraint fk1_sess foreign key (numsess) references sessions (numsess)on delete cascade on update cascade
);

# Q2
alter table inscrit
modify dateinsc date default (curdate());

# Q3
alter table sessions
add constraint check1_date
check (datediff(datefin, datedebut) >= 7);

# Q4
drop procedure if exists sp_nbr_candidat;
delimiter //
create procedure sp_nbr_candidat (IN stage int, OUT nbr_cand int)
begin
if stage in (select numstage from sessions) then
	set nbr_cand = (select count(i.numcand) from inscrit i inner join sessions s on (s.numsess = i.numsess) where s.numstage = stage);
else
	set nbr_cand = 0;
end if;
end //
delimiter ;

# Q5
delimiter //
create trigger diminuer_masseHor before update on module for each row
begin
if new.massehor < old.massehor then
	signal sqlstate '50004' set message_text = 'impossible de diminuer la masse horaire du module';
end if;
end //
delimiter ;

# Q6
delimiter //
create procedure sp_liste_sessions (IN stage int)
begin
	select * from sessions where numstage = stage and datedebut > sysdate();
end //
delimiter ;

# Q7
delimiter //
create trigger memeformateur before insert on enseigne for each row
begin
if (select datedebut from sessions s inner join enseigne e on (s.numsess = e.numsess) where s.numsess = new.numsess and e.codefor = new.codefor) = (select datedebut from sessions s inner join enseigne e on(s.numsess = e.numsess) where e.codefor = new.codefor) then
	signal sqlstate '50004' set message_text = 'impossible de d’affecter le même formateur pour enseigner dans deux sessions différentes qui commence la même date';
end if;
end //
delimiter ;

# Q8
delimiter //
create procedure sp_liste_sessions_dates (IN d1 date, IN d2 date)
begin
select m.* from module m inner join enseigne e on (m.nummod = e.nummod) inner join sessions s on (s.numsess, e.numsess) where s.datedebut between d1 and d2;
end //
delimiter ;

# Q9
delimiter //
create function scalaire (stage int)
returns varchar(20)
reads sql data
begin
declare mo int;
declare form int;
declare rslt varchar(20);
set mo = (select count(e.nummod) from enseigne e inner join sessions s on (s.numsess, e.numsess) where s.numstage = stage);
set form = (select count(e.codeform) from enseigne e inner join sessions s on (s.numsess, e.numsess) where s.numstage = stage);
set rslt = concat(mo, ' ', form);
return rslt;
end //
delimiter ;