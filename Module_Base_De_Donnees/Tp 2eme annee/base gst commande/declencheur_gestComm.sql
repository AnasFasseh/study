use GestionCom;
drop trigger if exists second_trigger;
DELIMITER //
CREATE TRIGGER second_trigger AFTER INSERT
ON LigneCommande
FOR EACH ROW
BEGIN
declare qtestq int default (select QteEnStock from article where NumArt = new.NumArt);
if qtestq > new.QteCommandee then
	update article set QteEnStock = QteEnStock - new.QteCommandee where NumArt = new.NumArt;
else
	signal sqlstate '50001' set message_text = 'Rupture de stock';
end if;
END //
DELIMITER ;
insert into LigneCommande values ('C01', 'A03', 6);
select * from article;
