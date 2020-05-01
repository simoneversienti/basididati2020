USE Università;

/* test1: valore NULL per attributo definito come NOT NULL */
INSERT INTO Corso_Laurea VALUES (356984,NULL,"Prova");

/* test2: valore NULL o già esistente per PRIMARY KEY */
INSERT INTO Dipartimento VALUES (NULL,"Scienze ambientali");
INSERT INTO Dipartimento VALUES (100000,"Scienze ambientali");

/* test3: creare record inserendo in un campo definito come FOREIGN KEY
un valore non esistente nella tabella di riferimento */
INSERT INTO Studente VALUES
    (696975,000005,"Pippo","Baudo","1950-06-20","PPPBDO50P20C180K",NULL);

/* test4: violare la condizione CHECK */
INSERT INTO Esame VALUES (696975,111,321654,"2020-03-29",86,NULL);
INSERT INTO Esame VALUES (696975,111,321654,"2020-03-29",-25,NULL);
INSERT INTO Modulo VALUES (111,"Basi di dati","Corso di laurea ICD - Esame BDD",40);

/* test5: inserire valore già esistente per campo UNIQUE */
INSERT INTO Dipartimento VALUES (100001,"Dip. Informatica");
