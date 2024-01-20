use cinema;
drop procedure if exists sp_nationalite;
DELIMITER //
create procedure sp_nationalite ()
begin
DECLARE msg varchar(100) default "";
DECLARE nat varchar(20);
DECLARE act int;
DECLARE reals int;
DECLARE nbr_act int default 0;
DECLARE nbr_real int default 0;
DECLARE not_exist boolean default false;
DECLARE C1 CURSOR FOR SELECT nationalite from acteur union select nationalite from realisateur;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET not_exist = true;
boucle : loop
fetch C1 into nat;
if not_exist = true then
	leave boucle1;
end if;
set nbr_act = (select count(idA) from acteur where nationalite = nat);
set nbr_real = (select count(idA) from realisateur where nationalite = nat);
set msg = concat(msg, nat,", Nbr_Act: ", nbr_act, ", Nbr_Real: ", nbr_real);
end loop boucle;
select msg;
close C1;
end //
DELIMITER ;