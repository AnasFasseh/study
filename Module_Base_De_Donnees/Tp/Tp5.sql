create database Biblio;

use Biblio;

create table Candidat(
	num_candidat int primary key,
	nom_candidat varchar(50),
	date_naissance date,
	lieu_naissance varchar(50),
    pass varchar(30)
);
create table editeur(
	code_editeur int primary key,
	nom_editeur varchar(50),
	adresse varchar(50)
);
create table admine(
	num_admin varchar(10),
    password varchar(30)
);
create table livre(
	code_livre varchar(50) primary key,
	code_editeur int ,
	nom_livre varchar(50),
	nbr_pages int,
	genre varchar(30),
    constraint fk1_edit foreign key (code_editeur) references editeur (code_editeur) on delete cascade on update cascade
);
create table emprunter(
	num_candidat int,
	code_livre varchar(50),
	date_emprunt date,
	date_retour date,
	constraint pkem primary key(num_candidat,code_livre),
    constraint fk2_cand foreign key (num_candidat) references candidat(num_candidat) on delete cascade on update cascade,
	constraint fk3_livre foreign key (code_livre) references livre(code_livre) on delete cascade on update cascade
);

insert into Candidat values (10, 'Laachiri','1978-08-08','rabat','1234');
insert into Candidat values (12, 'Alaoui','1977-12-12','fes','5555');
insert into Candidat values (13, 'Baroudi','1978-09-12','agadir','8888');
insert into Candidat values (15, 'Mabrouke','1977-01-11','marrakech','0000');


insert into editeur values(1233,'Foucher','31,massira 3 marrakech');
insert into editeur values(4567,'duno','567,gueliz marrakech');
insert into editeur values(1600,'HACH','677 agdal rabat');

insert into livre values('ea344',1233,'conception',100,'informatique');
insert into livre values('ea500',1233,'MS WORD',43,'informatique');
insert into livre values('PK77',1600,'fiscalité',67,'gestion');
insert into livre values('hy89',4567,'comptabilité',123,'gestion');

insert into emprunter values(10,'ea500','2013-10-01','2013-11-01');
insert into emprunter values(10,'hy89','2013-11-01','2013-11-12');
insert into emprunter values(10,'ea344','2013-11-01','2013-11-12');
insert into emprunter values(10,'PK77','2013-11-01','2013-11-12');
insert into emprunter(num_candidat,code_livre,date_emprunt) values(15,'ea344','2013-12-14');

insert into admine values('admin','1111');

#Tp5
#Q1
select * from livre;
#Q2
select * from livre 
order by nom_livre desc,code_editeur;
#Q3
select num_candidat,code_livre from emprunter;
#Q4
select * from editeur where nom_editeur='Foucher';
#Q5
select nom_livre,code_livre from livre where ((nbr_pages>=100) and (code_editeur=1233 or nom_livre='conception'));
#Q6
select * from livre where nbr_pages<100;
#Q7
select * from livre 
where nbr_pages<100
order by nom_livre desc;
#Q8
select num_candidat,code_livre,date_emprunt from emprunter where date_retour is null;
#Q9
select * from livre where (nbr_pages between 50 and 100);
#Q10
select * from livre where code_editeur=1233;
#Q11
select * from livre where (nom_livre like 'I%');
#Q12
select * from livre where (nom_livre like '_o%');
#Q13
select * from livre where Not (code_editeur=1233);
#Q14
select	 * from livre where Not (nom_livre like 'I%');
#Q15
select *,nbr_pages+2 as Nb2pages from livre;