use GestionCom;
# Test les evenements
drop event if exists evenement;
DELIMITER //
create event evenement1
on schedule every 1 second
do
begin
insert into Commande values ('Cev', '2022-08-08');
end //
DELIMITER ;
select * from Commande;

drop event if exists evenement;
DELIMITER //
create event evenement2
on schedule at '2023-10-11 10:18:00'
do
begin
insert into Commande values ('Cev2', '2022-08-08');
end //
DELIMITER ;
select * from Commande;