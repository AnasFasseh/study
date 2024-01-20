create database vol;
use vol;
create table pilote(
matricule int,
nom varchar (20),
ville varchar (20),
age int,
salaire int
);
create table avion(
numav int,
capacite int,
type_avion varchar (20),
entrepot varchar (20)
);
create table vol(
numvol varchar (20),
heure_depart time,
heure_arrivee time,
ville_depart varchar (20),
ville_arrivee varchar (20),
numav int,
matricule int
);
alter table pilote
add primary key (matricule);
alter table avion
add primary key (numav);
alter table vol
add primary key (numvol),
add constraint ck_forein_vol
foreign key (numav)
references avion (numav),
add constraint ck1_forein_vol
foreign key (matricule)
references pilote (matricule),
add constraint ck2_depart_vol
check (heure_depart>=0 and heure_depart<=23),
add constraint ck2_arrivee_vol
check (heure_arrivee>=0 and heure_arrivee<=23);
insert into pilote values (1,"Figue","Cannes",45,28004),(2,"Lavande","Touquet",24,11758);
insert into avion values (14,25,"A400","Garches"),(345,75,"B200","Maubeuge");
insert into vol values ("AL12","08:18","09:12","Paris","Lilles",14,1),("AF8","11:20","23:54","vaux","Rio",345,2);
update pilote
set nom="Figues" where matricule=1;
update pilote
set salaire=33604.8 where matricule=1;
update pilote
set salaire=14109.6 where matricule=2;
update vol
set heure_depart="08:10" and heure_arrivee="09:19" where numvol="AF8";
update avion
set type_avion="A400" where (capacite>50);
delete from avion where numav=14;
delete from vol where ville_depart=ville_arrivee;
delete from vol where numvol="AL12" and numvol="AF8";

#les sous requets
select * from pilote where salaire=(select max(salaire) from pilote);
select * from pilote where age<(select avg(age) from pilote);
select *,age from pilote where age<Any(select age from pilote);

#LES JOINTURES
#la jonture internne
select p.nom,count(v.numvol) as nbr_vol from pilote p inner join vol v on(p.matricule=v.matricule)
group by p.matricule having nbr_vol>All(select count(numvol) from vol group by matricule);
select p.nom from pilote p inner join vol v on(p.matricule=v.matricule) inner join avion a on(a.numav=v.numav) where a.capacite=(select max(capacite) from avion);