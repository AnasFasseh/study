create database gestion_stg;
use gestion_stg;

-- Création des tables :

create table Stagiaires(
	NumS		varchar(3),
	NomS		varchar(30),
	PrenomS		varchar(30),
	Tel			varchar(10),
	primary key (NumS));
    
# Index
drop index index_tel on Stagiaires;
create unique index index_tel on Stagiaires (tel);
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