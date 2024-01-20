create database projet;
use projet;

create table employe (
numEmp int primary key,
nom varchar(20),
numService int,
numchef int,
salaire float
);

insert into employe values (1, 'employe1', 1, 1, 5000);
insert into employe values (2, 'employe2', 2, 2, 3000);
insert into employe values (3, 'employe3', 3, 3, 7000);
insert into employe values (4, 'employe4', 4, 4, 9000);

create table projet (
numProjet int primary key,
nomProjet varchar(20),
numResponsable int
);

insert into projet values (1, 'projet1', 1);
insert into projet values (2, 'projet2', 2);
insert into projet values (3, 'projet3', 3);
insert into projet values (4, 'projet4', 4);

create table participe (
numEmp int,
numProjet int,
quota int,
constraint fk_emp
foreign key (numEmp) references employe(numEmp)  ON DELETE CASCADE ON UPDATE CASCADE,
constraint fk_proj
foreign key (numProjet) references projet(numProjet)  ON DELETE CASCADE ON UPDATE CASCADE,
primary key (numEmp, numProjet, quota)
);

insert into participe values (1, 1, 50);
insert into participe values (2, 2, 20);
insert into participe values (3, 3, 35);
insert into participe values (4, 4, 80);


# Tr 1
delimiter //
create trigger trigger1_1 before insert on projet
for each row
begin
if new.numResponsable is not null then
	signal sqlstate '50004' set message_text = 'veuillez attribuer le numero du responsable dans la table participe en premier puis attribue ce numero dans la table projet';
end if;
end //
delimiter ;

delimiter //
create trigger trigger1_2 before update on projet
for each row
begin
if new.numResponsable not in (select numEmp from participe where numProjet = new.numProjet) then
	signal sqlstate '50004' set message_text = 'impossible d attribuer le responsable akirs qu il ne participe meme pas au projet';
end if;
end //
delimiter ;

# Tr 2
delimiter //
create trigger trigger2 before insert on projet
for each row
begin
if new.numResponsable not in (select numEmp from participe where numProjet = new.numProjet) then
	insert into participe values (new.numResponsable, new.numProjet, quota);
end if;
end //
delimiter ;

# Tr 3
delimiter //
create trigger trigger3 before insert on participe
for each row
begin
if (select sum(quota) from participe where numEmp = new.numEmp) > 100 then
	signal sqlstate '50004' set message_text = 'la somme de quota doit etre n excede pas 100';
end if;
end //
delimiter ;