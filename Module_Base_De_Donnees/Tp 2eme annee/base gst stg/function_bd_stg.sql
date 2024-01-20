use gestion_stg;
DELIMITER ??
drop function if exists moyenNote;
create function moyenNote (num varchar(3))
returns int
reads sql data
begin
declare moyN int;
set moyN = (select avg(Note) from PasserExamen where numS = num );
return moyN;
end ??
DELIMITER ;

DELIMITER ??
drop function if exists moyenNombre;
create function moyenNombre ()
returns int
reads sql data
begin
declare moyS int;
set moyS = (select avg(NumS) from Stagiaires);
return moyS;
end ??
DELIMITER ;

DELIMITER ??
drop function if exists note;
create function note (s varchar(3),e varchar(3))
returns float
reads sql data
begin
declare n float;
set n = (select Note from PasserExamen where (NumS = s and NumE = e));
return n;
end ??
DELIMITER ;
select moyenNote('S01');
select moyenNombre();
select note('S01','E01');

drop function if exists mention_stg;
DELIMITER //
create function mention_stg (moy float)
returns varchar(10)
reads sql data
begin
if moy >= 10 and moy <= 12 then
	return 'passable';
elseif moy <= 14 then
	return 'Assez Bien';
elseif moy <= 16 then
	return 'Bien';
elseif moy <= 18 then
	return 'Tres Bien';
else
	return 'Excellent';
end if;
end //
DELIMITER ;
select mention_stg (18);

drop procedure if exists sp_moyenne_stg;
DELIMITER //
create procedure sp_moyenne_stg (IN stg varchar(10))
begin
declare moy float;
set moy = (select avg(Note) from PasserExamen where NumS = stg);
select moy, mention_stg(moy);
end //
DELIMITER ;

call sp_moyenne_stg ('S01');

DELIMITER //
create function jour_num (num int)
returns varchar(20)
reads sql data
begin
declare jour varchar(20);
case num
when 1 then set jour = 'Lundi';
when 2 then set jour = 'Mardi';
when 3 then set jour = 'Mercredi';
when 4 then set jour = 'Jeudi';
when 5 then set jour = 'Vendredi';
when 6 then set jour = 'Samedi';
when 7 then set jour = 'Dimanche';
end case;
return jour;
end //
DELIMITER ;
select jour_num(3);

