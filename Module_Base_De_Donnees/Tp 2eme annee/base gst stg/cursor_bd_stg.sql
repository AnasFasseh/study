use gestion_stg;
DELIMITER //
drop procedure if exists sp_lister_stgV1;
create procedure sp_lister_stgV1 ()
BEGIN
DECLARE finished boolean default false;
DECLARE num varchar(20);
DECLARE nom varchar(20);
DECLARE prenom varchar(20);
DECLARE info varchar(200) default "";
DECLARE CURSOR C1 FOR SELECT numS, nomS, prenomS from stagiaires
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = true;
OPEN C1;
boucle : Loop
FETCH C1 INTO num, nom, prenom;
if finished = true then
	Leave boucle
end if;
SET info = CONCAT(num, '-', '-', nom, '-', prenom)
select info;
END LOOP boucle;
CLOSE C1;
END //
DELIMITER ;
call lister_stgV1 ();


DELIMITER //
drop procedure if exists sp_moyenne;
create procedure sp_moyenne (IN stg varchar(3))
BEGIN
DECLARE not_exist boolean default false;
DECLARE nom varchar(10);
DECLARE prenom varchar(10);
DECLARE counter int default 0;
DECLARE somme float default 0;
DECLARE notes float;
DECLARE message varchar(50);
DECLARE C2 CURSOR FOR SELECT nomS, prenomS, note from stagiaires s inner join passerExamen p on (s.numS = p.numS) where s.numS = stg;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET not_exist = true;
OPEN C2;
boucle : LOOP
FETCH C2 INTO nom, prenom, notes
if not_exist= true then
	LEAVE boucle
end if;
set counter = counter + 1;
set somme = somme + notes;
END LOOP boucle;
set message = CONCAT("La moyenne de ", nom, " ", prenom, " est", somme / conuter);
select message;
CLOSE C2;
END //
DELIMITER ;
call moyenne ('S01');

drop procedure if exists sp_modifier_notes;
DELIMITER //
create procedure sp_modifier_notes (IN exam varchar(10))
begin
DECLARE	n float;
DECLARE not_exist boolean default false; 
DECLARE C3 CURSOR FOR select note from passerexamen where numE = exam for update;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET not_exist = true;
open C3;
boucle : loop
fetch C3 into n;
if not_exist = true then
	leave boucle;
end if;
if n > 9.75 and n < 10 then
	update passerexamen set note = note + 0.25 where numE = exam;
end if;
end loop boucle;
close C3;
end //
DELIMITER ;
call sp_modifier_notes ('E01');