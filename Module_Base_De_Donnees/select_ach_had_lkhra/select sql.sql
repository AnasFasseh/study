create database gestion_stg;
use gestion_stg;

-- Création des tables :

create table Stagiaires(
	NumS		varchar(3),
	NomS		varchar(30),
	PrenomS		varchar(30),
	Tel			varchar(10),
	primary key (NumS));

create table Examens(
	NumE		varchar(3),
	Salle		varchar(3),
	Date		datetime,
	TypeE		varchar(1),
primary key (NumE));

create table PasserExamen(
	NumS		varchar(3),
    NumE		varchar(3),
    Note		float,
	constraint	Fk_NumS_Stagiaires foreign key (NumS) references Stagiaires (NumS),
	constraint	Fk_NumE_Examens foreign key (NumE) references Examens (NumE),
	primary key (NumS, NumE));

-- Insertion des données :

insert into Stagiaires values ('S01', 'Laachiri', 'Hicham', '0612345678');
insert into Stagiaires values ('S02', 'Alaoui', 'Said', '0623456789');
insert into Stagiaires values ('S03', 'Baroudi', 'Kassem', NULL);
insert into Stagiaires values ('S04', 'Mabrouke', 'Khadija', NULL);
insert into Stagiaires values ('S05', 'Montasser', 'Jamila', '0634567890');
insert into Stagiaires values ('S06', 'Nahari', 'Hicham', '0645678901');

insert into Examens values ('E01', 'A1', '2022-09-10', 'T');
insert into Examens values ('E02', 'A6', '2022-12-1', 'P');
insert into Examens values ('E03', 'A6', '2022-12-01', 'T');
insert into Examens values ('E04', 'A2', '2022-11-21', 'T');
insert into Examens values ('E05', 'A1', '2022-12-19', 'T');
insert into Examens values ('E06', 'A3', '2022-12-13', 'T');
insert into Examens values ('E07', 'A6', '2023-02-04', 'P');
insert into Examens values ('E08', 'B5', '2023-03-15', 'P');
insert into Examens values ('E09', 'A2', '2022-12-18', 'T');
insert into Examens values ('E10', 'B5', '2022-01-27', 'T');

insert into PasserExamen values ('S01', 'E01', 12.5);
insert into PasserExamen values ('S01', 'E02', 14);
insert into PasserExamen values ('S01', 'E03', 13.75);
insert into PasserExamen values ('S01', 'E04', 17);
insert into PasserExamen values ('S01', 'E06', 15.25);
insert into PasserExamen values ('S01', 'E07', 13.62);
insert into PasserExamen values ('S01', 'E08', 17.25);
insert into PasserExamen values ('S01', 'E09', 17);
insert into PasserExamen values ('S01', 'E10', 15);
insert into PasserExamen values ('S02', 'E01', 8);
insert into PasserExamen values ('S02', 'E02', 4);
insert into PasserExamen values ('S02', 'E03', 11);
insert into PasserExamen values ('S02', 'E07', 13.25);
insert into PasserExamen values ('S02', 'E08', 11);
insert into PasserExamen values ('S02', 'E09', 13.5);
insert into PasserExamen values ('S02', 'E10', 11.75);
insert into PasserExamen values ('S03', 'E01', 18);
insert into PasserExamen values ('S03', 'E02', 20);
insert into PasserExamen values ('S03', 'E03', 15.75);
insert into PasserExamen values ('S03', 'E04', 11);
insert into PasserExamen values ('S03', 'E05', 16);
insert into PasserExamen values ('S03', 'E06', 19.5);
insert into PasserExamen values ('S03', 'E07', 18.5);
insert into PasserExamen values ('S03', 'E08', 14);
insert into PasserExamen values ('S03', 'E09', 18.5);
insert into PasserExamen values ('S03', 'E10', 16);
insert into PasserExamen values ('S04', 'E01', 12);
insert into PasserExamen values ('S04', 'E02', 16.5);
insert into PasserExamen values ('S04', 'E03', 14);
insert into PasserExamen values ('S04', 'E04', 20);
insert into PasserExamen values ('S04', 'E05', 15);
insert into PasserExamen values ('S04', 'E06', 7);
insert into PasserExamen values ('S04', 'E07', 12);
insert into PasserExamen values ('S04', 'E08', 16.75);
insert into PasserExamen values ('S04', 'E09', 12);
insert into PasserExamen values ('S04', 'E10', 15);
insert into PasserExamen values ('S05', 'E01', 2);
insert into PasserExamen values ('S05', 'E02', 11.5);
insert into PasserExamen values ('S05', 'E03', 2.5);
insert into PasserExamen values ('S05', 'E04', 13);
insert into PasserExamen values ('S05', 'E07', 7.75);
insert into PasserExamen values ('S05', 'E08', 6.5);
insert into PasserExamen values ('S05', 'E09', 5.13);

select NomS,PrenomS from stagiaires;

select * from examens
where salle='A6';

select NumS from stagiaires
where PrenomS='Hicham';

select * from examens
where date='2022-12-13';

select distinct numS from passerexamen
where note>14 ;

#Utilisation des opérateurs logiques
#And

select * from examens
where (Salle='A1') and (Date='2022-12-19');

#OR
select * from Examens
where salle='A6' or date='2022-11-21';

#Between
select * from Examens
where (date between '2022-12-01' and '2022-12-31');

#%
select *from stagiaires
where nomS like '%c%';

