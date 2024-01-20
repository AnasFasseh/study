create database gst_projet;
use gst_projet;
-- Création des tables

CREATE TABLE Societe (
    num_s INT PRIMARY KEY,
    raison_sociale VARCHAR(255),
    ville VARCHAR(255),
    surface float,
    capital float
);

CREATE TABLE PIECE (
    num_piece INT PRIMARY KEY,
    designation VARCHAR(255),
    poids float,
    num_s INT,
    prix_unitaire float,
    quantite_stockee INT,
    FOREIGN KEY (num_s) REFERENCES Societe(num_s)
);

CREATE TABLE PROJET (
    num_projet INT PRIMARY KEY,
    designation VARCHAR(255),
    num_s INT,
    budget float,
    FOREIGN KEY (num_s) REFERENCES Societe(num_s)
);

CREATE TABLE VENTE (
    num_vente INT PRIMARY KEY,
    num_vendeur INT,
    num_piece INT,
    num_projet INT,
    quantite INT,
    date_vente DATE,
    FOREIGN KEY (num_piece) REFERENCES PIECE(num_piece),
    FOREIGN KEY (num_projet) REFERENCES PROJET(num_projet)
);

CREATE TABLE Employe (
    matricule INT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    ville VARCHAR(255),
    num_s INT,
    salaire_fixe float,
    commission float,
    date_naissance DATE,
    date_embauche DATE,
    fonction VARCHAR(255),
    FOREIGN KEY (num_s) REFERENCES Societe(num_s)
);

CREATE TABLE Fonction (
    Intitule VARCHAR(255) PRIMARY KEY,
    SalaireMin float,
    SalaireMax float,
    NbHeures INT
);



-- Insertions dans la table Societe
INSERT INTO Societe VALUES
(1, 'Entreprise A', 'VilleA', 1000.00, 100000.00),
(2, 'Entreprise B', 'VilleB', 800.50, 75000.25),
(3, 'Entreprise C', 'VilleC', 1200.75, 120000.50);

-- Insertions dans la table PIECE
INSERT INTO PIECE VALUES
(101, 'PièceA', 2.50, 1, 15.00, 200),
(102, 'PièceB', 1.80, 2, 12.50, 150),
(103, 'PièceC', 3.00, 3, 18.75, 180);

-- Insertions dans la table PROJET
INSERT INTO PROJET VALUES
(1, 'ProjetX', 1, 100000.00),
(2, 'ProjetY', 2, 80000.50),
(3, 'ProjetZ', 3, 120000.75);

-- Insertions dans la table VENTE
INSERT INTO VENTE VALUES
(1001, 102, 101, 1, 20, '2021-05-20'),
(1002, 103, 102, 2, 15, '2021-07-10'),
(1003, 101, 103, 3, 18, '2021-09-05');

-- Insertions dans la table Employe
INSERT INTO Employe VALUES
(101, 'Dupont', 'Jean', 'VilleA', 1, 60000.00, 0.10, '1990-05-15', '2020-01-02', 'Manager'),
(102, 'Martin', 'Alice', 'VilleB', 2, 40000.00, 0.08, '1985-08-20', '2018-06-12', 'Vendeur'),
(103, 'Durand', 'Paul', 'VilleC', 3, 45000.00, 0.12, '1988-12-10', '2019-03-25', 'Technicien');

-- Insertions dans la table Fonction
INSERT INTO Fonction VALUES
('Manager', 50000.00, 80000.00, 40),
('Vendeur', 30000.00, 50000.00, 35),
('Technicien', 35000.00, 60000.00, 38);

# Q2
drop function if exists montant;
delimiter //
create function montant () returns varchar(500) reads sql data
begin
	declare not_exist int default false;
	declare mont float default 0;
    declare projet int;
    declare qte int;
    declare prix float;
    declare msg varchar(500) default "";
    declare c1 cursor for (select p.prix_unitaire , v.quantite , v.num_projet from vente v inner join piece p on (v.num_piece = p.num_piece));
    declare continue handler for not found set not_exist = true;
    open c1;
		parcour : loop
			fetch c1 into prix , qte , projet;
            if not_exist = true then
				leave parcour;
			end if;
            set mont = mont + (prix * qte);
            set msg = concat(msg , ' Num Projet : ', projet , " Montant : " , mont , '||');
		end loop;
    close c1;
    return msg;
end //
delimiter ;

select montant();

# Q3
drop function if exists salaire_net;
delimiter //
create function salaire_net (emp int) returns float reads sql data
begin
declare fct varchar(20);
declare sal float;
set fct = (select fonction from Employe where matricule = emp);
if fct = 'vendeur' then
	set sal = (select salaire_fixe + commission from Employe where matricule = emp);
else
	set sal = (select salaire_fixe from Employe where matricule = emp);
end if;
return sal;
end //
delimiter ;
select salaire_net (101);

# Q4
drop function if exists matricule;
delimiter //
create function matricule (soc int) returns int reads sql data
begin
declare mat int;
set mat = (select e.matricule from Employe e inner join piece p on (e.num_s = p.num_s) inner join vente v on (p.num_piece = v.num_piece) where p.num_s = soc group by e.matricule having sum(p.prix_unitaire * v.quantite) >= ALL(select sum(p.prix_unitaire * v.quantite) from vente v inner join piece p on (p.num_piece = v.num_piece)));
return mat;
end //
delimiter ;
select matricule (1);

# Q5
drop procedure if exists sp_list_emp;
delimiter //
create procedure sp_list_emp ()
begin
select * from Employe where datediff(curdate(), date_naissance) >= (60 * 365) or (datediff(curdate(), date_naissance) >= (50 * 365) and datediff(curdate(), date_embauche) >= (30 * 365));
end //
delimiter ;
call sp_list_emp ();

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
    INNER JOIN VENTE v ON e.matricule = v.num_vendeur
    WHERE e.num_s = societe_id
    GROUP BY e.matricule;
END;
delimiter ;

#9
drop trigger if exists trigger9;
delimiter //
create trigger trigger9 after delete on vente for each row
CREATE TRIGGER sp_MiseAJour
AFTER DELETE ON VENTE
FOR EACH ROW
BEGIN
    UPDATE PIÈCE
    SET quantité_stockée = quantité_stockée + OLD.quantité
    WHERE num_pièce = OLD.num_pièce;
END;
delimiter ;

#10
drop trigger if exists VerQteDisponible;
delimiter //
CREATE TRIGGER VerQteDisponible
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
END;

CREATE TRIGGER JourStockApresVente
AFTER INSERT ON VENTE
FOR EACH ROW
BEGIN
    UPDATE PIÈCE
    SET quantité_stockée = quantité_stockée - NEW.quantité
    WHERE num_pièce = NEW.num_pièce;
END;
delimiter ;

#11
drop trigger if exists VerSalFonc;
delimiter //
CREATE TRIGGER VerSalFonc
BEFORE INSERT OR UPDATE ON Employe
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
END;
delimiter ;


#12
drop trigger if exists VendSocPro;
delimiter //
CREATE TRIGGER VendSocPro
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
        SIGNAL SQLSTATE '50004'
        SET MESSAGE_TEXT = 'Le vendeur n\'appartient pas à la même société que le projet.';
    END IF;
END;
delimiter ;