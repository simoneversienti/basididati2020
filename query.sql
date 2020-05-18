Use Università;
/*
1. Mostrare nome e descrizione di tutti i moduli da 9 CFU

AR: PROJ[Nome,Descrizione](SEL[CFU = 9](Modulo))

*/

SELECT Nome,Descrizione
FROM Modulo
WHERE CFU = 9;

/*
2. Mostrare matricola, nome e cognome dei docenti che hanno più di 60 anni

AR: PROJ[Matricola,Nome,Cognome](SEL[CURDATE()-Data_Nascita > 60](Docente))

*/

SELECT Matricola,Nome,Cognome
FROM Docente
WHERE TIMESTAMPDIFF(YEAR, Data_Nascita, CURDATE()) > 60;

/*
3. Mostrare nome, cognome e nome del dipartimento di ogni docente,
ordinati dal più giovane al più anziano.

AR: PROJ[Nome,Cognome,Nome_Dip](REN[Nome_Dip <- Nome](Dipartimento) JOIN[Dipartimento=Codice] Docente)
Non è possibile fare l'ordinamento in algebra relazionale

*/

SELECT Doc.Nome,Doc.Cognome,Dip.Nome
FROM Docente Doc
JOIN Dipartimento Dip ON Doc.Dipartimento = Dip.Codice
ORDER BY Doc.Data_Nascita;

SELECT Doc.Nome,Doc.Cognome,Dip.Nome
FROM Docente Doc,Dipartimento Dip
WHERE Doc.Dipartimento = Dip.Codice
ORDER BY Doc.Data_Nascita;

/*
4. Mostrare città e indirizzo di ogni sede del dipartimento di codice "INFO"

AR: PROJ[Città,Indirizzo](SEL[Codice_Dipartimento = "INFO"](Sede_Dipartimento JOIN[Codice_Sede=Codice] Sede))

*/

SELECT S.Città,S.Indirizzo
FROM Sede S, Sede_Dipartimento Sd
WHERE (Sd.Codice_Dipartimento = "INFO" AND Sd.Codice_Sede = S.Codice);

/*
5. Mostrare nome del dipartimento, città e indirizzo di ogni sede di
ogni dipartimento, ordinate alfabeticamente prima per nome dipartimento,
poi per nome città e infine per indirizzo

AR: PROJ[Nome,Città,Indirizzo](Sede_Dipartimento JOIN[Codice_Dipartimento=Codice] Dipartimento JOIN[Codice=Codice_Sede] Sede)

*/

SELECT D.Nome,S.Città,S.Indirizzo
FROM Dipartimento D, Sede_Dipartimento Sd, Sede S
WHERE (Sd.Codice_Dipartimento = D.Codice AND S.Codice = Sd.Codice_Sede)
ORDER BY D.Nome;

SELECT D.Nome,S.Città,S.Indirizzo
FROM Dipartimento D, Sede_Dipartimento Sd, Sede S
WHERE (Sd.Codice_Dipartimento = D.Codice AND S.Codice = Sd.Codice_Sede)
ORDER BY S.Città;

SELECT D.Nome,S.Città,S.Indirizzo
FROM Dipartimento D, Sede_Dipartimento Sd, Sede S
WHERE (Sd.Codice_Dipartimento = D.Codice AND S.Codice = Sd.Codice_Sede)
ORDER BY S.Indirizzo;

SELECT D.Nome,S.Città,S.Indirizzo
FROM Dipartimento D
INNER JOIN Sede_Dipartimento Sd ON Sd.Codice_Dipartimento = D.Codice
INNER JOIN Sede S ON S.Codice = Sd.Codice_Sede
ORDER BY D.Nome;

/*
6. Mostrare il nome di ogni dipartimento che ha una sede a Bari.

AR: PROJ[Dip_Nome](SEL[S_Città="Bari"](Sede_Dipartimento JOIN[Codice_Dipartimento=Codice] Dipartimento JOIN[Codice_Sede=Codice] Sede))

*/

SELECT D.Nome
FROM Dipartimento D,Sede S,Sede_Dipartimento Sd
WHERE (Sd.Codice_Dipartimento = D.Codice
    AND Sd.Codice_Sede = S.Codice
    AND S.Città = "Bari");

SELECT D.Nome
FROM Dipartimento D,Sede_Dipartimento Sd
WHERE (Sd.Codice_Dipartimento = D.Codice
    AND Sd.Codice_Sede IN (SELECT Codice FROM Sede WHERE Città = "Bari"));

/*
7. Mostrare il nome di ogni dipartimento che non ha sede a Brindisi.

*/

SELECT D.Nome
FROM Dipartimento D,Sede S,Sede_Dipartimento Sd
WHERE (Sd.Codice_Dipartimento = D.Codice
    AND Sd.Codice_Sede = S.Codice
    AND S.Città <> "Brindisi");

SELECT D.Nome
FROM Dipartimento D,Sede_Dipartimento Sd
WHERE (Sd.Codice_Dipartimento = D.Codice AND Sd.Codice_Sede NOT IN
    (SELECT Codice FROM Sede WHERE Città = "Brindisi"));

