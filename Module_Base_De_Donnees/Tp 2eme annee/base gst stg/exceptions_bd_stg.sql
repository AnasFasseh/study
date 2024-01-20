DELIMITER //
create procedure insert_stg (IN num varchar(3), IN nom varchar(10), IN pre varchar(20), IN tel varchar(10))
begin
DECLARE is_null boolean default false;
begin
DECLARE Exit HANDLER FOR 1062 SET in_null = TRUE;
insert into stagieaires values (num, nom, pre, tel);
select 'Ajout avec succes' as Message;
select * from stagiaires;
end;
if in_null = TRUE then
select 'Le champ Id ne doit pas etre null' as ErrorMessage;
end if;
end //
DELIMITER ;
call insert_stg (null, 'anas', 'jhq', '0201040506');



DELIMITER //
create procedure insert_stg (IN num varchar(3), IN nom varchar(10), IN pre varchar(20), IN tel varchar(10))
begin
DECLARE duplicate boolean default false;
begin
DECLARE Exit HANDLER FOR SQLSTATE '23000' SET duplicate = TRUE;
insert into stagiaires values (num, nom, pre, tel);
select 'Ajout avec succes' as Message;
select * from stagiaires;
end;
if duplicate = TRUE THEN
	select 'Le champ ID doit etre unique';
end if;
end //
DELIMITER ;
call insert_stg ('1', 'anas', 'jhq', '0201040506');



DELIMITER //
create procedure autreError()
begin
select 'Une autre error survenue';
end //
DELIMITER ;

DELIMITER //
create procedure insert_stg (IN num varchar(3), IN nom varchar(10), IN pre varchar(20), IN tel varchar(10))
begin
DECLARE duplicate boolean default false;
begin
DECLARE Exit HANDLER FOR SQLSEXCEPTION CALL autreError();
insert into stagiaires values (num, nom, pre, tel);
select 'Ajout avec succes' as Message;
select * from stagiaires;
end //
DELIMITER ;
call insert_stg ('15', '', 'tel');


DELIMITER //
create procedure rechercher_stg (IN stg varchar(3))
begin
declare exist boolean default true;
begin
declare exit handler for not found set exist = false;
select * from stagiaires where numS = stg;
end;
if exist = false then
	select 'Ce stagiaire n existe pas';
end if;
end //
DELIMITER ;
call rechercher_stg ('100');


DELIMITER //
create procedure ajouter_note (IN num varchar(3), IN exam varchar(3), IN note_stg float)
begin
if note_stg > 20 or note_stg < 0 then
	signal SQLSTATE '45000' SET MESSAGE_TEXT = 'non valide';
else
	insert into passerExamen values (num, exam, note_stg);
end if;
end //
DELIMITER ;
call ajouter_note ('1', '1', 21);