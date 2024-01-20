create database gestion_rdv;
use gestion_rdv;

create table medecin(
code_medecin int primary key,
nom_medecin varchar(20),
tel_medecin varchar(10),
date_embauche date,
specialite_medecin varchar(20)
);

create table patient(
code_patient int primary key,
nom_patient varchar(20),
adresse_patient varchar(20),
date_naissance date,
sex_patient varchar(10)
);

create table rdv(
num_rdv int primary key,
date_rdv date,
heure_rdv varchar(6),
code_patient int,
code_medecin int,
constraint fk1_medecin
foreign key (code_medecin)
references medecin(code_medecin)
on delete cascade on update cascade,
constraint fk2_patient
foreign key (code_patient)
references patient(code_patient)
on delete cascade on update cascade
);

create table utilisateur(
login int primary key,
nom varchar(20),
prenom varchar(20),
pass varchar(20),
droit varchar(20)
);

insert into medecin values(111,'medecin1','0611224455','2023-06-25','specialite1'),(222,'medecin2','0755996677','2022-07-30','specialite2');
insert into patient values(123,'Imrane','adresse1','2023-06-25','male'),(456,'Halima','adresse2','2022-07-30','female');
insert into rdv values(789,'2023-11-05','12:30',123,111),(398,'2023-03-01','16:30',456,222);
insert into utilisateur values(333,'Fasseh','Anas','anas123','admin'),(444,'Bella','Amine','amine123','user');
select * from patient;