/*
8. Mostrare media, numero esami sostenuti e totale CFU acquisiti dello studente
con matricola 555597.

*/

SELECT avg(E.Voto) mediavoti,COUNT(*) tot_esami,SUM(M.CFU) tot_cfu
FROM Esame E,Modulo M
WHERE (E.Matricola_Studente = 555597 AND E.Codice_Modulo = M.Codice);

/*
9. Mostrare nome, cognome, nome del corso di laurea, media e
numero esami sostenuti dello studente con matricola 555597

*/

SELECT S.Nome,S.Cognome,Cdl.Nome,avg(E.Voto) media,COUNT(E.Matricola_Studente) tot_esami
FROM Studente S,Corso_Laurea Cdl,Esame E
WHERE (S.Matricola = E.Matricola_Studente
    AND S.Corso_Laurea = Cdl.Codice
    AND S.Matricola = 555597)
GROUP BY S.Nome,S.Cognome,Cdl.Nome;

/*
10. Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media
più alta alla più bassa.

*/

SELECT M.Codice,M.Nome,avg(E.Voto) media
FROM Modulo M,Esame E
WHERE (E.Codice_Modulo = M.Codice)
GROUP BY M.Codice,M.Nome
ORDER BY media DESC;

/*
11. Mostrare nome e cognome del docente, nome e descrizione del modulo per
ogni docente ed ogni modulo di cui quel docente abbia tenuto almeno un esame;
il risultato deve includere anche i docenti che non abbiano tenuto alcun esame,
in quel caso rappresentati con un'unica tupla in cui nome e descrizione del
modulo avranno valore NULL.

*/

SELECT DISTINCT D.Nome,D.Cognome,M.Nome,M.Descrizione
FROM Docente D
LEFT JOIN (Modulo M JOIN Esame E ON M.Codice=E.Codice_Modulo) ON E.Matricola_Docente=D.Matricola;

/*
12. Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente.

*/

SELECT S.Matricola,S.Nome,S.Cognome,S.Data_Nascita,avg(E.Voto) media,count(*) esami
FROM Studente S,Esame E
WHERE (S.Matricola=E.Matricola_Studente)
GROUP BY S.Matricola,S.Nome,S.Cognome,S.Data_Nascita;

/*
13. Mostrare matricola, nome, cognome, data di nascita, media e numero esami
sostenuti di ogni studente del corso di laurea di codice "ICD" che abbia media
maggiore di 27.

*/

SELECT S.Matricola,S.Nome,S.Cognome,S.Data_Nascita,avg(E.Voto) media,count(*) esami
FROM Studente S,Esame E,Corso_Laurea Cdl
WHERE (S.Matricola=E.Matricola_Studente AND S.Corso_Laurea=Cdl.Codice AND Cdl.Nome="ICD")
GROUP BY S.Matricola,S.Nome,S.Cognome,S.Data_Nascita
HAVING media > 27;

/*
14. Mostrare nome, cognome e data di nascita di tutti gli studenti che ancora non hanno superato nessun esame.

*/

SELECT S.Matricola,S.Nome,S.Cognome,S.Data_Nascita
FROM Studente S
WHERE (S.Matricola NOT IN (SELECT E.Matricola_Studente FROM Esame E));

/*
15. Mostrare la matricola di tutti gli studenti che hanno superato almeno un
esame e che hanno preso sempre voti maggiori di 26.

*/

SELECT S.Matricola
FROM Studente S
WHERE (S.Matricola IN (
    SELECT E.Matricola_Studente FROM Esame E WHERE E.Voto >= 27)
    AND S.Matricola NOT IN (
        (SELECT E.Matricola_Studente FROM Esame E WHERE E.Voto <= 27)));

/*
16. Mostrare, per ogni modulo, il numero degli studenti che hanno preso
tra 18 e 21, quelli che hanno preso tra 22 e 26 e quelli che hanno preso
tra 27 e 30 (con un'unica interrogazione).

*/

SELECT M.Nome,
COUNT(CASE WHEN E.Voto BETWEEN 18 AND 21 THEN 1 END) as "18-21",
COUNT(CASE WHEN E.Voto BETWEEN 22 AND 26 THEN 1 END) as "22-26",
COUNT(CASE WHEN E.Voto BETWEEN 27 AND 30 THEN 1 END) as "27-30"
FROM Esame E,Modulo M
WHERE (E.Codice_Modulo = M.Codice)
GROUP BY M.Nome;

/*
17. Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un
voto maggiore della media nel modulo "Basi di dati"

*/

SELECT S.Matricola,S.Nome,S.Cognome,E.Voto
FROM Studente S,Esame E,Modulo M
WHERE (M.Nome="Basi di dati"
    AND E.Matricola_Studente=S.Matricola
    AND E.Codice_Modulo=M.Codice)
HAVING E.Voto > (SELECT avg(E.Voto)
FROM Esame E,Modulo M
WHERE (E.Codice_Modulo=M.Codice AND M.Nome = "Basi di dati"));

/*
18. Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno
3 esami un voto maggiore della media per quel modulo.

*/
