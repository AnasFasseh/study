create database gestion_reservation;
use gestion_reservation;
create table client (
code_client int primary key,
nom varchar (30) not null,
lieu_naissance varchar (20),
date_naissance date,
etat_civil varchar (20),
residence varchar (30),
nationalite varchar (20),
date_arrive date ,
date_sortie date ,
constraint check (date_arrive<date_sortie)
);
create table reservation (
num_reservation int auto_increment primary key,
codecategorie int,
chambre int,
date_revervation date,
code_client int,
constraint fk_1_reservation
foreign key (code_client)
references client (code_client)
on delete cascade
on update cascade
);
create table facturation (
codeFacture int primary key,
datefacture date,
codecategorie int,
chambre int,
code_client int,
constraint fk_2_facturation
foreign key (code_client)
references client (code_client)
on delete cascade
on update cascade
);
create table categorie_chambre (
codecategorie int,
chambre int,
tarif float,
designation varchar (20),
tarifTVA int,
primary key (codecategorie,chambre)
) ;
alter table client
add email varchar (20),
add tel varchar (10),
modify nom varchar (40) not null,
drop column email,
modify nationalite varchar (20) default("Marocain"),
modify etat_civil varchar (20) check (etat_civil="celibataire" or etat_civil="marrie" or etat_civil="divorce"),	
drop primary key,
add primary key (code_client);

alter table categorie_chambre
change column tarif tarif_dh float,
add type_chambre varchar (20) unique,
modify designation varchar (20) check (designation="C1" or designation="C2" or designation="C3" or ordesignation="C4"),
modify tarif_dh float check (tarif_dh>=500 and tarif_dh<=1100),
drop primary key,
add primary key (codecategorie,chambre);

alter table facturation
modify datefacture datetime default (now()),
drop foreign key fk_2_facturation,
drop primary key,
add primary key (codeFacture),
add constraint ck_3_facturation
foreign key (code_client)
references clients (code_client);

alter table client
rename to clients;
drop table clients;
drop table facturation;
drop table categorie_chambre;

