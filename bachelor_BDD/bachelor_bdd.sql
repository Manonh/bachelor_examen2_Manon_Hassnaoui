/*Création de la base*/
CREATE database bachelor_bdd;

use bachelor_bdd;

/*D'abord création des tables dans le bon ordre*/
DROP TABLE IF EXISTS CLIENT ; 

CREATE TABLE CLIENT (
	id_client BIGINT  AUTO_INCREMENT NOT NULL, 
	nom_client CHAR(30), 
	adresse_client CHAR(30), 
	tel_client CHAR(15), 
	mail_client CHAR(50), 
	PRIMARY KEY (id_client) ) ENGINE=InnoDB; 

DROP TABLE IF EXISTS PROJET ;

CREATE TABLE PROJET (
	id_projet BIGINT  AUTO_INCREMENT NOT NULL,
	nom_projet CHAR(50),
	concept_projet TEXT,
	date_deb_projet DATE, 
	deadline_projet DATE, 
	PRIMARY KEY (id_projet) ) ENGINE=InnoDB; 

DROP TABLE IF EXISTS TACHE ;

CREATE TABLE TACHE (
	id_tache BIGINT  AUTO_INCREMENT NOT NULL, 
	nom_tache CHAR(50), 
	date_deb_tache DATE, 
	deadline_tache DATE, 
	id_projet BIGINT NOT NULL, 
	PRIMARY KEY (id_tache) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS SYNTHESE ; 

CREATE TABLE SYNTHESE (
	id_synthese BIGINT  AUTO_INCREMENT NOT NULL, 
	nom_synthese CHAR(50), 
	note_synthese TEXT, 
	id_projet BIGINT NOT NULL, 
	PRIMARY KEY (id_synthese) ) ENGINE=InnoDB;  

DROP TABLE IF EXISTS UTILISATEUR ;

CREATE TABLE UTILISATEUR (
	id_utilisateur BIGINT  AUTO_INCREMENT NOT NULL, 
	login_utilisateur CHAR(50), 
	mdp_utilisateur CHAR(50), 
	PRIMARY KEY (id_utilisateur) ) ENGINE=InnoDB;  

DROP TABLE IF EXISTS commande ;

CREATE TABLE commande (
	id_client BIGINT  AUTO_INCREMENT NOT NULL, 
	id_projet BIGINT NOT NULL, 
	PRIMARY KEY (id_client,  id_projet) ) ENGINE=InnoDB;  

DROP TABLE IF EXISTS travaille ;

CREATE TABLE travaille (
	id_projet BIGINT  AUTO_INCREMENT NOT NULL, 
	id_utilisateur BIGINT NOT NULL, 
	PRIMARY KEY (id_projet,  id_utilisateur) ) ENGINE=InnoDB;

/*Création des contraintes*/
ALTER TABLE TACHE ADD CONSTRAINT FK_TACHE_id_projet FOREIGN KEY (id_projet) REFERENCES PROJET (id_projet); 
ALTER TABLE SYNTHESE ADD CONSTRAINT FK_SYNTHESE_id_projet FOREIGN KEY (id_projet) REFERENCES PROJET (id_projet); 
ALTER TABLE commande ADD CONSTRAINT FK_commande_id_client FOREIGN KEY (id_client) REFERENCES CLIENT (id_client); 
ALTER TABLE commande ADD CONSTRAINT FK_commande_id_projet FOREIGN KEY (id_projet) REFERENCES PROJET (id_projet); 
ALTER TABLE travaille ADD CONSTRAINT FK_travaille_id_projet FOREIGN KEY (id_projet) REFERENCES PROJET (id_projet); 
ALTER TABLE travaille ADD CONSTRAINT FK_travaille_id_utilisateur FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR (id_utilisateur); 