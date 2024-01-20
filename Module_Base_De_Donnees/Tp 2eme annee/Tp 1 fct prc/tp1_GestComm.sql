create database GestionCom;
use GestionCom;

create table article(
	NumArt varchar(3) primary key,
    DesArt varchar(50),
    PUArt float,
    QteEnStock int,
    SeuilleMin int,
    SeuilleMax int
);

create table Commande(
	NumCom varchar(3) primary key,
    DateCom date
);

create table LigneCommande(
	NumCom varchar(3),
    NumArt varchar(3),
    QteCommandee int,
    primary key(NumCom,NumArt),
    constraint fk1_commande foreign key(NumCom) references Commande(NumCom),
    constraint fk1_article foreign key(NumArt) references article(NumArt)
);

insert into article values('A01','article1',10000,200,10,400);
insert into article values('A02','article2',12000,100,5,200);
insert into article values('A03','article3',20000,10,1,100);
insert into article values('A04','article4',50000,20,40,150);

insert into commande values('C01','2022-03-08');
insert into commande values('C02','2023-01-18');
insert into commande values('C03','2023-12-28');
insert into commande values('C04','2022-07-07');

insert into LigneCommande values('C01','A01',30);
insert into LigneCommande values('C01','A02',30);
insert into LigneCommande values('C01','A04',30);
insert into LigneCommande values('C02','A01',50);
insert into LigneCommande values('C02','A03',50);
insert into LigneCommande values('C02','A04',50);
insert into LigneCommande values('C02','A02',10);
insert into LigneCommande values('C03','A04',3);
insert into LigneCommande values('C04','A01',8);
insert into LigneCommande values('C04','A03',8);

# Q 2
drop function if exists nbr_article;
DELIMITER //
create function nbr_article (commande varchar(3))
returns int
reads sql data
begin
return (select count(NumArt) from LigneCommande where NumCom = commande);
end //
DELIMITER ;
select nbr_article ('C01');

# Q 3
drop function if exists nbr_commandes;
DELIMITER //
create function nbr_commandes ()
returns int
reads sql data
begin
return (select count(NumCom) as 'Nombre Commandes' from Commande);
end //
DELIMITER ;
select nbr_commandes ();

# Q 4
drop procedure if exists SP_ListeArticles;
DELIMITER //
create procedure SP_ListeArticles (IN comm varchar(3))
begin
select a.* from article a inner join LigneCommande l on (a.NumArt = l.NumArt) where l.NumCom = comm;
end //
DELIMITER ;
call SP_ListeArticles ('C02');

# Q 5
drop procedure if exists SP_ComPeriode;
DELIMITER //
create procedure SP_ComPeriode (IN date1 date, IN date2 date)
begin
select * from Commande where DateCom between date1 and date2;
end //
DELIMITER ;
call SP_ComPeriode ('2022-01-01', '2023-01-01');

# Q 6
drop procedure if exists SP_stock;
DELIMITER //
create procedure SP_stock (IN art varchar(3))
begin
declare qte float;
declare mine int;
declare result varchar(30);
set qte = (select QteEnStock from article where NumArt = art);
set mine = (select SeuilleMin from article where NumArt = art);
if qte = mine then
	set result = 'Rupture de stock';
else
	set result = 'En Stock'; 
end if;
select result;
end //
DELIMITER ;
call SP_stock ('A01');

# Q 7
drop procedure if exists SP_article_observation;
DELIMITER //
create procedure SP_article_observation ()
begin
select NumArt, DesArt, PUArt,
case
when QteEnStock = 0 then 'Non Disponible'
when QteEnStock > SeuilleMin then 'Disponible'
else 'à Commander'
end as 'Observation'
from article;
end //
DELIMITER ;
call SP_article_observation();

# Q 8
drop function if exists montant;
DELIMITER //
create function montant (comm varchar(3))
returns varchar(20)
reads sql data
begin
declare mont float;
declare result varchar(20);
set mont = (select sum(l.QteCommandee * a.PUArt) from article a inner join LigneCommande l on (a.NumArt = l.NumArt) where NumCom = comm);
if mont < 100000 then
	set result = 'Commande Normale';
else
	set result = 'Commande Speciale';
end if;
return result;
end //
DELIMITER ;
select montant ('C01');

# Q 9
drop procedure if exists SP_commandes_type;
DELIMITER //
create procedure SP_commandes_type ()
begin
select *, montant(NumCom) as Type from Commande;
end //
DELIMITER ;
call SP_commandes_type ();

# Q 10
drop procedure sp_moyenne_prix;
DELIMITER //
create procedure sp_moyenne_prix ()
begin
while (select avg(PUArt) from article) < 20 and (select max(PUArt) from article) < 30 do
	update article set PUArt = PUArt * 1.1;
end while;
select avg(PUArt), max(PUArt) from article;
end //
DELIMITER ;
call sp_moyenne_prix ();
select * from article;

# pas encore executer
# Q 11
DELIMITER //
drop function if exists type_periode;
create function type_periode (comm varchar(3))
returns varchar (20)
reads sql data
begin
declare nbr_comm int;
declare periode varchar(20);
set nbr_comm = (select count(NumCom) from commande where NumCom = comm);
if nbr_comm > 100 then
	set periode = 'Periode Rouge';
elseif nbr_comm >= 50 then
	set periode = 'Periode Jaune';
else
	set periode = 'Periode Blanche';
end if;
return periode;
end //
DELIMITER ;
select type_periode ('C01');

# Q 12
drop procedure if exists SP_TypeComPeriode;
DELIMITER //
create procedure SP_TypeComPeriode (IN date1 date, IN date2 date)
begin
select *, type_periode (NumCom) as 'Periode' from Commande where DateCom between date1 and date2;
end //
DELIMITER ;

# Q 13
drop procedure if exists sp_question13;
DELIMITER //
create procedure sp_question13 ()
begin
declare new_com int;
select max(NumCom) +1 into new_com from Commande;
insert into Commande value (new_com, now());
insert into LigneCommande select new_com, NumArt, 3*SeuilleMin from article where QteEnStock <= SeuilleMin;
end //
DELIMITER ;
call sp_question13 ();
# Q 14
drop procedure if exists sp_enregistrerLingeCom;
DELIMITER //
create procedure sp_enregistrerLingeCom (IN ncmd varchar(3), IN nart varchar(3), IN Qtecmd int)
begin
if (select NumArt from article where NumArt = nart) is null then
	select 'Cette article n existe pas';
elseif (select QteEnStock from article where NumArt = nart) < Qtecmd then
	select 'Cette quantite n est pas disponible';
else 
	if (select NumCom from Commande where NumCom = ncmd) is null then
		insert into Commande values (ncmd, sysdate());
	end if;
    insert into LigneCommande values (ncmd, nart, Qtecmd);
    update article set QteEnStock = QteEnStock - QteCmd where NumArt = nart;
end if;
end //
DELIMITER ;
call sp_enregistrerLingeCom ('c01', 'A01', 200);