select * from stagiaires
 where nomS like '_a%';
 
 select * from stagiaires
 where nomS like '%b%' or nomS like '%e%' ;
 
 #NOT
 #IN 
 select * from examens
 where salle in ('A1','A2','A6');

# is not null
select * from stagiaires
where tel is not null;

#Utilisation de la clause ORDER BY :
#Syntax :
     select *
     from  stagiaires
     order by nomS DESC , prenomS DESC;
     
select  * 
from passerexamen
order by numS , numE DESC; 

#Ex d'application 1
#Q1
select * from examens ;
#Q2
select nums from stagiaires;
#Q3
select nume,date from examens ;
#Q4
select * from examens where salle="A2" or salle="A3";
#Q5
select * from examens where typee="p";
#Q6
select * from examens where typee="p" order by Date;
#Q7
select * from examens order by salle,date desc;
#Ex d'application 2
#Q1
select nume,note from passerexamen where nums="S01";
#Q2
select nume,note from passerexamen where note>=15 and nums="S01";
#Q3
select * from stagiaires where noms like "%u%"; 
#Q4
select * from stagiaires where prenoms like "%m"; 
#Q5
select * from stagiaires where prenoms like "%m" or prenoms like "%d"; 
#Q6
select * from stagiaires where prenoms like "%m" and noms like "%i"; 
#Q7
select * from stagiaires where  noms like "_a%"; 


#LES FONCTIONS D'AGREGAT
#Execice D'Application

#MIN,MAX,AVG

#Q1
select min(Date) as derniere_note from examens;
#Q2
select avg(Note) as moyenne from passerexamen where NumE='E01';
#Q3
select max(Note) as premiere_note from passerexamen where NumS='S02';
#Q4
select min(Note) as derniere_note from passerexamen where NumE='E03';
#Q5
select avg(Note) as moyenne from passerexamen where NumS='S02';
#Q6
select min(Note) as derniere_note,max(Note) as premiere_note from passerexamen where NumE='E05';
#Q7
select max(Note)-min(Note) as ecart from passerexamen where  NumE='E01';

#COUNT, SUM

#Q1
select count(*) from examens where TypeE='P';
#Q2
select count(*) from stagiaires where Noms like '%b%' or Noms like '%s%';
#Q3
select count(*) from examens where Salle='B5';
#Q4
select count(NumE) from examens where Salle like 'A%';
#Q5
select count(distinct Salle) from examens where TypE='P';
#Q6
select count(*) from stagiaires where Tel is null;

#Utilisation de la clause GROUP BY :
select NumE,max(Note) from PasserExamen group by NumE;
select Salle,count(*) from Examens where TypeE='P' group by Salle;

#Ex d'application
#Q1
select NumE,max(Note),min(Note) from PasserExamen
group by NumE;
#Q2
select NumE,max(Note)-min(Note) as ecart from PasserExamen
group by NumE;
#Q3
select NumS,max(Note) from PasserExamen 
group by NumS;
#Q4
select Date,count(*) from Examens
group by Date;
#Q5
select Salle,count(*) from Examens
where Salle like 'A%'
group by Salle;
#Q6
select NumE,avg(Note) as moyenne from PasserExamen
group by NumE
order by avg(Note);
#Utilisation de la clause HAVING :
select Salle,count(NumE) from Examens
group by Salle
having count(NumE)>=2;
#Ex d'application
#Q1
select Salle,count(NumE) from Examens
group by Salle
having count(Salle)=3;
#Q2
select Salle,count(NumE) from Examens
where Salle like 'A%'
group by Salle
having count(Salle)=2;
#Q3
select Salle from Examens
where TypeE='P'
group by Salle
having count(NumE)>2;
#Q4
select Salle from Examens
where Salle like'A%' and TypeE='T'
group by Salle
having count(NumE) between 1 and 2;
#Q5
select NumS,avg(Note) as moyenne from PasserExamen
group by NumS
having moyenne>10;
#Q6
select NumS,avg(Note) as moyenne from PasserExamen
group by NumS
having moyenne between 13 and 20;
#Q7
select NumS,count(NumE) from PasserExamen
group by NumS
having count(NumE)=1;
#Q8
select NumE,count(NumS) as nbr_stagiaires from PasserExamen
group by NumE
having nbr_stagiaires>3;

#les sous requets
select NumS as numero_stagiaire from PasserExamen
where note=(select max(note) from passerexamen);

select distinct NumS as numero_stagiaire from passerexamen
where NumE='E02' and note>(select avg(note) from passerexamen where NumE='E02');

select distinct salle,count(NumE) as nbr_examens from examens
group by salle
having count(NumE)>=All(select count(NumE) from examens group by salle);

select NumS,avg(note) from passerexamen
group by NumS
having avg(note)<=All(select avg(note) from passerexamen group by NumE);

select NumS,avg(note) from passerexamen
group by NumS
having avg(note)<=Any(select avg(note) from passerexamen group by NumE);

select NomS from stagiaires where NumS in (select NumS from passerexamen where note=(select max(note) from passerexamen));

#LES JOINTURES
#la jointure internne
select * from stagiaires s inner join passerexamen p on (s.NumS=p.NumS);
select s.NomS,s.PrenomS,avg(p.Note) from stagiaires s inner join passerexamen p on (s.NumS=p.NumS) group by s.NumS having avg(Note)>10;
select s.NomS,s.PrenomS,e.Date,p.Note from stagiaires s inner join passerexamen p on(s.NumS=p.NumS) inner join examens e on(e.NumE=p.NumE) where s.NumS='S01';