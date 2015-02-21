DROP DATABASE IF EXISTS yritys2;
CREATE DATABASE yritys2;
USE yritys2;

CREATE TABLE YRITYS (Ytunnus VARCHAR(12),
    katuosoite VARCHAR(20)NOT NULL,
    postinro CHAR(5)NOT NULL,
    postitoimipaikka VARCHAR(20)NOT NULL,
    puhnro VARCHAR(15)NOT NULL,
    CONSTRAINT Ytunnus_pk PRIMARY KEY (Ytunnus))
    ENGINE=InnoDB;
    
CREATE TABLE TOIMIPISTE (toimipisteID INT AUTO_INCREMENT,
    yritystunnus VARCHAR(12),
nimi VARCHAR(20) NOT NULL,
    katuosoite VARCHAR(20) NOT NULL,
    postinumero CHAR(5),
    postitoimipaikka VARCHAR(20),
    puhnro VARCHAR(15),
    CONSTRAINT toimipisteID_pk PRIMARY KEY (toimipisteID),
    CONSTRAINT toimipisteet FOREIGN KEY (yritystunnus) REFERENCES YRITYS(Ytunnus) ON DELETE CASCADE ON UPDATE CASCADE)
    ENGINE=InnoDB;
    
CREATE TABLE TYONTEKIJA (henkilonumero INT AUTO_INCREMENT,
    toimipiste INT NOT NULL,
    hetu CHAR(11) NOT NULL,
    etunimi VARCHAR(20) NOT NULL,
    sukunimi VARCHAR(20) NOT NULL,
tyotehtava VARCHAR(20),
    palkka INT,
    palkkaprosentti INT,
    muutospvm TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT henkilonumero_pk PRIMARY KEY (henkilonumero),
    CONSTRAINT oma_toimipiste_fk FOREIGN KEY (toimipiste) REFERENCES TOIMIPISTE(toimipisteID) ON DELETE RESTRICT ON UPDATE CASCADE)
    ENGINE=InnoDB;

CREATE TABLE ASIAKAS (asiakasnumero INT AUTO_INCREMENT,
    yritysnimi VARCHAR(20) NOT NULL,
    etunimi VARCHAR(20) NOT NULL,
    sukunimi VARCHAR(20) NOT NULL,
    katuosoite VARCHAR(20),
    postinumero CHAR(5),
    postitoimipaikka VARCHAR(20),
    puhnro VARCHAR(15),
    CONSTRAINT asiakas_pk PRIMARY KEY (asiakasnumero))
    ENGINE=InnoDB;

CREATE TABLE TUOTE (tuotenumero INT AUTO_INCREMENT,
    hinta VARCHAR(15),
    varastosaldo INT,
    varastopaikka VARCHAR(10),
    alv INT,
    toimittaja VARCHAR(20),
    voimassaolo TINYINT(1) DEFAULT 0,
    CONSTRAINT tuote_pk PRIMARY KEY (tuotenumero))
    ENGINE=InnoDB; 
    
CREATE TABLE OSTOTAPAHTUMA (tapahtumanumero INT AUTO_INCREMENT,
    asiakas INT NOT NULL,
    toimipiste INT NOT NULL,
    henkilo INT NOT NULL,
    aika TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    maksutapa VARCHAR (15) NOT NULL,
    CONSTRAINT tapahtuma_pk PRIMARY KEY (tapahtumanumero),
    CONSTRAINT as_tap FOREIGN KEY (asiakas) REFERENCES ASIAKAS(asiakasnumero) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT toim_tap FOREIGN KEY (toimipiste) REFERENCES TOIMIPISTE(toimipisteID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT henk_tap FOREIGN KEY (henkilo) REFERENCES TYONTEKIJA(henkilonumero) ON DELETE RESTRICT ON UPDATE CASCADE)
    ENGINE=InnoDB;

CREATE TABLE TUOTELISTA (tapahtuma INT,
    tuote INT,
    CONSTRAINT lista_tap FOREIGN KEY (tapahtuma) REFERENCES OSTOTAPAHTUMA(tapahtumanumero)  ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT lista_tuote FOREIGN KEY (tuote) REFERENCES TUOTE(tuotenumero) ON DELETE RESTRICT ON UPDATE CASCADE)
    ENGINE=InnoDB;

CREATE TABLE TUNNUKSET (henkilonumero INT PRIMARY KEY, salasanatiiviste VARCHAR(40) NOT NULL, aktiivinen TINYINT(1) DEFAULT 0); 

CREATE TRIGGER luosalasana AFTER INSERT ON TYONTEKIJA
  FOR EACH ROW
  INSERT INTO TUNNUKSET VALUES (NEW.henkilonumero, SHA1(CONCAT(LEFT(NEW.sukunimi, 3), LEFT(NEW.hetu, 2))), 0);