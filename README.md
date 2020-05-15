# basididati2020
Repository dedicato alle esercitazioni relative all'insegnamento di Basi di Dati - CdL in Informatica e Comunicazione digitale AA 2019/2020


## NOTA PER IL CARICAMENTO
I file presenti nella cartella *data* devono essere copiati nella cartella indicata dalla variabile *secure_file_priv* (per visualizzarne il contenuto digitare **SHOW VARIABLES LIKE "secure_file_priv"**)
Prima del caricamento dei dati demo - tramite il file *load_db_csv.sql* - occorre disabilitare il controllo sulle chiavi esterni (**SET foreign_key_checks = 0**). Dopo il caricamento, abilitare nuovamente il controllo con **SET foreign_key_checks = 1** 
