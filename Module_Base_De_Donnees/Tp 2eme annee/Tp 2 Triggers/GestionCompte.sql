create database GestionCompte;
use GestionCompte;
create table client (
numcli int primary key ,
cincli  varchar(6),
nomcli varchar(30),
adrescli varchar(30),
telcli int
);

create table compte(
numcpt int primary key,
soldecpt float,
typecpt varchar(2),
numcli int,
constraint fk_cpt
foreign key (numcli) references client(numcli)  ON DELETE CASCADE ON UPDATE CASCADE
);

create table operation(
numop int primary key ,
typeop varchar(1),
mtop  float,
numcpt int,
dateop date,
constraint fk_op
foreign key (numcpt) references compte(numcpt)  ON DELETE CASCADE ON UPDATE CASCADE
);

insert into client values(1,"EE3289","Anass bslm","daoudiat","0666666666");
insert into client values(2,"EE9856","osm be","chi blasa","0677777777");
insert into client values(3,"EE6723","oussama belfakir","marrakech","0688888888");

#--------------------------------------------------------------------------------------------------------------

insert into compte values(10,23000,"CC","1");
insert into compte values(20,9000,"CN","2");
insert into compte values(30,4567,"CC","3");

#--------------------------------------------------------------------------------------------------------------

insert into operation values(100,"D",45678,10,curdate());
insert into operation values(200,"R",7675,20,curdate());
insert into operation values(300,"D",1458,30,curdate());

select * from client;


# TR 1
drop trigger if exists trigger1_1;
DELIMITER //
create trigger trigger1_1 before insert on client
for each row
begin
if new.cincli in (select cincli from client) then
	signal sqlstate '50004' set message_text = 'Ce CIN deja existe';
end if;
end //
DELIMITER ;
insert into client values(4,"EE3289","Anass bslm","daoudiat","0666666666");

drop trigger if exists trigger1_2;
DELIMITER //
create trigger trigger1_2 before update on client
for each row
begin
if new.cincli in (select cincli from client) then
	signal sqlstate '50004' set message_text = 'Ce CIN deja existe';
end if;
end //
DELIMITER ;
insert into client values(3,"EE6723","oussama belfakir","marrakech","0688888888");


# TR 2
drop trigger if exists trigger2;
DELIMITER //
create trigger trigger2 before insert on compte
for each row
begin
if new.soldecpt < 1500 then
	signal sqlstate '50001' set message_text = 'les soldes doient etre superieur a 1500 DH';
end if;
if new.typecpt not in ('CC', 'CN') then
	signal sqlstate '50001' set message_text = 'le type de compte prends juste les valeurs CN et CC';
end if;
if new.typecpt = (select typecpt from compte where numcli = new.numcli) then
	signal sqlstate '50001' set message_text = 'tu as deja un compte de ce type';
end if;
end //
DELIMITER ;


# TR 3
drop trigger if exists trigger3;
DELIMITER //
create trigger trigger3 before delete on compte
for each row
begin
declare datee date;
set datee = (select max(dateop) from operation where numcpt = old.numcpt);
if old.soldecpt > 0 then
	signal sqlstate '50001' set message_text = 'le solde est superieur a 0';
elseif datediff(month(curdate()), month(datee)) < 3 then
	signal sqlstate '50005' set message_text = 'La dernière opération date de ce compte est inférieur à 3 mois';
end if;
end //
DELIMITER ;


# TR 4
drop trigger if exists trigger4;
DELIMITER //
create trigger trigger4 before update on compte
for each row
begin
declare numC int;
if new.numcpt != old.numcpt then
	signal sqlstate '50001' set message_text = 'Impossible de modifier le numero de compte';
end if;
set numC = (select numcpt from compte where soldecpt = old.soldecpt);
if new.soldecpt != old.soldecpt and numC in (select numcpt from operation) then
	signal sqlstate '50004' set message_text = 'Impossible de modifier le solde d un compte associe a une operation';
end if;
if (new.typecpt = 'CC' and old.typecpt = 'CN') then
	signal sqlstate '50005' set message_text = 'Impossible de modifier le type de compte';
end if;
end //
DELIMITER ;