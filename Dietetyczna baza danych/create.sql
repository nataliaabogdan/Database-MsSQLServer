--CREATE

IF OBJECT_ID('dbo.AktualnePomiary') IS NOT NULL
DROP TABLE dbo.AktualnePomiary
IF OBJECT_ID('dbo.Znajomi') IS NOT NULL
DROP TABLE dbo.Znajomi
IF OBJECT_ID('dbo.Sk³adJad³ospisów') IS NOT NULL
DROP TABLE dbo.Sk³adJad³ospisów
IF OBJECT_ID('dbo.ZaplanowaneJad³ospisy') IS NOT NULL
DROP TABLE dbo.ZaplanowaneJad³ospisy
IF OBJECT_ID('dbo.ZapisaneJad³ospisy') IS NOT NULL
DROP TABLE dbo.ZapisaneJad³ospisy
IF OBJECT_ID('dbo.OcenioneJad³ospisy') IS NOT NULL
DROP TABLE dbo.OcenioneJad³ospisy
IF OBJECT_ID('dbo.Jad³ospisy') IS NOT NULL
DROP TABLE dbo.Jad³ospisy
IF OBJECT_ID('dbo.Sk³adListyZakupów') IS NOT NULL
DROP TABLE dbo.Sk³adListyZakupów
IF OBJECT_ID('dbo.Sk³adPosi³ków') IS NOT NULL
DROP TABLE dbo.Sk³adPosi³ków
IF OBJECT_ID('dbo.Sk³adTreningu') IS NOT NULL
DROP TABLE dbo.Sk³adTreningu
IF OBJECT_ID('dbo.TagiTreningów') IS NOT NULL
DROP TABLE dbo.TagiTreningów
IF OBJECT_ID('dbo.ZaplanowaneTreningi') IS NOT NULL
DROP TABLE dbo.ZaplanowaneTreningi
IF OBJECT_ID('dbo.ZapisaneTreningi') IS NOT NULL
DROP TABLE dbo.ZapisaneTreningi
IF OBJECT_ID('dbo.OcenioneTreningi') IS NOT NULL
DROP TABLE dbo.OcenioneTreningi
IF OBJECT_ID('dbo.Treningi') IS NOT NULL
DROP TABLE dbo.Treningi
IF OBJECT_ID('dbo.TagiÆwiczeñ') IS NOT NULL
DROP TABLE dbo.TagiÆwiczeñ
IF OBJECT_ID('dbo.Æwiczenia') IS NOT NULL
DROP TABLE dbo.Æwiczenia
IF OBJECT_ID('dbo.TagiProduktów') IS NOT NULL
DROP TABLE dbo.TagiProduktów
IF OBJECT_ID('dbo.TagiPosi³ków') IS NOT NULL
DROP TABLE dbo.TagiPosi³ków
IF OBJECT_ID('dbo.Posi³ki') IS NOT NULL
DROP TABLE dbo.Posi³ki
IF OBJECT_ID('dbo.TagSportowy') IS NOT NULL
DROP TABLE dbo.TagSportowy
IF OBJECT_ID('dbo.TagSpo¿ywczy') IS NOT NULL
DROP TABLE dbo.TagSpo¿ywczy
IF OBJECT_ID('dbo.Tag') IS NOT NULL
DROP TABLE dbo.Tag
IF OBJECT_ID('dbo.Produkty') IS NOT NULL
DROP TABLE dbo.Produkty
IF OBJECT_ID('dbo.Producenci') IS NOT NULL
DROP TABLE dbo.Producenci
IF OBJECT_ID('dbo.ListaZakupów') IS NOT NULL
DROP TABLE dbo.ListaZakupów
IF OBJECT_ID('dbo.U¿ytkownicy') IS NOT NULL
DROP TABLE dbo.U¿ytkownicy

CREATE TABLE Treningi(
IDTreningu INT PRIMARY KEY IDENTITY(1,1),
NazwaTreningu VARCHAR(100) NOT NULL,
StopieñTrudnoœci VARCHAR(50) NOT NULL
)
CREATE TABLE Æwiczenia(
IDÆwiczenia INT PRIMARY KEY IDENTITY(1,1),
NazwaÆwiczenia VARCHAR(100) NOT NULL,
SpaloneKcal INT,
[CzasWykonywania] INT 
)
CREATE TABLE U¿ytkownicy(
IDU¿ytkownika INT PRIMARY KEY IDENTITY(1,1),
NazwaU¿ytkownika VARCHAR(20) NOT NULL,
ImiêU¿ytownika VARCHAR(20) NOT NULL,
NazwiskoU¿ytkownika VARCHAR(20) NOT NULL,
NumerTelefonu VARCHAR(9)
)
CREATE TABLE Posi³ki(
IDPosi³ku INT PRIMARY KEY IDENTITY(1,1),
NazwaPosi³ku VARCHAR(100) NOT NULL,
Kalorie FLOAT NOT NULL,
Wêglowodany FLOAT NOT NULL,
Bia³ka FLOAT NOT NULL,
T³uszcze FLOAT NOT NULL,
)
CREATE TABLE Tag(
IDTagu INT PRIMARY KEY IDENTITY(1,1),
NazwaTagu VARCHAR(100) NOT NULL
)
CREATE TABLE TagSportowy(
IDTagu INT REFERENCES Tag(IDTagu),
Ogólnorozwojowy VARCHAR(3),
PRIMARY KEY(IDTagu)
)
CREATE TABLE TagSpo¿ywczy(
IDTagu INT REFERENCES Tag(IDTagu),
OpisTagu VARCHAR(200) NOT NULL,
PRIMARY KEY(IDTagu)
)

