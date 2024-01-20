create database gestion_voiture;
use gestion_voiture;
create table client (
num_client int primary key,
nom_client varchar (15) not null,
adresse varchar (100),
Tel varchar (10) check (Tel rlike "0[678][0-9]{8}"),
remarque varchar (100)
);
create table voiture (
num_voiture varchar (50) check (num_voiture rlike "[a-zA-Z]{2}-[0-9]{5}") primary key,
marque varchar (50) not null default ("toyota") check (marque="peugeot" or marque="suzuki" or marque="fiat" or marque="toyota"),
model int not null check (model>2010)
);
create table louage (
num_client int,
num_voiture varchar (50),
date_louage date check (date_louage>"2013-01-01"),
date_retoure date check (date_retoure>"2015-12-12"),
prix float check (prix>3000 or prix=500),
constraint fk_1_client
foreign key (num_client)
references client (num_client),
constraint fk_2_voiture
foreign key (num_voiture)
references voiture (num_voiture)
);
insert into client values (1,"anas","edefe marrakech","0604803549",)