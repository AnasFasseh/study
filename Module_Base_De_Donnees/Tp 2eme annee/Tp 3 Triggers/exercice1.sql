create database fashion;
use fashion ;

create table styliste(
numStyliste varchar(5) primary key,
nomStyliste varchar(10),
adrStyliste varchar(20)
);

insert into styliste values ('S1', 'style1', 'adresse1');
insert into styliste values ('S2', 'style2', 'adresse2');
insert into styliste values ('S3', 'style3', 'adresse3');
insert into styliste values ('S4', 'style4', 'adresse4');

create table costume(
numCostume varchar(5) primary key,
design varchar(10),
numStyliste varchar(5),
constraint fk_nms
foreign key (numStyliste) references styliste(numStyliste)  ON DELETE CASCADE ON UPDATE CASCADE
);

insert into costume values ('C1', 'costume1', 'S1');
insert into costume values ('C2', 'costume2', 'S2');
insert into costume values ('C3', 'costume3', 'S3');
insert into costume values ('C4', 'costume4', 'S4');

create table MembreJury(
numMembreJury  varchar(5) primary key,
nomMembreJury varchar(10),
fonctionMembreJury varchar(15)
);

insert into MembreJury values ('M1', 'membre1', 'fonction1');
insert into MembreJury values ('M2', 'membre2', 'fonction2');
insert into MembreJury values ('M3', 'membre3', 'fonction3');
insert into MembreJury values ('M4', 'membre4', 'fonction4');

create table Notejury(
numCostume varchar(5),
constraint fk_nmc
foreign key (numCostume) references costume(numCostume) ON DELETE CASCADE ON UPDATE CASCADE,
numMembreJury varchar(5),
foreign key (NumMembreJury) references MembreJury(NumMembreJury) ON DELETE CASCADE ON UPDATE CASCADE,
noteAttribuee float,
primary key(numCostume,numMembreJury)
);

insert into Notejury values ('C1', 'M1', 15.50);
insert into Notejury values ('C2', 'M2', 17);
insert into Notejury values ('C3', 'M3', 12.50);
insert into Notejury values ('C4', 'M4', 10);

create table fonction(
fonction varchar(10) primary key
);

insert into fonction values ('fonction1');
insert into fonction values ('fonction2');
insert into fonction values ('fonction3');
insert into fonction values ('fonction4');


# Tr 1
delimiter //
create trigger trigger1 before insert on costume
for each row
begin
if new.numstyliste not in (select numstyliste from styliste) then
	signal sqlstate '50004' set message_text = 'ce num Style n existe pas';
end if;
end //
delimiter ;

# Tr 2
delimiter //
create trigger trigger2 before delete on costume
for each row
begin
if (select NoteAttribuee from NoteJury where numcostume = old.numcostume) is not null then
	signal sqlstate '50004' set message_text = 'la note n est pas attrubuee';
end if;
end //
delimiter ;

# Tr 3
delimiter //
create trigger trigger3 before insert on NoteJury
for each row
begin
if new.numcostume not in (select numcostume from costume) then
	signal sqlstate '50004' set message_text = 'ce costume n existe pas';
end if;
if new.numMembreJury not in (select numMembreJury from NoteJury) then
	signal sqlstate '50004' set message_text = 'ces membres de jury n existe pas';
end if;
if new.NoteAttribuee < 0 or new.NoteAttribuee > 20 then
	signal sqlstate '50004' set message_text = 'Les note attribuees doit etre entre 0 et 20';
end if;
end //
delimiter ;

# Tr 4
delimiter //
create trigger trigger2 after insert on membreJury
for each row
begin
if new.fonctionMembreJury not in (select fonction from fonction) then
	insert into fonction value (new.fonctionMembreJury);
end if;
end //
delimiter ;