CREATE TABLE Producenci(
IDProducenta INT PRIMARY KEY IDENTITY(1,1),
NazwaProducenta VARCHAR(100) NOT NULL,
)
CREATE TABLE Produkty(
IDProduktu INT PRIMARY KEY IDENTITY(1,1),
NazwaProduktu VARCHAR(100) NOT NULL,
IDProducenta INT REFERENCES Producenci(IDProducenta),
Kalorie INT NOT NULL,
Wêglowodany FLOAT NOT NULL,
Bia³ka FLOAT NOT NULL,
T³uszcze FLOAT NOT NULL,
MasaPorcji FLOAT NOT NULL
)
CREATE TABLE ListaZakupów(
IDListy INT PRIMARY KEY IDENTITY(1,1),
NazwaSklepu VARCHAR(20),
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika)
)

CREATE TABLE Sk³adTreningu(
IDTreningu INT REFERENCES Treningi(IDTreningu),
IDÆwiczenia INT REFERENCES Æwiczenia(IDÆwiczenia),
IloœæPowtórzeñJednostkiÆwiczeniowej INT NOT NULL,
PRIMARY KEY(IDTreningu,IDÆwiczenia)
)
CREATE TABLE TagiTreningów(
IDTreningu INT REFERENCES Treningi(IDTreningu),
IDTagu INT REFERENCES TagSportowy(IDTagu)
)
CREATE TABLE ZaplanowaneTreningi(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
DataRozpoczêcia DATE NOT NULL,
DataZakoñczenia DATE NOT NULL,
)
CREATE TABLE ZapisaneTreningi(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
UNIQUE(IDU¿ytkownika,IDTreningu)
)
CREATE TABLE OcenioneTreningi(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
Ocena INT NOT NULL,
UNIQUE(IDU¿ytkownika,IDTreningu)
)
CREATE TABLE TagiÆwiczeñ(
IDÆwiczenia INT REFERENCES Æwiczenia(IDÆwiczenia),
IDTagu INT REFERENCES TagSportowy(IDTagu)
)
CREATE TABLE TagiPosi³ków(
IDPosi³ku INT REFERENCES Posi³ki(IDPosi³ku),
IDTagu INT REFERENCES TagSpo¿ywczy(IDTagu)
)
CREATE TABLE TagiProduktów(
IDProduktu INT REFERENCES Produkty(IDProduktu),
IDTagu INT REFERENCES TagSpo¿ywczy(IDTagu)
)
CREATE TABLE Jad³ospisy(
IDJad³ospisu INT PRIMARY KEY IDENTITY(1,1),
NazwaJad³ospisu VARCHAR(100) NOT NULL,
Kalorie INT NOT NULL,
Wêglowodany FLOAT NOT NULL,
Bia³ka FLOAT NOT NULL,
T³uszcze FLOAT NOT NULL,
)
CREATE TABLE Sk³adPosi³ków(
IDPosi³ku INT REFERENCES Posi³ki(IDPosi³ku),
IDProduktu INT REFERENCES Produkty(IDProduktu),
IloœæPorcji FLOAT NOT NULL
)
CREATE TABLE Sk³adListyZakupów(
IDListy INT REFERENCES ListaZakupów(IDListy),
IDProduktu INT REFERENCES Produkty(IDProduktu),
IloœæPorcji FLOAT NOT NULL,
UNIQUE(IDListy, IDProduktu)
)
CREATE TABLE ZaplanowaneJad³ospisy(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDJad³ospisu INT REFERENCES Jad³ospisy(IDJad³ospisu),
Data DATE NOT NULL
)
CREATE TABLE ZapisaneJad³ospisy(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDJad³ospisu INT REFERENCES Jad³ospisy(IDJad³ospisu),
UNIQUE(IDU¿ytkownika,IDJad³ospisu)
)
CREATE TABLE OcenioneJad³ospisy(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDJad³ospisu INT REFERENCES Jad³ospisy(IDJad³ospisu),
Ocena INT NOT NULL,
UNIQUE(IDU¿ytkownika,IDJad³ospisu)
)
CREATE TABLE AktualnePomiary(
IDU¿ytkownika INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
CzasPomiaru DATETIME NOT NULL,
Waga INT NOT NULL,
ObwódPasa INT NOT NULL,
UNIQUE(IDU¿ytkownika, CzasPomiaru)
)

CREATE TABLE Znajomi(
IDPary INT PRIMARY KEY IDENTITY(1,1),
IDU¿ytkownika1 INT REFERENCES U¿ytkownicy(IDU¿ytkownika),
IDU¿ytkownika2 INT REFERENCES U¿ytkownicy(IDU¿ytkownika)
)
CREATE TABLE Sk³adJad³ospisów(
IDJad³ospisu INT REFERENCES Jad³ospisy(IDJad³ospisu),
IDPosi³ku INT REFERENCES Posi³ki(IDPosi³ku)
)