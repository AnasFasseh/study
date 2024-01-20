use GestionCom;
# Q 2
drop trigger if exists interdit_one;
DELIMITER //
create trigger interdit_one before update on Commande
for each row
begin
	signal sqlstate '50000' set message_text = 'interdit de modifier la table commande';
end // 
DELIMITER ;

# Q 3
drop trigger if exists interdit_two;
DELIMITER //
create trigger interdit_two before update on Commande
for each row
begin
	if old.NumCom != new.NumCom then
		signal sqlstate '50000' set message_text = 'interdit de modifier le numero de commande';
	end if;
    if new.DateCom < curdate() then
		signal sqlstate '50000' set message_text = 'la date de commande doit etre superieur ou egale a la date actuelle';
	end if;
end // 
DELIMITER ;

# Q 4
drop trigger if exists interdit_three;
DELIMITER //
create trigger interdit_three before delete on Commande
for each row
begin
if old.NumCom in (select NumCom from LigneCommande) then
	signal sqlstate '50000' set message_text = 'interdit de supprimer';
end if;
end //
DELIMITER ;

# Q 5
drop trigger if exists interdit_four;
DELIMITER //
create trigger interdit_four after delete on LigneCommande for each row
begin
if (select count(numcom) from LigneCommande where numcom = old.numcom) = 0 then
	delete from commande where numcom = old.numcom;
end if;
update article set QteEnStock = QteEnStock + old.QteCommandee where NumArt = old.NumArt;
end //
DELIMITER ;

# Q 6
drop trigger if exists interdit_five;
DELIMITER //
create trigger interdit_five before update on LigneCommande for each row
begin
if new.QteCommandee > (select QteEnStock from article where NumArt = new.NumArt) then
	signal sqlstate '50004' set message_text = 'la quantite commandee indisponible';
elseif new.QteCommandee > old.QteCommandee then
	update article set QteEnStock = QteEnStock - (new.QteCommandee - old.QteCommandee) where NumArt = new.NumArt;
else
	update article set QteEnStock = QteEnStock + (old.QteCommandee - new.QteCommandee) where NumArt = new.NumArt;
end if;
end //
DELIMITER ;