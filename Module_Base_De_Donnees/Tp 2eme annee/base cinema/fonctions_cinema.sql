use cinema;
drop function if exists noms_acteurs;
DELIMITER //
create function noms_acteurs (film int)
returns varchar(50)
reads sql data
begin
DECLARE not_exist boolean default false;
DECLARE n varchar(20);
DECLARE msg varchar(50) default "";
DECLARE C1 CURSOR FOR SELECT a.nom from acteur a inner join jouer j on (a.idA = j.idA) inner join film f on (j.idF = f.idF) where f.idF = film;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET not_exist = true;
open C1;
boucle : loop
fetch C1 into n;
if not_exist = true then
	leave boucle;
end if;
set msg = concat(msg, ", ", n);
end loop boucle;
close C1;
return msg;
end //
DELIMITER ;
select noms_acteurs(1);