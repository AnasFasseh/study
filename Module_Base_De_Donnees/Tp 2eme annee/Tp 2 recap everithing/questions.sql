#7
drop procedure if exists sp_DetailsSociete;
delimiter //
create procedure sp_q7()
begin
	select s.raison_sociale as nom_societe , s.ville , s.capital , e.nom as directeur ,count(e.matricule) as nbre_emps, count(v.num_vendeur) as nbre_vendeurs 
    from employe e 
    inner join societe s on(e.num_s = s.num_s) 
    inner join piece p on(p.num_s = s.num_s) 
    inner join vente v on(v.num_piece = p.num_piece) where e.fonction = 'directeur';
end //
delimiter ;

#8
drop procedure if exists sp_q8;
delimiter //
CREATE PROCEDURE DetailsEmploye(IN societe_id INT)
BEGIN
    SELECT e.matricule, e.nom, e.salaire_fixe,
        COUNT(v.num_pièce) AS Nombre_pieces_vendues
    FROM Employé e
    LEFT JOIN VENTE v ON e.matricule = v.num_vendeur
    WHERE e.num_s = societe_id
    GROUP BY e.matricule;
END //
delimiter ;

#9
drop trigger if exists tr_q9;
delimiter //
create trigger tr_q9 after delete on vente for each row
CREATE TRIGGER sp_MiseAJour
AFTER DELETE ON VENTE
FOR EACH ROW
BEGIN
    UPDATE PIÈCE
    SET quantité_stockée = quantité_stockée + OLD.quantité
    WHERE num_pièce = OLD.num_pièce;
END //
delimiter ;

#10
drop trigger if exists tr_q10_1;
delimiter //
CREATE TRIGGER VerifierQuantiteDisponible
BEFORE INSERT ON VENTE
FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;
    SELECT quantité_stockée INTO stock_disponible
    FROM PIÈCE
    WHERE num_pièce = NEW.num_pièce;

    IF NEW.quantité > stock_disponible THEN
        SIGNAL SQLSTATE '50004'
        SET MESSAGE_TEXT = 'Quantité demandée non disponible';
    END IF;
END //

CREATE TRIGGER MettreAJourStockApresVente
AFTER INSERT ON VENTE
FOR EACH ROW
BEGIN
    UPDATE PIÈCE
    SET quantité_stockée = quantité_stockée - NEW.quantité
    WHERE num_pièce = NEW.num_pièce;
END //
delimiter ;

#11
drop trigger if exists tr_q11;
delimiter //
CREATE TRIGGER VerifierSalaireFonction
BEFORE INSERT OR UPDATE ON Employé
FOR EACH ROW
BEGIN
    DECLARE salaire_min, salaire_max float;
    SELECT SalaireMin, SalaireMax INTO salaire_min, salaire_max
    FROM Fonction
    WHERE Intitule = NEW.fonction;

    IF NEW.salaire_fixe < salaire_min OR NEW.salaire_fixe > salaire_max THEN
        SIGNAL SQLSTATE '50004'
        SET MESSAGE_TEXT = 'Le salaire ne correspond pas à la fonction';
    END IF;
END //
delimiter ;


#12
drop trigger if exists tr_q11;
delimiter //
CREATE TRIGGER sp_VendeurSocieteProjet
BEFORE INSERT ON VENTE
FOR EACH ROW
BEGIN
    DECLARE projet_societe INT;
    DECLARE vendeur_societe INT;

    -- Récupération de la société du projet
    SELECT num_s INTO projet_societe
    FROM PROJET
    WHERE num_projet = NEW.num_projet;

    -- Récupération de la société du vendeur
    SELECT num_s INTO vendeur_societe
    FROM Employé
    WHERE matricule = NEW.num_vendeur;

    -- Vérification et levée d'exception si les sociétés ne correspondent pas
    IF projet_societe != vendeur_societe THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Le vendeur n\'appartient pas à la même société que le projet.';
    END IF;
END //
delimiter ;
