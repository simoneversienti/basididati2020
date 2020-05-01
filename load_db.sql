CREATE DATABASE if not exists Università;
USE Università;

DROP TABLE IF EXISTS Corso_Laurea;
CREATE TABLE Corso_Laurea (
    Codice NUMERIC(6) PRIMARY KEY,
    Nome VARCHAR(50) UNIQUE NOT NULL,
    Descrizione VARCHAR(100)
);

DROP TABLE IF EXISTS Dipartimento;
CREATE TABLE Dipartimento (
    Codice NUMERIC(6) PRIMARY KEY,
    Nome VARCHAR(30) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS Studente;
CREATE TABLE Studente (
    Matricola NUMERIC(6),
    Corso_Laurea NUMERIC(6),
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    Data_Nascita DATE NOT NULL,
    Codice_Fiscale CHAR(16) UNIQUE,
    Foto BLOB,
    PRIMARY KEY (Matricola,Corso_Laurea),
    FOREIGN KEY (Corso_Laurea) REFERENCES Corso_Laurea(Codice) ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Docente;
CREATE TABLE Docente (
    Matricola NUMERIC(6),
    Dipartimento NUMERIC(6),
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    Data_Nascita DATE NOT NULL,
    Codice_Fiscale CHAR(16) UNIQUE,
    Foto BLOB,
    PRIMARY KEY (Matricola,Dipartimento),
    FOREIGN KEY (Dipartimento) REFERENCES Dipartimento(Codice) ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Modulo;
CREATE TABLE Modulo (
    Codice NUMERIC(6) PRIMARY KEY,
    Nome VARCHAR(30) NOT NULL,
    Descrizione VARCHAR(50),
    CFU NUMERIC(2) CHECK (CFU = 6 OR CFU = 9 OR CFU = 12)
);

DROP TABLE IF EXISTS Esame;
CREATE TABLE Esame (
    Matricola_Studente NUMERIC(6),
    Codice_Modulo NUMERIC(6),
    Matricola_Docente NUMERIC(6),
    Data DATE,
    Voto NUMERIC(2) CHECK(VOTO > 0 AND VOTO < 31),
    Note VARCHAR(50),
    PRIMARY KEY (Matricola_Studente,Codice_Modulo),
    FOREIGN KEY (Matricola_Studente) REFERENCES Studente(Matricola)
        ON UPDATE CASCADE,
    FOREIGN KEY (Matricola_Docente) REFERENCES Docente(Matricola)
        ON UPDATE CASCADE,
    FOREIGN KEY (Codice_Modulo) REFERENCES Modulo(Codice) ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Sede;
CREATE TABLE Sede (
    Codice NUMERIC(6) PRIMARY KEY,
    Indirizzo VARCHAR(50) NOT NULL,
    Città VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS Sede_Dipartimento;
CREATE TABLE Sede_Dipartimento (
    Codice_Sede NUMERIC(6),
    Codice_Dipartimento NUMERIC(6),
    Note VARCHAR(50),
    PRIMARY KEY (Codice_Sede,Codice_Dipartimento),
    FOREIGN KEY (Codice_Sede) REFERENCES Sede(Codice)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Codice_Dipartimento) REFERENCES Dipartimento(Codice)
        ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO Corso_Laurea VALUES (000001,"Inf e comunicazione digitale",NULL);
INSERT INTO Corso_Laurea VALUES (000002,"Ing. Aerospaziale",NULL);
INSERT INTO Dipartimento VALUES (100000,"Dip. Informatica");
INSERT INTO Dipartimento VALUES (200000,"Dip. Ingegneria");
INSERT INTO Studente VALUES (696975,000001,"Mario","Rossi","1996-06-19","MRIRSS96J19C180K",NULL);
INSERT INTO Studente VALUES (123456,000002,"Maria","Bianchi","1996-07-29","MRABNC96I69A205C",NULL);
INSERT INTO Docente VALUES (321654, 100000,"Giuseppe","Verdi","1976-04-19","GSPVRD96Y19W180A",NULL);
INSERT INTO Docente VALUES (548989,200000,"Antonio","Blu","1980-05-01","ANTBLU80P48D154H",NULL);
INSERT INTO Modulo VALUES (111,"Basi di dati","Corso di laurea ICD - Esame BDD",6);
INSERT INTO Modulo VALUES (458,"Programmazione","Corso di laurea ICD - Progr.",12);
INSERT INTO Esame VALUES (696975,111,321654,"2020-03-29",30,NULL);
INSERT INTO Esame VALUES (696975,458,548989,"2020-04-30",24,NULL);
INSERT INTO Sede VALUES (202125,"Via Roma","Bari");
INSERT INTO Sede VALUES (487596,"Via Napoli","Taranto");
INSERT INTO Sede_Dipartimento VALUES (202125,100000,NULL);
INSERT INTO Sede_Dipartimento VALUES (487596,200000,NULL);
