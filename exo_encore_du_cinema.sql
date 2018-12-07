CREATE DATABASE IF NOT EXISTS encore_du_cinema;
USE encore_du_cinema;

-- Création des tables 

CREATE TABLE film (
id_film MEDIUMINT(9) NOT NULL,
titre VARCHAR (50) NOT NULL,
metteur_en_scene VARCHAR(50),
acteur VARCHAR(50),
CONSTRAINT id_film PRIMARY KEY(id_film),
KEY `titre_idx` (`titre`)
);

CREATE TABLE salle (
id_salle MEDIUMINT(9) NOT NULL,
nom_cine VARCHAR(50) NOT NULL,
adresse VARCHAR(50),
telephone VARCHAR(15),
CONSTRAINT pk_id_salle PRIMARY KEY(id_salle),
KEY `nom_cine_idx` (`nom_cine`)
);

CREATE TABLE programme (
id_programme MEDIUMINT(9) NOT NULL,
nom_cine VARCHAR(50) NOT NULL,
titre VARCHAR(50) NOT NULL,
horaire TIME, 
CONSTRAINT pk_id_programme PRIMARY KEY(id_programme),
KEY `fk_programme_nom_cine_idx` (`nom_cine`),
KEY `fk_programme_titre_idx` (`titre`),
CONSTRAINT fk_programme_nom_cine FOREIGN KEY(nom_cine) REFERENCES salle (nom_cine),
CONSTRAINT fk_programme_titre FOREIGN KEY(titre) REFERENCES film (titre)
);

-- Importation des données

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_encore_du_cinema/film.csv' 
INTO TABLE film
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_encore_du_cinema/salle.csv' 
INTO TABLE salle
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_encore_du_cinema/programme.csv' 
INTO TABLE programme
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

USE encore_du_cinema;

-- Questions

-- Question a
SELECT * 
FROM film AS f, programme AS p, salle
WHERE f.titre = 'Speed 2' AND f.titre = p.titre;

-- Question b
SELECT * 
FROM programme 
WHERE titre = 'Eyes wide shut ' 
AND horaire > '14:00:00';

-- Question c 
SELECT *
FROM film
WHERE acteur = metteur_en_scene;

-- Question d
SELECT * 
FROM programme 
WHERE titre = 'Marion' 
OR nom_cine = 'Diagonal Centre';

-- Question e 
SELECT f.titre, f.acteur, p.nom_cine, p.horaire
FROM film AS f
INNER JOIN programme AS p ON f.titre = p.titre
WHERE acteur = 'MF Pisier';

-- Question f 
SELECT f.titre, f.acteur, f.metteur_en_scene
FROM film AS f 
WHERE f.acteur = f.metteur_en_scene;

-- Question g
SELECT titre, metteur_en_scene
FROM film 
GROUP BY titre
HAVING COUNT(DISTINCT metteur_en_scene) >= 2;

-- Question h
SELECT  acteur, metteur_en_scene
FROM film 
WHERE titre = 'Marion';