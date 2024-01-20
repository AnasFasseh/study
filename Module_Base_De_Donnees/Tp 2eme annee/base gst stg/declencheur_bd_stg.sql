use gestion_stg;
drop trigger if exists first_trigger;
DELIMITER //
CREATE TRIGGER first_trigger BEFORE INSERT
ON passerexamen
FOR EACH ROW
BEGIN
if New.note < 0 or New.note > 20 then
	signal sqlstate '50001' set message_text = 'la note doit etre entre 0 et 20';
end if;
END //
DELIMITER ;
insert into passerexamen values ('111', '222', 50.2);