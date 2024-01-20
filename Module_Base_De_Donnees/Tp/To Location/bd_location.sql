create database location;
use location;

create table syndic(
code_syndic int primary key,
nom_syndic varchar(20),
prenom_syndic varchar(20),
telephone_syndic varchar(10),
mot_depasse varchar(20),
);

create table bien_immobilier(
code_bien int primary key,
adresse_bien varchar(20),
num_enregistrement int,
superficie double,
typee varchar(20),
code_quartier varchar(20),
date_construction date,
constraint fk_immobilier
foreign key (code_quartier)
references quartier(code_quartier)
on delete cascade
on update cascade
);

create table contrat(
num_contrat int primary key,
date_contrat date,
prix_mensuel double,
code_bien int,
code_syndic int,
etat varchar(20),
constraint fk1_contrat
foreign key (code_bien)
references bien_immobilier(code_bien)
on delete cascade
on update cascade,
constraint fk2_contrat
foreign key (code_syndic)
references syndic(code_syndic)
on delete cascade
on update cascade
);

create table region(
code_region int primary key,
nom_region varchar(20),
population_region int,
total_region int
);

create table ville(
code_ville int primary key,
nom_ville varchar(20),
code_region int,
total_ville double,
constraint fk_ville
foreign key (code_region)
references region(code_region)
on delete cascade
on update cascade
);

create table quartier(
code_quartier varchar(20) primary key,
nom_quartier varchar(20),
population_quartier int,
code_ville int,
total_quartier double,
constraint fk_quartier
foreign key (code_ville)
references ville(code_ville)
on delete cascade
on update cascade
);
create table utilisateur(
logine varchar(20) primary key,
pass varchar(20),
droit varchar(20)
);

alter table syndic
drop column img;
insert into region values(111,'region1',20,50),(222,'region2',30,80),(333,'region3',70,10),(444,'region4',16,60);

insert into syndic values(012,'ahmed','hamid','0605040302','000'),(345,'amine','samir','0611223344','122'),(678,'karim','soulaimane','0578269412','345'),
(910,'hamza','kamal','0514269745','987');

insert into ville value(40000,'marrackech',111,12.02),(50000,'agadir',222,20.15),(60000,'fes',333,50.06),(70000,'tanger',444,45.23);

insert into quartier values('Q1','nom1',20,40000,30),('Q2','nom2',30,50000,60),('Q3','nom3',80,60000,90),('Q4','nom4',16,70000,33);

insert into bien_immobilier values(4578,'adresse1',202,504.12,'type1','Q1','2023-05-22'),(3548,'adresse2',187,74.50,'type2','Q2','2022-11-07'),(6987,'adresse3',23,54.78,'type3','Q3','2020-01-01'),(9850,'adresse4',36,40.40,'type4','Q4','2019-02-02');


insert into contrat values(321,'2023-08-30',100.20,4578,012,'etat1'),(654,'2023-10-15',250.70,3548,345,'etat2'),
(987,'2023-04-21',194.88,6987,678,'etat3'),(101,'2023-09-04',58.90,9850,910,'etat4');

select b.* from syndic s inner join contrat c on (s.code_syndic=c.code_syndic) inner join bien_immobilier b on (b.code_bien=c.code_bien) ;
select * from syndic;