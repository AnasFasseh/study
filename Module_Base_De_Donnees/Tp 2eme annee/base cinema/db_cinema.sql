create database  cinema;
use cinema;

create table acteur(
	idA int primary key,
    nom varchar(50),
    prenom varchar(50),
    nationalite varchar(50)
);

# Index
# Syntax 1
alter table acteur add index index_nom(nom);
# Syntax 2
create table acteur(
	idA int primary key,
    nom varchar(50),
    prenom varchar(50),
    nationalite varchar(50),
	index(nom)
);
# Syntax 3
create index index_nom on acteur (nom);
create table realisateur(
	idR int primary key,
    nom varchar(50),
    prenom varchar(50),
    nationalite varchar(50)
);

create table genre(
	idG int primary key,
    descprition varchar(50)
);

create table film(
	idF int primary key,
    titre varchar(20),
    annee varchar(4),
    pays varchar(20),
    nbrspectateurs int check(nbrspectateurs>0),
    idG int ,
    idR int ,
    constraint fk1_film foreign key (idG) references genre(idG),
    constraint fk2_film foreign key (idR) references realisateur(idR)
);

create table jouer(
	idA int,
    idF int,
    primary key(idA,idF),
    salaire float check(salaire>0),
    constraint fk1_jouer foreign key (idA) references acteur(idA),
    constraint fk2_jouer foreign key (idF) references film(idF)
);
# Index
alter table jouer add index index_id(idF, idA);




select a.* from acteur a inner join jouer j on (a.idA = j.idA) inner join film f on(f.idF = j.idF) inner join genre g on (g.idG = f.idG) where g.descprition = 'comedie' or g.descprition = 'policier';

select f.* from film f inner join realisateur r on(f.idR = r.idR) where r.nom = 'Daroussin' and f.annee >= '2000';

select a.*,r.* from acteur a inner join jouer j on(a.idA = j.idA) inner join film f on(f.idF = j.idF) inner join realisateur r on(f.idR = r.idR) order by r.idR , a.idA;

select g.description from genre g inner join film f on(f.idG = g.idG) inner join jouer j on(f.idF = j.idF) inner join acteur a on(f.idA = a.idA) where a.nom = "Al pacino";

select r.* from realisateur r inner join film f on(r.idR = f.idR) inner join genre g on(g.idG = f.idG) order by f.annee ;

select count(idF) as nbre_films from film;

select distinct annee from film;

select max(salaire),min(salaire),avg(salaire) from jouer;

select max(f.nbrspectateurs),min(f.nbrspectateurs),avg(f.nbrspectateurs) from film f inner join genre g on(f.idG = g.idG) where g.description = 'comedie';

select avg(j.salaire)/avg(f.nbrspectateurs) from film f inner join jouer j on(f.idF = j.idF) inner join acteur a on(a.idA = j.idA) where a.nom ="Al pacino";

#augmenter le salaire des acteurs qui ont jouer dans 
update jouer
set salaire = salaire+(salaire*0.05)
where idF in (select f.idF from film f inner join genre g on (f.idG = g.idG) where g.descprition = 'comedie')




#Q1

drop procedure if exists sp_liste
delimiter //
create procedure liste(in film int) 
begin
	select a.* from film f inner join jouer j on(f.idf = j.idf) inner join acteur a on(a.ida = j.ida) where idf = film;
end //
delimiter ;

call sp_liste(1);


#Q2

drop function if exists sp_nbre_acteurs
delimiter //
create procedure nbre_acteurs(in film int , out nbre_acts int , out masse_sal float)
begin
	select count(j.ida),sum(j.salaire) into nbre_acts , masse_sal from acteur a inner join jouer j on(j.ida = a.ida) inner join film f on(j.idf = f.idf) where idf = film;
end //
delimiter ;
call sp_nbre_acteurs(1 , @nbre_acts , @masse_sal);
select @nbre_acts , @masse_sal;

#Q3

drop function if exists sp_liste_film
delimiter //
create procedure sp_liste_film(in ans year , out nbre_films int)
begin
	select * from film where ans = annee;
	select count(idf) into nbre_films from film where ans = annee;
end //
delimiter ;
call sp_liste_film('2000' , @nbre_films);
select @nbre_films;

#Q4

drop function if exists sp_moins_vues
delimiter //
create procedure sp_moins_vues(in type_film varchar(50) , out nbre_specs int)
begin
	select f.* from film f inner join genre g on(f.idg = g.idg) where g.description = type_film and f.nbre_spactateurs = (select min(f.nbre_spactateurs) from film f inner join genre g on(f.idg = g.idg) where g.description = type_film);
    select min(f.nbre_spactateurs) into nbre_sepcs from film f inner join genre g on(f.idg = g.idg) where g.description = type_film;
end //
delimiter ;
call sp_moins_vues('comedie' , @nbre_specs);
select @nbre_spacs ;

#Q5

drop function if exists special;
delimiter //
create function special(film int) returns varchar(10) reads sql data
begin
	declare etat varchar(10);
	if nbre_spectateurs > 10000 then 
		set etat = 'special';
    else
		set etat = 'normal';
	end if;
	return etat;
end //
delimiter ;
select special(1);

# Question 1
create user 'laila'@'localhost' identified by '76345';
create user 'mourad'@'localhost' identified by '98763';
create user 'amina'@'localhost' identified by '2345';

# Qustion 2
create user 'said'@'%' identified by 'vbd2024';
create user 'karim'@'%' identified by 'DER344';
create user 'ahmed'@'%' identified by 'OPU888';
create user 'ali'@'%' identified by 'a5438';

# Question 3

# Said :
grant all privileges on *.* to 'said'@'%';

# Amina :
grant select , insert , update
on cinema.*
to 'amina'@'localhost';

# Karim :
grant select
on cinema.*
to 'karim'@'%';

# Laila :
grant all privileges
on *.*
to 'laila'@'localhost';

#user mourad :
grant select , update , insert , delete
on cinema.acteur
to 'mourad'@'localhost';

#user ahmed :
grant select (titre , nbr_spectateur)
on cinema.film
to 'ahmed'@'%';

#user ali :
grant update (nbr_spectateur)
on cinema.film
to 'ali'@'%';

# Question 4
revoke insert
on cinema.*
from 'laila'@'localhost';

# Gestion des roles

# Q1
create role 'lecteur';

# Q2
grant select on cinema.film to 'lecteur';

# Q3
grant 'lecteur' to 'mourad'@'%';

# Q4
revoke select
on cinema.film
from 'lecteur';

# Q5
drop role 'lecteur' ;