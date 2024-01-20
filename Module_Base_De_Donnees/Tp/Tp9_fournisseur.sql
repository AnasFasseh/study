create database gestion_produits;
use gestion_produits;
create table Fournisseurs(
	NumF		varchar(3),
	NomF		varchar(30),
	Ville		varchar(30),
	Tel			varchar(12),
	constraint	PK_Fournisseurs primary key (NumF));

create table Produits(
	NumP		varchar(3),
	Libelle	varchar(20),
	Origine		varchar(30),
	Prix		decimal,
	constraint	PK_Produits primary key (NumP));

create table Fournir(
	NumF		varchar(3),
    foreign key (NumF) references Fournisseurs (NumF),
	NumP		varchar(3),
	foreign key (NumP) references Produits (NumP),
	Date		datetime,
	Quantite	int,
	constraint	PK_Fournir primary key (NumF, NumP, Date));

insert into Fournisseurs values ('F01', 'AlHamraa', 'Marrakech', '0524123456')
,('F02', 'Mas3oudi', 'Casablanca', '0522234567')
, ('F03', 'Ste. Tansift', 'Marrakech', NULL)
,('F04', 'KolchiRabh', 'Rabat', '0537456789')
,('F05', 'Casa Expretise', 'Casablanca', NULL)
, ('F06', 'Al Jaberri et Associés', 'Casablanca', '0522678901')
,('F07', 'Lm39ol', 'Casablanca', '0522506078')
, ('F08', 'Najma', 'Tanger', '0513516412')
, ('F09', 'Itrane', 'Tahnaout', '0524707078')
,('F10', 'Al Qortobi & Brothers', 'Tanger', '0522309812')
, ('F11', 'Tom wa Jerry', 'Casablanca', '0522131254');

insert into Produits values ('P01', NULL, 'Marrakech', 120)
, ('P02', 'Argane', 'Agadir', 200)
, ('P03', 'Argane', 'Ouarzazate', 400)
, ('P04', 'Argane', 'Taroudant', 500)
,('P05', 'Olive', 'Marrakech', 250)
, ('P06', 'Dra3ia', 'Marrakech', 100)
, ('P07', 'Dra3ia', 'Fes', 800)
,('P08', 'Olive', 'Agadir', 130)
, ('P09', 'Miel', 'Marrakech', 450)
, ('P10', NULL, 'Marrakech', 50)
,('P11', 'Thé', 'Agadir', 23)
, ('P12', 'Thé', 'Ouarzazate', 23);

insert into Fournir values ('F01', 'P01', '2009-10-12', 100)
,('F01', 'P01', '2009-11-23', 150)
,('F01', 'P01', '2009-03-12', 143)
,('F01', 'P02', '2010-10-07', 25)
,('F01', 'P02', '2010-12-17', 50)
,('F01', 'P03', '2009-11-21', 72)
,('F01', 'P04', '2009-12-02', 89)
,('F01', 'P05', '2009-02-01', 200)
,('F01', 'P05', '2009-04-18', 120)
,('F01', 'P06', '2010-04-13', 23)
,('F01', 'P07', '2010-05-22', 89)
,('F01', 'P08', '2010-06-02', 72)
,('F02', 'P01', '2008-10-08', 113)
,('F02', 'P01', '2008-10-19', 16)
,('F02', 'P02', '2009-11-12', 55)
,('F02', 'P03', '2010-05-21', 17)
,('F02', 'P04', '2010-01-23', 89)
,('F02', 'P05', '2010-02-17', 20)
,('F02', 'P06', '2010-12-31', 20)
,('F02', 'P06', '2009-11-03', 20)
,('F02', 'P06', '2009-11-05', 20)
,('F02', 'P06', '2008-10-08', 20)
,('F02', 'P08', '2008-04-14', 112)
,('F04', 'P01', '2008-10-08', 125)
,('F04', 'P02', '2008-10-08', 225)
,('F04', 'P02', '2010-05-13', 500)
,('F04', 'P03', '2010-05-21', 70)
,('F04', 'P04', '2009-11-05', 8)
,('F04', 'P05', '2010-02-17', 20)
,('F04', 'P06', '2008-10-08', 2)
,('F04', 'P06', '2009-11-03', 13)
,('F04', 'P07', '2010-11-21', 90)
,('F04', 'P08', '2008-04-14', 172)
,('F04', 'P09', '2009-11-07', 160)
,('F04', 'P09', '2009-01-16', 64)
,('F06', 'P02', '2011-01-01', 16)
,('F06', 'P02', '2010-01-23', 164)
,('F06', 'P05', '2009-05-24', 37)
,('F06', 'P06', '2010-01-23', 22)
,('F06', 'P11', '2009-08-15', 230)
,('F07', 'P05', '2009-03-31', 21)
,('F07', 'P05', '2010-02-27', 15)
,('F08', 'P06', '2008-12-12', 81)
,('F09', 'P06', '2010-09-23', 100)
,('F10', 'P02', '2009-08-17', 202)
,('F10', 'P02', '2010-02-27', 12)
,('F10', 'P03', '2008-06-04', 99)
,('F10', 'P04', '2007-09-13', 123);

