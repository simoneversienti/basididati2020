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


LOAD DATA INFILE '/var/lib/mysql-files/demo_data_corso_laurea.csv'
INTO TABLE Corso_Laurea
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_dipartimento.csv'
INTO TABLE Dipartimento
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_docente.csv'
INTO TABLE Docente
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_studente.csv'
INTO TABLE Studente
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_modulo.csv'
INTO TABLE Modulo
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_esame.csv'
INTO TABLE Esame
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_sede.csv'
INTO TABLE Sede
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/demo_data_sede_dipartimento.csv'
INTO TABLE Sede_Dipartimento
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
