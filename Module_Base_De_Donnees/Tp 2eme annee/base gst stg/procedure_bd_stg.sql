use gestion_stg;

DELIMITER ??
# liste des stagiaires avec leur note dans un examen donne

create procedure sp_list_stg (IN exam varchar(3))
begin
select s.*, p.Note from stagiaires s inner join passerexamen p on (s.NumS = p.NumS) where p.numE = exam;
end ??
DELIMITER ;
# l'appel de procedure

call sp_list_stg ('E01');

DELIMITER ??
# le nombre de stagiares qui ont passe un examen donne

create procedure sp_nombre_stg (IN exam varchar(3), OUT nbr_stg int)
begin
select count(NumS) into nbr_stg from passerexamen where NumE = exam;
end ??
DELIMITER ;
# l'appel de procedure
call sp_nombre_stg ('E01', @nbr);
select @nbr;

DELIMITER ??
drop procedure if exists sp_moy_max_min;
create procedure sp_moy_max_min (IN stg varchar(3), OUT moy int, OUT maxe int, OUT mine int)
begin
select avg(Note) , max(Note) , min(Note) into moy, maxe, mine from PasserExamen where NumS = stg;
end ??
DELIMITER ;

call sp_moy_max_min('S01', @moy, @max, @min);
select @moy, @max, @min;

drop procedure if exists mention_stg;
DELIMITER //
create procedure mention_stg ()
begin
select s.NomS, avg(p.Note),
case
when avg(p.Note) >= 18 then 'Excellent'
when avg(p.Note) >= 16 then 'Tres Bien'
when avg(p.Note) >= 14 then 'Bien'
when avg(p.Note) >= 12 then 'Assez Bien'
when avg(p.Note) >= 10 then 'passable'
when avg(p.Note) >= 9.75 then 'rachete'
else 'Non Admis'
end as 'Mention'
from stagiaires s inner join passerexamen p on (s.NumS = p.NumS) group by s.nums;
end //
DELIMITER ;
call mention_stg ();