#Tp9 :Les jointures
#Q1
select distinct f1.NumF,f1.NomF,f1.Ville,f1.Tel from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f1.NumF=f2.NumF;
#Q2
select f1.NumF,f1.NomF,f1.Ville,f1.Tel from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f2.NumF is null;
#Q3
select distinct p.NumP,p.Libelle,p.Origine,p.Prix from Produits p left join Fournir f2 on (p.NumP=f2.NumP) where p.NumP=f2.NumP;
#Q4
select p.NumP,p.Libelle,p.Origine,p.Prix from Produits p left join Fournir f2 on (p.NumP=f2.NumP) where f2.NumP is null;
#Q5
select distinct f1.NumF,f1.NomF,f1.Ville,f1.Tel from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f2.Date between '2008-03-01' and '2009-12-27';
#Q6
select distinct f1.NumF,f1.NomF,f1.Ville,f1.Tel from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f1.NumF=f2.NumF and f2.Quantite >=200;
#Q7
select distinct f1.NumF,f1.NomF,f1.Ville,f1.Tel from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f2.NumP in ('P01','P02') order by f1.NumF desc;
#Q8
select f1.NumF,f1.NomF,f1.Ville,f1.Tel,f2.Date,f2.Quantite,p.NumP,p.Libelle,p.Origine,p.Prix from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF)
left join Produits p on (f2.NumP=p.NumP) where f1.NumF=f2.NumF group by f1.NumF;
#Q9
select f1.NumF,f1.NomF,f1.Ville,f1.Tel,f2.Date,f2.Quantite,p.NumP,p.Libelle from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF)
left join Produits p on (f2.NumP=p.NumP) where f1.NumF=f2.NumF and p.Libelle='Dra3ia';
#Q10
select f1.NumF,f1.NomF,f1.Ville,f1.Tel,f2.Date,f2.Quantite,p.NumP,p.Libelle,p.Origine,p.Prix from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF)
left join Produits p on (f2.NumP=p.NumP) where f1.NumF=f2.NumF and (p.Libelle='Argane' or p.Libelle='Olive');
#Q11
select f1.NumF,f1.NomF,f1.Ville,f1.Tel,count(f2.NumF) from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f1.NumF=f2.NumF group by f1.NumF order by count(f2.NumF);
#Q12
select f1.NumF,f1.NomF,f1.Ville,f1.Tel,count(f2.NumF) from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF) where f1.NumF=f2.NumF and year(f2.Date)='2009' group by f1.NumF having count(f2.NumF)>=7;
#Q13 faux
select f1.NumF,f1.NomF,f1.Ville,f1.Tel,p.NumP,p.Libelle,p.Origine,p.Prix,count(f2.NumF) from Fournisseurs f1 left join Fournir f2 on (f1.NumF=f2.NumF)
left join Produits p on (f2.NumP=p.NumP) where f1.NumF=f2.NumF group by p.NumP;
#Q14
select p.NumP,p.Libelle,p.Origine,p.Prix,count(f2.NumF) from Produits p left join Fournir f2 on (p.NumP=f2.NumP) where p.NumP=f2.NumP group by p.NumP having count(f2.NumF)>=2;
#Q15 faux
select NumP,Libelle,Origine,Prix,max(Prix) from Produits group by NumP having Prix>=max(Prix);
#Q16 faux

#Bonnus
select f1.*,count(f2.NumP) from Fournisseurs f1 inner join Fournir f2 on (f1.NumF=f2.NumF) group by f2.NumF having count(f2.NumF)<=all(select count(NumP) from Fournir group by NumF);
select f.*,sum(p.Prix*fr.Quantite) from Fournisseurs f inner join Fournir fr on (f.NumF=fr.NumF) inner join Produits p on (p.NumP=fr.NumP) group by fr.NumF having sum(p.Prix*fr.Quantite)>=all(select sum(p1.Prix*fr1.Quantite) from  Fournir fr1 inner join Produits p1 on(p1.NumP=fr1.NumP) group by fr1.NumF);