Create database autorentHalchenko;
USE autorentHalchenko;
--Tabel auto
CREATE TABLE auto(
autoID int not null Primary key identity(1,1),
regNumber char(6) UNIQUE,
markID int,
varv varchar(20),
v_aasta int,
kaigukastID int,
km decimal(6,2)
);
ALTER TABLE auto
ADD FOREIGN KEY (markID) REFERENCES mark(markID);
ALTER TABLE auto
ADD FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID);

INSERT INTO auto(regNumber, markID, varv, v_aasta, kaigukastID, km)
VALUES ('123 AB', 3, 'Violet', 2005, 2, 200.50), 
('564 DD', 1, 'Khaki', 2007, 1, 254.50),
('666 AC', 2, 'Pink', 2012, 2, 267.50);
SELECT * FROM auto 

--Tabel mark 
CREATE TABLE mark(
markID int not null Primary key IDENTITY(1,1),
autoMark varchar(30) UNIQUE
);
INSERT INTO mark(autoMark)
VALUES ('Ziguli');
INSERT INTO mark(autoMark)
VALUES ('Lambordzini');
INSERT INTO mark(autoMark)
VALUES ('BMW');
SELECT * FROM mark;

--Tabel kaigukast
CREATE TABLE kaigukast(
kaigukastID int not null Primary key identity(1,1),
kaigukast varchar(30) UNIQUE
);
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat');
INSERT INTO kaigukast(kaigukast)
VALUES ('Manual');
SELECT * FROM kaigukast;

--Tabel klient
CREATE TABLE klient(
klientiId int not null Primary key identity(1,1),
kliendiNimi varchar (50),
telefon varchar (20),
aadress varchar (50),
soiduKogemus varchar (30)
);
SELECT * FROM klient;
INSERT INTO klient(kliendiNimi, telefon, aadress, soiduKogemus)
VALUES ('Daria', '58883266', 'Viljandi 16', '3 aastane'),
('Valeria', '58866634', 'Väike Õismäe 5', '10 aastane'),
('Maksim', '58876332','Nurmenuku 22', '2 aastane');

--Tabel tootaja
CREATE TABLE tootaja(
tootajaID INT NOT NULL Primary key identity(1,1),
tootajaNimi VARCHAR(50),
ametID int,
FOREIGN KEY (ametID) REFERENCES mark(markID)
);
INSERT INTO tootaja(tootajaNimi,ametID)
VALUES ('Aleksandr', 3),
('Anton', 1),
('Kirill', 2);
SELECT * FROM tootaja;

--Tabel rendiLeping
CREATE TABLE rendiLeping(
lepingID int not null Primary key identity(1,1),
rendiAlgus date,
rendiLopp date,
kliendID int,
regNumber char(6),
rendiKestvus int,
hindKokku decimal (5,2),
tootajaID int
);
ALTER TABLE rendileping
ADD FOREIGN KEY (kliendID) REFERENCES klient(klientiID);
ALTER TABLE rendileping
ADD FOREIGN KEY (regNumber) REFERENCES auto(regNumber);
ALTER TABLE rendileping
ADD FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID);

INSERT INTO rendileping(rendiAlgus, rendiLopp, kliendID, regNumber, rendiKestvus, hindKokku, tootajaID)
VALUES ('2023-05-06', '2024-05-06', 3, '564 DD', '235', '600', 1),
('2024-01-03', '2024-09-25', 2, '666 AC', '134', '400', 2);
SELECT * FROM rendileping;  

--Tabel autorent
Create table autorent(
autorentID int not null Primary key identity(1,1),
markNimi varchar(30),
kaigukastNimi varchar(30),
);
ALTER TABLE autorent
ADD FOREIGN KEY (markNimi) REFERENCES mark(autoMark); 
ALTER TABLE autorent 
ADD FOREIGN KEY (kaigukastNimi) REFERENCES kaigukast(kaigukast); 
INSERT INTO autorent (markNimi,kaigukastNimi) 
VALUES ('Ziguli','Manual'),
('BMW','Automaat'),
('Lambordzini','Automaat');
SELECT * FROM autorent;  

--määrame SELECT 
GRANT SELECT ON rendileping TO Daria;
GRANT INSERT ON rendileping TO Daria;
--keelduda DELETE
DENY DELETE to Daria;

--Ülesanne:
--1. Koosta SELECT lause ja näita mis autos milline käigukast (kasuta INNER JOIN)

SELECT auto.regNumber, kaigukast.kaigukast 
FROM auto 
INNER JOIN kaigukast ON auto.kaigukastID=kaigukast.kaigukastID; 

--2.Koosta SELECT lause ja näita mis autos milline automark (kasuta INNER JOIN)
SELECT auto.regNumber, mark.autoMark 
FROM auto 
INNER JOIN mark ON auto.markID = mark.markID; 

--3. Koosta SELECT lause ja näita millised autod töötaja andis rendile
SELECT rendiLeping.regNumber, auto.varv, tootaja.tootajanimi 
FROM rendiLeping 
INNER JOIN auto ON rendiLeping.regNumber = auto.regNumber 
INNER JOIN tootaja ON rendiLeping.tootajaID = tootaja.tootajaID;

--4. Otsi summaarne autode arv (COUNT) ja summaarne maksumus (SUM) tabelis rendileping.
SELECT COUNT(regNumber) 
AS Renditudautosidkokku, 
SUM(hindKokku) 
AS HindKokku 
FROM rendiLeping; 

--5. Koosta oma SQL lause mis kasutab kaks seostatud tabelid.
SELECT klient.kliendiNimi, auto.regNumber 
FROM rendiLeping 
INNER JOIN klient ON rendiLeping.kliendID=klient.klientiID 
INNER JOIN auto ON rendiLeping.regNumber=auto.regNumber;

--Protseduurid:
--Loo protseduur andmete lisamiseks tabelisse rendileping.
create procedure Insert_rendileping1(
@rendiAlgus date,
@rendiLopp date,
@kliendID int,
@regNumber char(6),
@rendiKestvus int,
@hindKokku decimal (5,2),
@tootajaID int)
as 
INSERT INTO rendileping(
rendiAlgus, rendiLopp, kliendID, regNumber, rendiKestvus, hindKokku, tootajaID)
Values(@rendiAlgus, @rendiLopp, @kliendID, @regNumber, @rendiKestvus, @hindKokku, @tootajaID);
EXEC Insert_rendileping1
@rendiAlgus='2023-10-26',@rendiLopp='2024-10-26', @kliendID=1, @regNumber='564 DD', @rendiKestvus='233', @hindKokku='153', @tootajaID=2;
SELECT * from rendileping

--Loo protseduur lepingu kustutamiseks  id järgi.
CREATE PROCEDURE rendilepingkustutamine
@deleteID int
AS
BEGIN
SELECT * FROM rendileping;
DELETE FROM rendileping
WHERE lepingID = @deleteID;
SELECT * FROM rendileping;
END; 

-- kontroll

EXEC  rendilepingkustutamine 2;







