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

--INSERT


INSERT INTO Tag VALUES
('wegetariañski'),
('wegetariañski + ryby'),
('wegañski'),
('miêsne'),
('bez nabia³u'),
('bez glutenu'),
('Brzuch'),
('Nogi'),
('Rêce'),
('Plecy'),
('Cardio'),
('Si³owe'),
('Na œwie¿ym powietrzu'),
('Bez sprzêtu'),
('Dru¿ynowe'),
('Indywidualne'),
('Zimowe'),
('Wodne')


INSERT INTO TagSpo¿ywczy VALUES
(1,'nie zawiera produktów miêsnych ani rybnych'),
(2,'nie zawiera produktów miêsnych'),
(3,'nie zawiera produktów pochodzenia zwierzêcego'),
(4,'zawiera miêso'),
(5,'nie zawiera produktów mlecznych'),
(6,'nie zawiera glutenu')

INSERT INTO TagSportowy VALUES
(7,'NIE'),
(8,'NIE'),
(9,'NIE'),
(10,'NIE'),
(11,'TAK'),
(12,'NIE'),
(13,'TAK'),
(14,NULL),
(15,NULL),
(16,NULL),
(17,'TAK'),
(18,NULL)

INSERT INTO Producenci  VALUES
('Hurtownia Warzyw Kusia'),
('Domowy Ogródek Hani i Helenki'),
('Warzywa i Owoce Rudy i spó³ka'),
('Zak³ady Mleczarskie Œnie¿ynka'),
('Wyroby mleczne Bacuœ'),
('Masarnia Œwinka'),
('Wyroby miêsne Krowa i Kurczak'),
('Hurtownia spo¿ywcza Bajka'),
('Sklep z alkoholami Beczka'),
('Danone'),
('Mlekovita'),
('Rians'),
('Roussas'),
('Pi¹tnica'),
('S.M. Bieluch Che³m'),
('Kraft Foods'),
('Piekarnia T³usty P¹czek')
INSERT INTO Produkty VALUES
('P³atki owsiane', 8, 389, 66, 17, 7, 100),
('Chleb ¿ytni', 17, 72, 14, 2, 1, 30),
('Bu³ka grahamka', 17, 88, 18, 3, 1, 30),
('Chleb graham', 17, 70, 16, 2, 1, 30),
('S³onecznik pestki', 8, 584, 20, 20, 51, 100),
('Kasza jaglana', 8, 378, 72, 11, 4, 100),
('Chleb pszenno-¿ytni', 17, 70, 15, 1, 1, 30),
('Bu³ka kajzerka', 17, 95, 17, 3, 1, 30),
('Ry¿ br¹zowy', 8, 354, 72, 8, 3, 100),
('Chleb pszenny', 17, 67, 18, 3, 1, 30),
('Otrêby pszenne', 8, 185, 61, 16, 5, 100),
('Ry¿ paraboliczny', 8, 365, 79, 8, 1, 100),
('M¹ka pszenna', 8, 364, 76, 10, 1, 100),
('Makaron pe³noziarnisty', 8, 340, 58, 15, 3, 100),
('Bu³ka tarta', 8, 363, 76, 9, 2, 100),
('Chleb orkiszowy', 17, 73, 14, 3, 2, 30),
('Otrêby owsiane', 8, 361, 46, 18 , 8, 100),
('Musli owocowe', 8, 367, 72, 9, 5, 100),
('Kasza gryczana', 8, 355, 70, 13, 3, 100),
('Kasza kuskus', 8, 342, 68, 13, 2, 100),
('Chleb tostowy pe³noziarnisty', 17, 90, 15, 3, 2, 30),
('M¹ka ¿ytnia', 8, 349, 75, 11, 2, 100),
('Wafle ry¿owe', 8, 374, 81, 8, 3, 100),
('Ry¿ bia³y', 8, 350, 79, 7, 1, 100),
('M¹ka pszenna pe³noziarnista', 8, 340, 72, 13, 3, 100),
('Makaron jajeczny', 8, 146, 27, 6, 2, 100),
('Pieczywo chrupkie', 8, 368, 77, 9, 2, 100),
('Kasza jêczmienna', 8, 338, 70, 10, 1, 100),
('P³atki kukurydziane', 8, 399, 90, 8, 1, 100),
('Komosa ry¿owa', 8, 368, 64, 14, 6, 100),
('Ry¿ Basmati', 8, 351, 76, 9, 1, 100),
('Sezam', 8, 572, 23, 18, 50, 100),
('Tortilla (placek)', 8, 315, 56, 6, 7, 100),
('Makaron razowy', 8, 318, 61, 14, 2, 100),
('Chia', 8, 402, 1, 23, 33, 100),
('Kasza manna', 8, 348, 74, 9, 1, 100),
('M¹ka owsiana', 8, 404, 66, 15, 9, 100),
('Dynia nasiona', 8, 559, 11, 30, 50, 100),
('Makaron Lasagne', 8, 348, 71, 12, 1, 100),
('Sucharki', 8, 399, 69, 13, 7, 100), 
('Makaron spaghetti',8, 324, 50, 9, 1, 100),
('Obwarzanek krakowski', 17, 253, 50, 5, 3, 100),
('M¹ka orkiszowa', 8, 326, 60, 14, 2, 100),
('M¹ka kokosowa', 8, 312, 13, 11, 24, 100),
('Granola', 8, 429, 60, 70, 17, 100),
('Kasza bulgur', 8, 342, 76, 12, 1, 100), 
('M¹ka gryczana', 8, 335, 71, 13, 3, 100),
('Ry¿ jaœminowy', 8, 355, 79, 7, 1, 100),
('Kurczak (pierœ bez skóry)', 6, 121, 0, 22, 4, 100),
('£osoœ wêdzony', 6, 153, 0, 25, 5, 100),
('Makrela wêdzona', 7, 201, 0, 26, 10, 100),
('Polêdwica sopocka', 6, 111, 1, 19, 3, 100),
('Szynka', 7, 96, 0, 17, 3, 100),
('Indyk (pierœ bez skóry)', 6, 104, 4, 17, 2, 100),
('Wêdlina z piersi indyka', 7, 90, 2, 20, 1, 100),
('Szynka wieprzowa gotowana', 7, 232, 1, 17, 18, 100),
('Szynka z piersi kurczaka', 7, 85, 2, 16, 2, 100),
('Dorsz', 6, 91, 1, 15, 2, 100),
('Miêso mielone drobiowe', 6, 143, 0, 19, 8, 100),
('Kotlet schabowy', 6, 318, 12, 15, 25, 100),
('Tuñczyk', 6, 106, 0, 24, 1, 100),
('Szynka parmeñska',6, 222, 1, 28, 12, 100),
('Szynka z indyka', 6, 126, 2, 18, 5, 100),
('Kie³basa krakowska sucha', 7, 326, 0, 26, 25, 100),
('Pierœ z kurczaka wêdzona', 7, 107, 0, 23, 1, 100),
('Parówki', 6, 251, 3, 13, 21, 100),
('Wo³owina', 6, 160, 0, 21, 8, 100),
('Karkówka wieprzowa',7,  389, 0, 23, 33, 100),
('Miêso mielone wo³owe', 7, 254, 0, 17, 20, 100),
('Pasztet z drobiu', 7, 149, 1, 22, 6, 100),
('Kie³basa œl¹ska', 7, 214, 0, 18, 16, 100),
('Kaszanka', 6, 274, 15, 9, 20, 100),
('Kie³basa', 7, 214, 0, 18, 16, 100),
('Miêso mielone wieprzowe', 6, 264, 0, 21, 20, 100),
('Boczek', 6, 478, 1, 13, 47, 100),
('Salami', 6, 459, 0, 22, 41, 100),
('Kabanos wieprzowy', 7, 328, 0, 28, 24, 100),
('Frankfurterki', 6, 305, 2, 12, 28, 100),
('Pasztet wieprzowo-wo³owy', 7, 295, 3, 19, 22, 100),
('Pstr¹g', 7, 130, 0, 25, 3, 100),
('Krewetki', 7, 106, 1, 21, 2, 100),
('Kaczka', 7, 337, 0, 19, 29, 100),
('Tatar', 7, 118, 1, 18, 5, 100),
('Kurczak - podudzie', 6, 300, 0, 23, 27, 100),
('ŒledŸ', 6, 216, 0, 20, 15, 100),
('Sola', 6, 87, 0, 18, 1, 100),
('¯eberka wieprzowe',7, 359, 0, 22, 30, 100),
('Metka', 7, 135, 1, 15, 8, 100),
('Jaja przepiórcze', 2, 95, 0.2, 7.8, 6.6, 60),
('Actimel', 10, 71, 10.5, 2.8, 1.6, 100),
('Actimel wieloowocowy', 10, 78, 12.4, 2.6, 1.5, 100),
('Actimel', 10, 71, 10.5, 2.8, 1.6, 100),
('Bia³ko jaja kurzego', 2, 17, 0.2, 3.8, 0.1, 35),
('Danonek, jogurt o smaku truskawkowym w saszetce', 10, 62, 8.5, 2.5, 2, 70),
('Kostki sera Favita w oleju', 11, 88, 1.5, 7, 6, 50),
('Garœæ startego ¿ó³tego sera', 5, 107, 0.7, 7.5, 8.2, 30),
('Jajko sadzone', 2, 127, 0.4, 7.5, 10.8, 52),
('Jajko gotowane', 8, 78, 0.6, 6.3, 5.3, 50),
('Jajko kurze', 2, 71, 0.3, 6.4, 4.9, 51),
('Jogurt kozi naturalny', 12, 95, 3.4, 6.7, 7.2, 120),
('Jogurt naturalny Activia', 10, 145, 10.7, 9.5, 7.1, 210),
('Kawa³ek parmezanu', 4, 908, 0.2, 81.4, 64, 200),
('Kostka greckiej Fety', 13, 530, 2.8, 35, 42, 200),
('Kula mozzarelli', 4, 635, 7.5, 60, 40, 250),
('£y¿eczka mleka w proszku', 8, 25, 1.9, 1.3, 1.3, 5),
('£y¿eczka sera mascarpone', 14, 47, 0.6, 0.4, 4.8, 12),
('£y¿eczka serka naturalnego', 15, 19, 0.6, 1.3, 1.3, 15),
('£y¿eczka serka wiejskiego ze szczypiorkiem', 14, 15, 0.3, 1.7, 0.8, 15),
('£y¿ka jogurtu greckiego 0%', 10, 10, 0.8, 1.8, 0, 20),
('£y¿ka jogurtu naturalnego', 4, 15, 1.5, 1.1, 0.5, 25),
('£y¿ka jogurtu naturalnego 0%', 4, 10, 1.3, 1, 0, 20),
('£y¿ka serka œmietankowego Philadelphia', 16, 63, 0.8, 1.5, 5.9, 25),
('£y¿ka œmietany 12%', 4, 24, 0.7, 0.5, 2.2, 18),
('£y¿ka œmietany 18%', 4, 47, 0.9, 0.6, 4.5, 25),
('£y¿ka œmietany 30%', 4, 29, 0.3, 0.2, 3.0, 10),
('Pieróg z twarogiem', 4, 72, 8, 3.3, 3, 30),
('Plaster jaja', 8, 16, 0.1, 1.3, 1.1, 10),
('Plaster pe³not³ustego sera "Morskiego"', 11, 71, 0, 5.3, 5.5, 22),
('Plaster sera Gouda', 11, 79, 0, 6.8, 5.7, 25),
('Plaster sera ¿ó³tego', 5, 57, 0, 4.3, 4.5, 15),
('Plaster twarogu chudego', 5, 34, 0.7, 7.5, 0.2, 34),
('Porcja mas³a extra', 5, 37, 0, 0, 4.1, 5),
('Pó³ kostki twarogu pó³t³ustego', 5, 132, 3.7, 18.3, 4.7, 100),
('Serek wiejski naturalny', 14, 194, 4, 22, 10, 200),
('Szklanka jogurtu naturalnego', 4, 150, 15.5, 10.8, 5, 250),
('Szklanka kefiru naturalnego', 4, 122, 12, 8.6, 4.3, 240),
('Szklanka mleka 0%', 5, 77, 11.3, 7.7, 0, 240),
('Szklanka mleka 0.5%', 5, 90, 11.7, 7.8, 1.2, 230),
('Szklanka mleka 1.5%', 5, 108, 11.5, 7.6, 3.5, 230),
('Szklanka mleka 2%', 5, 117, 11.3, 7.6, 4.6, 230),
('Szklanka mleka 3.2%', 5, 140, 11, 7.4, 7.4, 230),
('¯ó³tko jaja kurzego', 5, 63, 0.1, 3.1, 5.6, 20),
('Bak³a¿an',1,26,3.8,1.1,0.1,100),
('Cebula',2,33,5.2,1.4,0.4,100),
('Czosnek',2,8,1.4,0.3,0.0,5),
('Cukinia',3,17,2.2,1.2,0.1,100),
('Passata pomidorowa',8,23,4,1.3,0.2,100),
('Szpinak',8,22,0.9,2.6,0.4,100),
('Ajwar',8,20,2.6,0.2,1.2,20),
('Soczewica',1,105,14.1,8.5,0.7,100),
('Czerwona fasola',8,87,12.3,8.1,0.6,100),
('Kukurydza',2,109,19.7,2.9,1.2,100),
('Groszek',8,73,10.1,4.9,0.2,100),
('Tofu naturalne',8,100,4.4,12,3.8,100),
('Tofu wêdzone',8,169,4.0,16.3,9.8,100),
('Ciecierzyca',8,120,14.7,6.4,2.2,100),
('Pomidor',3,19,2.9,0.9,0.2,100),
('Papryka',2,32,4.6,1.3,0.5,100),
('Ziemniak',1,71,15,1.8,0.1,100),
('Ogórek',3,14,2.4,0.7,0.1,100),
('Awokado',2,169,4.1,2.0,15.3,100),
('Marchew',2,33,5.1,1,0.2,100),
('Dynia',3,33,4.9,1.3,0.3,100),
('Kapusta bia³a',1,33,4.9,1.7,0.2,100),
('Kapusta pekiñska',1,16,1.3,1.2,0.2,100),
('Jarmu¿',2,36,2.3,3.3,0.7,100),
('Broku³',1,31,2.7,3.0,0.4,100),
('Kalafior',1,27,2.6,2.4,0.2,100),
('Fasolka szparagowa',2,27,3.6,1.2,0.3,100),
('Burak',2,37,6.5,1.6,0.1,100),
('Korzeñ selera',1,30,2.8,1.6,0.3,100),
('Natka pietruszki',1,3,0.3,0.3,0,6),
('Szczypiorek',1,2,0.1,0.2,0,5),
('Rzodkiewka',1,18,1.9,1,0.2,100),
('Por',1,29,3,2.2,0.3,100),
('Pietruszka',1,49,6.3,2.6,0.5,100),
('Podgrzybek',1,49,4,3.6,0.5,100),
('Pieczarka',3,21,2.6,2.7,0.4,100),
('Roszponka',3,21,3.6,2,0.4,100),
('Szparagi',3,21,2.2,1.9,0.2,100),
('Tempeh',8,339,23.4,20.3,11.2,100),
('Cykoria',1,23,3.1,1.7,0.2,100),
('Bób',1,76,8.2,7.1,0.4,100),
('Groszek cukrowy',1,42,7.5,2.8,0.2,100),
('Kurka',1,32,6.9,1.5,0.5,100),
('Papryka pepperoni',1,6,0.9,0.2,0.1,19),
('Koperek',1,1,0.1,0.1,0,4),
('Papryka habanero',1,5,0.8,0.2,0.1,17),
('Pomidor koktajlowy',2,19,2.9,0.9,0.2,100),
('Rukola',3,25,3.7,2.6,0.7,100),
('Sa³ata mas³owa',1,14,1.5,1.4,0.2,100),
('Sa³ata rzymska',1,16,1.5,1.4,0.2,100),
('Imbir',1,8,1.8,0.2,0.1,10),
('Seler naciowy',3,17,1.8,1,0.2,100),
('Jab³ko',2,50,10.1,0.4,0.4,100),
('Cytryna',1,4,0.8,0.1,0,10),
('Rabarbar',2,15,1.4,0.5,0.1,100),
('Banan',1,97,21.8,1,0.3,100),
('Pomarañcza',2,47,9.4,0.9,0.2,100),
('Mandarynka',1,45,9.3,0.6,0.3,100),
('Pomelo',1,38,9.6,0.8,0,100),
('Truskawka',2,33,5.8,0.7,0.4,100),
('Malina',3,43,5.3,1.3,0.3,100),
('Brzoskwinia',1,50,10,1,0.2,100),
('Nektarynka',3,50,10.6,0.9,0.2,100),
('Pitaja',2,50,11.8,1.4,0.3,100),
('Arbuz',3,36,8.1,0.6,0.1,100),
('Melon',3,34,0.2,0.8,0.2,100),
('Œliwka',3,49,10.1,0.6,0.3,100),
('Wiœnia',3,49,9.9,0.9,0.4,100),
('Czereœnia',3,63,13.3,1,0.3,100),
('Kiwi',3,60,11.8,0.9,0.5,100),
('Ananas',3,55,2.4,0.4,0.2,100),
('Papaja',2,44,9.2,0.6,0.1,100),
('Je¿yna',1,43,9.6,1.1,0.5,100),
('Olej kokosowy',8,54,0,0,6,6),
('Olej rzepakowy',8,88,0,0,10,10),
('Oliwa z oliwek',8,88,0,0,10,10),
('Olej lniany',8,90,0,0,10,10),
('Olej z awokado',8,71,0,0,8,8),
('Olej sezamowy',8,54,0,0,6,6),
('Olej s³onecznikowy',8,72,0,0,8,8)
INSERT INTO Posi³ki VALUES
('Kanapki z awokado i pomidorem',394.5,47.55,8.45,18.4),
('Makaron z tofu, ciecierzyc¹ i szpinakiem',880.4,78.35,43.1,40.2),
('Owsianka z owocami i nasionami',576.1,92.2,26.8,17.3),
('Rozgrzewaj¹ca owsianka na mleku',689,101.1,53.2,20),
('Pomidorowe spaghetti z soczewic¹',599,75,28.8,10.4),
('Tortilla z mozarell¹ i warzywami',688.5,67.9,38.3,28.75),
('Kasza jêczmienna z kurczakiem i warzywami', 468, 38.6, 43.8, 13.1),
('Jajecznica ze szczypiorkiem i pomidorami',250, 17.1,15.1,13.4),
('Tortilla zapiekana z serem i szynk¹', 698, 14.84, 14.52, 11.41),
('Dorsz z warzywami i br¹zowym ry¿em', 492,59.1, 21,18.5),
('Kanapki z jajkiem, ³ososiem i warzywami', 390, 45, 26.7,10.8),
('Pieczony pstr¹g w pomidorach z kasz¹ i warzywami', 702, 87.6, 33.9,23.5)

INSERT INTO Sk³adPosi³ków VALUES
(1,2,3),(1,147,0.5),(1,151,1),
(2,5,0.1),(2,14,1),(2,145,1),(2,134,1),(2,146,0.5),(2,138,2),(2,208,2),
(3,1,1),(3,11,0.3),(3,5,0.1),(3,35,0.1),(3,192,1),
(4,1,0.5),(4,131,1),(4,188,1),(4,193,1),(4,45,0.5),
(5,41,1), (5,96,1),(5,137,2),(5,140,1),(5,136,1),
(6,33,1),(6,104,0.5),(6,147,0.5),(6,148,0.5),(6,169,0.5),(6,139,1),
(7,168,2), (7,136,1),(7,208,1), (7,49,1.5),(7,28,0.5),
(8,4,1), (8,99,2), (8,147,1.7),(8,163,1), (8,208,1),
(9,33,1.2), (9,63,0.6),(9,119,4),
(10, 208,2),(10,166,0.8),(10,152,0.45),(10,134,0.5),(10,161,0.5), (10,58,1),(10,9,0.75),
(11,4,3),(11,50,0.6), (11,98,2), (11,150,3), (11,163,3), (11,180,1),
(12,180,1),(12,134,0.5),(12,142,0.6),(12,147,1.7),(12,148,1.4),(12,186,0.1),(12,208,1),(12,80,2.3),(12,28,0.75)
INSERT INTO Jad³ospisy VALUES
('Jad³ospis wegañski',1851,218.1,78.35,75.9),
('Zimowy jad³ospis wegetariañski',1976.5,244,120.3,59.15),
('Jad³ospis redukcyjny dla jedz¹cych miêso', 1416, 70.54,73.42,37.91),
('Jad³ospis wegetariañski zawieraj¹cy ryby', 1584, 191.7, 135.3, 52.8)
INSERT INTO Sk³adJad³ospisów VALUES
(1,1),(1,2),(1,3),
(2,4),(2,5),(2,6),
(3,7),(3,8),(3,9),
(4,10),(4,11),(4,12)
INSERT INTO TagiPosi³ków VALUES
(1,1),(1,2),(1,3),(1,5),
(2,1),(2,2),(2,3),(2,5),
(3,1),(3,2),(3,3),(3,5),
(4,1),(4,2),
(5,1),(5,2),
(6,1),(6,2),
(7,5),(7,4),
(8,1), (8,2),
(9,5),
(10,2),(10,5),(10,6),
(11,2),
(12,2),(12,5)

INSERT INTO TagiProduktów VALUES
(89,1),(89,2),(89,6),
(90,1),(90,2),(90,6),
(91,1),(91,2),(91,6),
(92,1),(92,2),(92,6),
(93,1),(93,2),(93,6),
(94,1),(94,2),(94,6),
(95,1),(95,2),(95,6),
(96,1),(96,2),(96,6),
(97,1),(97,2),(97,6),
(98,1),(98,2),(98,6),
(99,1),(99,2),(99,6),
(100,1),(100,2),(100,6),
(101,1),(101,2),(101,6),
(102,1),(102,2),(102,6),
(103,1),(103,2),(103,6),
(104,1),(104,2),(104,6),
(105,1),(105,2),(105,6),
(106,1),(106,2),(106,6),
(107,1),(107,2),(107,6),
(108,1),(108,2),(108,6),
(109,1),(109,2),(109,6),
(110,1),(110,2),(110,6),
(111,1),(111,2),(111,6),
(112,1),(112,2),(112,6),
(113,1),(113,2),(113,6),
(114,1),(114,2),(114,6),
(115,1),(115,2),(115,6),
(116,1),(116,2),(116,6),
(117,1),(117,2),(117,6),
(118,1),(118,2),(118,6),
(119,1),(119,2),(119,6),
(120,1),(120,2),(120,6),
(121,1),(121,2),(121,6),
(122,1),(122,2),(122,6),
(123,1),(123,2),(123,6),
(124,1),(124,2),(124,6),
(125,1),(125,2),(125,6),
(126,1),(126,2),(126,6),
(127,1),(127,2),(127,6),
(128,1),(128,2),(128,6),
(129,1),(129,2),(129,6),
(130,1),(130,2),(130,6),
(131,1),(131,2),(131,6),
(132,1),(132,2),(132,6),
(133,1),(133,2),(133,3),(133,5),(133,6),
(134,1),(134,2),(134,3),(134,5),(134,6),
(135,1),(135,2),(135,3),(135,5),(135,6),
(136,1),(136,2),(136,3),(136,5),(136,6),
(137,1),(137,2),(137,3),(137,5),(137,6),
(138,1),(138,2),(138,3),(138,5),(138,6),
(139,1),(139,2),(139,3),(139,5),(139,6),
(140,1),(140,2),(140,3),(140,5),(140,6),
(141,1),(141,2),(141,3),(141,5),(141,6),
(142,1),(142,2),(142,3),(142,5),(142,6),
(143,1),(143,2),(143,3),(143,5),(143,6),
(144,1),(144,2),(144,3),(144,5),(144,6),
(145,1),(145,2),(145,3),(145,5),(145,6),
(146,1),(146,2),(146,3),(146,5),(146,6),
(147,1),(147,2),(147,3),(147,5),(147,6),
(148,1),(148,2),(148,3),(148,5),(148,6),
(149,1),(149,2),(149,3),(149,5),(149,6),
(150,1),(150,2),(150,3),(150,5),(150,6),
(151,1),(151,2),(151,3),(151,5),(151,6),
(152,1),(152,2),(152,3),(152,5),(152,6),
(153,1),(153,2),(153,3),(153,5),(153,6),
(154,1),(154,2),(154,3),(154,5),(154,6),
(155,1),(155,2),(155,3),(155,5),(155,6),
(156,1),(156,2),(156,3),(156,5),(156,6),
(157,1),(157,2),(157,3),(157,5),(157,6),
(158,1),(158,2),(158,3),(158,5),(158,6),
(159,1),(159,2),(159,3),(159,5),(159,6),
(160,1),(160,2),(160,3),(160,5),(160,6),
(161,1),(161,2),(161,3),(161,5),(161,6),
(162,1),(162,2),(162,3),(162,5),(162,6),
(163,1),(163,2),(163,3),(163,5),(163,6),
(164,1),(164,2),(164,3),(164,5),(164,6),
(165,1),(165,2),(165,3),(165,5),(165,6),
(166,1),(166,2),(166,3),(166,5),(166,6),
(167,1),(167,2),(167,3),(167,5),(167,6),
(168,1),(168,2),(168,3),(168,5),(168,6),
(169,1),(169,2),(169,3),(169,5),(169,6),
(170,1),(170,2),(170,3),(170,5),(170,6),
(171,1),(171,2),(171,3),(171,5),(171,6),
(172,1),(172,2),(172,3),(172,5),(172,6),
(173,1),(173,2),(173,3),(173,5),(173,6),
(174,1),(174,2),(174,3),(174,5),(174,6),
(175,1),(175,2),(175,3),(175,5),(175,6),
(176,1),(176,2),(176,3),(176,5),(176,6),
(177,1),(177,2),(177,3),(177,5),(177,6),
(178,1),(178,2),(178,3),(178,5),(178,6),
(179,1),(179,2),(179,3),(179,5),(179,6),
(180,1),(180,2),(180,3),(180,5),(180,6),
(181,1),(181,2),(181,3),(181,5),(181,6),
(182,1),(182,2),(182,3),(182,5),(182,6),
(183,1),(183,2),(183,3),(183,5),(183,6),
(184,1),(184,2),(184,3),(184,5),(184,6),
(185,1),(185,2),(185,3),(185,5),(185,6),
(186,1),(186,2),(186,3),(186,5),(186,6),
(187,1),(187,2),(187,3),(187,5),(187,6),
(188,1),(188,2),(188,3),(188,5),(188,6),
(189,1),(189,2),(189,3),(189,5),(189,6),
(190,1),(190,2),(190,3),(190,5),(190,6),
(191,1),(191,2),(191,3),(191,5),(191,6),
(192,1),(192,2),(192,3),(192,5),(192,6),
(193,1),(193,2),(193,3),(193,5),(193,6),
(194,1),(194,2),(194,3),(194,5),(194,6),
(195,1),(195,2),(195,3),(195,5),(195,6),
(196,1),(196,2),(196,3),(196,5),(196,6),
(197,1),(197,2),(197,3),(197,5),(197,6),
(198,1),(198,2),(198,3),(198,5),(198,6),
(199,1),(199,2),(199,3),(199,5),(199,6),
(200,1),(200,2),(200,3),(200,5),(200,6),
(201,1),(201,2),(201,3),(201,5),(201,6),
(202,1),(202,2),(202,3),(202,5),(202,6),
(203,1),(203,2),(203,3),(203,5),(203,6),
(204,1),(204,2),(204,3),(204,5),(204,6),
(205,1),(205,2),(205,3),(205,5),(205,6),
(206,1),(206,2),(206,3),(206,5),(206,6),
(207,1),(207,2),(207,3),(207,5),(207,6),
(208,1),(208,2),(208,3),(208,5),(208,6),
(209,1),(209,2),(209,3),(209,5),(209,6),
(210,1),(210,2),(210,3),(210,5),(210,6),
(211,1),(211,2),(211,3),(211,5),(211,6),
(212,1),(212,2),(212,3),(212,5),(212,6)

INSERT INTO Æwiczenia
VALUES
('Aerobik(Intensywnie)',255,30),
('Aerobik(Spokojnie)',182,30),
('Aerobik(Umiarkowane tempo',210,30),
('Aerobik z ciê¿arkami (4.5-6.5 kg)',350,30),
('Aqua Aerobik',192,30),
('Badminton',200,30),
('Bieganie 6 km/h (trucht)',105,15),
('Bieganie 7 km/h',135,15),
('Bieganie 8 km/h',145,15),
('Bieganie 9 km/h',168,15),
('Bieganie 10 km/h',184,15),
('Bieganie 11 km/h',193,15),
('Bieganie 12 km/h',207,15),
('Bieganie 13 km/h',235,15),
('Bieganie 14 km/h',250,15),
('Bieganie 15 km/h',268,15),
('Bieganie 16 km/h',284,15),
('Bieganie 17 km/h (sprint)',301,15),
('Boks',325,30),
('Brzuszki niepe³ne',33,10),
('Brzuszki pe³ne (energiczne)',93,10),
('Brzuszki pe³ne (spokojne tempo)',32,10),
('Brzuszki pe³ne (umiarkowane tempo)',44,10),
('Chodzenie 3km/h',84,30),
('Chodzenie 4km/h',102,30),
('Chodzenie 5km/h',123,30),
('Hula hop',70,15),
('Jazda na ³y¿wach',123,15),
('Jazda na nartach biegówkach',287,30),
('Jazda na nartach wodnych',245,30),
('Jazda na nartach zjazdowych',255,30),
('Jazda na rolkach',245,30),
('Jazda na rowerze 10km/h',245,60),
('Jazda na rowerze 11-15km/h',280,60),
('Jazda na rowerze 16-19km/h',476,60),
('Jazda na rowerze 20-22km/h',560,60),
('Jazda na rowerze 23-25km/h',700,60),
('Jazda na rowerze 25-30km/h',840,60),
('Jazda na snowboardzie',490,60),
('Joga',175,60),
('Judo',350,30),
('Karate',350,30),
('Kolarstwo górskie',595,60),
('Koszykówka',280,30),
('Nordic Walking 7km/h',504,60),
('Nordic Walking 6km/h',476,60),
('Nordic Walking 5km/h',392,60),
('Nordic Walking 4km/h',308,60),
('Snorkeling',175,30),
('Nurkowanie ze sprzêtem',245,30),
('Pilates',210,60),
('Pi³ka no¿na',630,60),
('Pi³ka rêczna',840,60),
('P³ywanie kraulem',175,15),
('P³ywanie stylem grzbietowym',166,15),
('P³ywanie stylem klasycznym',180,15),
('P³ywanie stylem motylkowym',240,15),
('Podci¹ganie',44,10),
('Pompki',44,10),
('Przysiady wykroczne',44,10),
('Przysiady',58,10),
('Siatkówka',140,30),
('Siatkówka pla¿owa',280,30),
('Siatkówka wodna',185,30),
('Skakanka (intensywnie)',192,15),
('Skakanka (spokojnie)',143,15),
('Spacer',245,60),
('Squash',420,30),
('Step aerobik',385,60),
('Steper',82,10),
('Tenis',280,30),
('Rozci¹ganie',27,10),
('Trucht',105,15),
('Orbitrek',175,30),
('Schody',51,10),
('Wspinaczka',280,30),
('Zumba',476,60)

INSERT INTO Treningi
VALUES
('Wzmacnianie pleców','Umiarkowany'),
('Wzmacnianie nóg','Umiarkowany'),
('Aerobik','£atwy'),
('Bieganie szybkie','Trudny'),
('Bieganie dla pocz¹tkuj¹cych','£atwy'),
('Trening bokserski','Umiarkowany'),
('Wzmacnianie miêœni brzucha','Umiarkowany'),
('Trening ³y¿wiarski','Umiarkowany'),
('Trening narciarsko-snowboardowy','Trudny'),
('Sztuki walki','Umiarkowany'),
('Trening p³ywacki','Trudny'),
('Cardio dla pocz¹tkuj¹cych','£atwy'),
('Pilates','£atwy'),
('Trening pi³karski','Umiarkowany'),
('Trening pi³ki rêcznej','Umiarkowany'),
('Trening koszykarski','Trudny'),
('Trening kolarski','Trudny')
--Tagi æwiczeñ
INSERT INTO TagiÆwiczeñ
VALUES
(1,11),(1,14),
(2,11),(2,14),
(3,11),(3,14),
(4,11),
(5,11),(5,18),
(6,15),
(7,11),(7,13),(7,14),(7,16),
(8,11),(8,13),(8,14),(8,16),
(9,11),(9,13),(9,14),(9,16),
(10,11),(10,13),(10,14),(10,16),
(11,11),(11,13),(11,14),(11,16),
(12,11),(12,13),(12,14),(12,16),
(13,11),(13,13),(13,14),(13,16),
(14,11),(14,13),(14,14),(14,16),
(15,11),(15,13),(15,14),(15,16),
(16,11),(16,13),(16,14),(16,16),
(17,11),(17,13),(17,14),(17,16),
(18,11),(18,13),(18,14),(18,16),
(19,9),(19,11),
(20,7),(20,12),(20,14),(20,16),
(21,7),(21,12),(21,14),(21,16),
(22,7),(22,12),(22,14),(22,16),
(23,7),(23,12),(23,14),(23,16),
(24,11),(24,13),(24,14),(24,16),
(25,11),(25,13),(25,14),(25,16),
(26,11),(26,13),(26,14),(26,16),
(27,11),(27,16),
(28,11),(28,16),(28,17),
(29,11),(29,13),(29,16),(29,17),
(30,16),(30,18),
(31,13),(31,16),(31,17),
(32,11),(32,13),(32,16),
(33,11),(33,13),(33,16),
(34,11),(34,13),(34,16),
(35,11),(35,13),(35,16),
(36,11),(36,13),(36,16),
(37,11),(37,13),(37,16),
(38,11),(38,13),(38,16),
(39,13),(39,16),(39,17),
(40,16),
(41,14),
(42,16),
(43,13),(43,16),
(44,15),
(45,11),(45,13),(45,16),
(46,11),(46,13),(46,16),
(47,11),(47,13),(47,16),
(48,11),(48,13),(48,16),
(49,16),(49,18),
(50,18),
(51,14),
(52,15),
(53,15),
(54,11),(54,16),(54,18),
(55,11),(55,16),(55,18),(56,11),
(56,16),(56,18),
(57,11),(57,16),(57,18),
(58,9),(58,10),(58,12),
(59,9),(59,10),(59,12),(59,14),(59,16),
(60,8),(60,12),(60,16),
(61,8),(61,12),(61,16),
(62,15),
(63,15),
(64,15),(64,18),
(65,11),(65,16),
(66,11),(66,16),
(67,11),(67,13),(67,14),(67,16),
(68,15),
(69,11),
(70,11),
(71,11),(71,15),
(72,14),(72,16),
(73,11),(73,13),(73,14),(73,16),
(74,11),(74,16),
(75,16),
(76,9),(76,10),
(77,11),(77,14)

--Tagi Treningów
INSERT INTO TagiTreningów
VALUES
(1,10),(1,9),(1,12),(1,16),
(2,8),(2,12),(2,16),
(3,11),(3,14),
(4,11),(4,13),(4,14),(4,16),
(5,11),(5,13),(5,14),(5,16),
(6,15),
(7,12),(7,14),(7,16),
(8,16),(8,17),
(9,16),(9,17),
(10,15),
(11,11),(11,16),(11,18),
(12,11),(12,16),
(13,11),
(14,15),
(15,15),
(16,15),
(17,13),(17,16)

INSERT INTO Sk³adTreningu
VALUES
(1,73,1),
(1,59,1),
(1,58,2),
(1,72,1),
(2,8,1),
(2,75,2),
(2,61,1),
(2,60,1),
(2,70,1),
(3,1,1),
(3,2,1),
(4,11,2),
(4,13,1),
(5,7,1),
(5,9,1),
(6,70,1),
(6,19,2),
(7,20,1),
(7,21,1),
(7,23,1),
(7,72,1),
(8,32,1),
(8,28,2),
(9,31,1),
(9,39,1),
(10,73,1),
(10,41,1),
(10,42,1),
(10,72,1),
(11,54,1),
(11,55,1),
(11,56,1),
(11,57,1),
(12,73,1),
(12,66,1),
(13,51,1),
(13,72,1),
(14,65,1),
(14,52,1),
(15,59,1),
(15,53,1),
(15,72,1),
(16,65,1),
(16,44,2),
(17,36,1),
(17,38,1)

--FUNCTION

IF OBJECT_ID('WyœwietlZnajomych','IF') IS NOT NULL
DROP FUNCTION WyœwietlZnajomych
IF OBJECT_ID ('WyœwietlZapisaneTreningi') IS NOT NULL
DROP FUNCTION WyœwietlZapisaneTreningi
IF OBJECT_ID ('WyœwietlZaplanowaneTreningi') IS NOT NULL
DROP FUNCTION WyœwietlZaplanowaneTreningi
IF OBJECT_ID ('WyœwietlOcenioneTreningi') IS NOT NULL
DROP FUNCTION WyœwietlOcenioneTreningi
IF OBJECT_ID ('WyœwietlZapisaneJad³ospisy') IS NOT NULL
DROP FUNCTION WyœwietlZapisaneJad³ospisy
IF OBJECT_ID ('WyœwietlZaplanowaneJad³ospisy') IS NOT NULL
DROP FUNCTION WyœwietlZaplanowaneJad³ospisy
IF OBJECT_ID ('WyœwietlOcenioneJad³ospisy') IS NOT NULL
DROP FUNCTION WyœwietlOcenioneJad³ospisy
IF OBJECT_ID ('WyœwietlZaplanowaneTreningiNaDziœ') IS NOT NULL
DROP FUNCTION WyœwietlZaplanowaneTreningiNaDziœ
IF OBJECT_ID ('WyœwietlZaplanowaneJad³ospisyNaDziœ') IS NOT NULL
DROP FUNCTION WyœwietlZaplanowaneJad³ospisyNaDziœ
IF OBJECT_ID ('WyœwietlPomiary') IS NOT NULL
DROP FUNCTION WyœwietlPomiary
IF OBJECT_ID ('WyœwietlSk³adTreningu') IS NOT NULL
DROP FUNCTION WyœwietlSk³adTreningu
IF OBJECT_ID ('WyœwietlSk³adJad³ospisu') IS NOT NULL
DROP FUNCTION WyœwietlSk³adJad³ospisu
IF OBJECT_ID ('WyœwietlSk³adPosi³ku') IS NOT NULL
DROP FUNCTION WyœwietlSk³adPosi³ku
IF OBJECT_ID ('WyœwietlTreningPoTagu') IS NOT NULL
DROP FUNCTION WyœwietlTreningPoTagu
IF OBJECT_ID ('WyœwietlÆwiczeniePoTagu') IS NOT NULL
DROP FUNCTION WyœwietlÆwiczeniePoTagu
IF OBJECT_ID ('WyœwietlPosi³ekPoTagu') IS NOT NULL
DROP FUNCTION WyœwietlPosi³ekPoTagu
IF OBJECT_ID ('WyœwietlProduktPoTagu') IS NOT NULL
DROP FUNCTION WyœwietlProduktPoTagu
IF OBJECT_ID ('WyœwietlListêZakupów') IS NOT NULL
DROP FUNCTION WyœwietlListêZakupów
IF OBJECT_ID ('ObliczProcentTkankiT³uszczowej') IS NOT NULL
DROP FUNCTION ObliczProcentTkankiT³uszczowej
GO


CREATE FUNCTION ObliczProcentTkankiT³uszczowej(@NazwaU¿ytkownika VARCHAR(20))
RETURNS FLOAT
BEGIN
	DECLARE @wynik FLOAT, @waga INT, @obwód INT
	SET @waga=(SELECT Top 1 AktualnePomiary.Waga FROM U¿ytkownicy JOIN AktualnePomiary ON U¿ytkownicy.IDU¿ytkownika=AktualnePomiary.IDU¿ytkownika
	WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika
	ORDER BY AktualnePomiary.CzasPomiaru DESC)
	SET @obwód=(SELECT Top 1 AktualnePomiary.ObwódPasa FROM U¿ytkownicy JOIN AktualnePomiary ON U¿ytkownicy.IDU¿ytkownika=AktualnePomiary.IDU¿ytkownika
	WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika
	ORDER BY AktualnePomiary.CzasPomiaru DESC)
	SET @wynik=((((4.15*@obwód)/2.54)-0.082*@waga*2.2-88)/(@waga*2.2))*100
	RETURN @wynik
END
GO

CREATE FUNCTION WyœwietlListêZakupów (@NazwaU¿ytkownika VARCHAR(100), @NazwaSklepu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT P.NazwaProduktu, P.MasaPorcji, S.IloœæPorcji FROM 
	Sk³adListyZakupów S JOIN ListaZakupów L ON S.IDListy = L.IDListy
	JOIN U¿ytkownicy U ON U.IDU¿ytkownika = L.IDU¿ytkownika
	JOIN Produkty P ON S.IDProduktu = P.IDProduktu
	WHERE U.NazwaU¿ytkownika = @NazwaU¿ytkownika AND L.NazwaSklepu = @NazwaSklepu
)
GO

CREATE FUNCTION WyœwietlTreningPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.StopieñTrudnoœci
	FROM Treningi JOIN TagiTreningów ON Treningi.IDTreningu=TagiTreningów.IDTreningu
	JOIN Tag ON Tag.IDTagu=TagiTreningów.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyœwietlÆwiczeniePoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Æwiczenia.NazwaÆwiczenia, Æwiczenia.SpaloneKcal, Æwiczenia.CzasWykonywania
	FROM Æwiczenia JOIN TagiÆwiczeñ ON Æwiczenia.IDÆwiczenia=TagiÆwiczeñ.IDÆwiczenia
	JOIN Tag ON Tag.IDTagu=TagiÆwiczeñ.IDTagu 
	WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyœwietlPosi³ekPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Posi³ki.NazwaPosi³ku, Posi³ki.Kalorie, Posi³ki.Wêglowodany, Posi³ki.Bia³ka, Posi³ki.T³uszcze
	FROM Posi³ki JOIN TagiPosi³ków ON Posi³ki.IDPosi³ku=TagiPosi³ków.IDPosi³ku
	JOIN Tag ON Tag.IDTagu=TagiPosi³ków.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyœwietlProduktPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Produkty.NazwaProduktu, Produkty.Kalorie, Produkty.Wêglowodany, Produkty.Bia³ka, Produkty.T³uszcze
	FROM Produkty JOIN TagiProduktów ON Produkty.IDProduktu=TagiProduktów.IDProduktu
	JOIN Tag ON Tag.IDTagu=TagiProduktów.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyœwietlSk³adPosi³ku (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT Pr.NazwaProduktu, Pr.Kalorie, Pr.Wêglowodany, Pr.Bia³ka, Pr.T³uszcze, Pr.MasaPorcji FROM
	Posi³ki P JOIN Sk³adPosi³ków SP ON P.IDPosi³ku = SP.IDPosi³ku
	JOIN Produkty Pr ON SP.IDProduktu = Pr.IDProduktu
	WHERE P.NazwaPosi³ku = @Nazwa
)
GO

CREATE FUNCTION WyœwietlSk³adJad³ospisu (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT P.NazwaPosi³ku, P.Kalorie, P.Wêglowodany, P.Bia³ka, P.T³uszcze FROM
	Jad³ospisy J JOIN Sk³adJad³ospisów SJ ON J.IDJad³ospisu = SJ.IDJad³ospisu
	JOIN Posi³ki P ON SJ.IDPosi³ku = P.IDPosi³ku
	WHERE J.NazwaJad³ospisu = @Nazwa
)
GO

CREATE FUNCTION WyœwietlSk³adTreningu (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT C.NazwaÆwiczenia, C.SpaloneKcal, C.CzasWykonywania FROM
	Treningi T JOIN Sk³adTreningu ST ON T.IDTreningu = ST.IDTreningu
	JOIN Æwiczenia C ON ST.IDÆwiczenia = C.IDÆwiczenia
	WHERE T.NazwaTreningu = @Nazwa
)
GO

CREATE FUNCTION WyœwietlPomiary(@NazwaU¿ytkownika VARCHAR(20))
RETURNS TABLE AS
RETURN
(
	SELECT AktualnePomiary.CzasPomiaru, AktualnePomiary.Waga , AktualnePomiary.ObwódPasa
	FROM AktualnePomiary
	JOIN U¿ytkownicy ON AktualnePomiary.IDU¿ytkownika=U¿ytkownicy.IDU¿ytkownika

)
GO

CREATE FUNCTION WyœwietlZapisaneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.StopieñTrudnoœci
    FROM U¿ytkownicy JOIN ZapisaneTreningi ON U¿ytkownicy.IDU¿ytkownika=ZapisaneTreningi.IDU¿ytkownika JOIN Treningi ON ZapisaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa
)
GO

CREATE FUNCTION WyœwietlZaplanowaneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT ZaplanowaneTreningi.DataRozpoczêcia, ZaplanowaneTreningi.DataZakoñczenia , Treningi.NazwaTreningu, Treningi.StopieñTrudnoœci
    FROM U¿ytkownicy JOIN ZaplanowaneTreningi ON U¿ytkownicy.IDU¿ytkownika=ZaplanowaneTreningi.IDU¿ytkownika JOIN Treningi ON ZaplanowaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa
)
GO

CREATE FUNCTION WyœwietlOcenioneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, OcenioneTreningi.Ocena
    FROM U¿ytkownicy JOIN OcenioneTreningi ON U¿ytkownicy.IDU¿ytkownika=OcenioneTreningi.IDU¿ytkownika
	JOIN Treningi ON OcenioneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa
)
GO

CREATE FUNCTION WyœwietlZapisaneJad³ospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Jad³ospisy.NazwaJad³ospisu, Jad³ospisy.Kalorie, Jad³ospisy.Wêglowodany, Jad³ospisy.Bia³ka, Jad³ospisy.T³uszcze
    FROM U¿ytkownicy JOIN ZapisaneJad³ospisy ON U¿ytkownicy.IDU¿ytkownika=ZapisaneJad³ospisy.IDU¿ytkownika
	JOIN Jad³ospisy ON ZapisaneJad³ospisy.IDJad³ospisu=Jad³ospisy.IDJad³ospisu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa
)
GO

CREATE FUNCTION WyœwietlZaplanowaneJad³ospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT ZaplanowaneJad³ospisy.Data, Jad³ospisy.NazwaJad³ospisu, Jad³ospisy.Kalorie, Jad³ospisy.Wêglowodany, Jad³ospisy.Bia³ka, Jad³ospisy.T³uszcze
    FROM U¿ytkownicy JOIN ZaplanowaneJad³ospisy ON U¿ytkownicy.IDU¿ytkownika=ZaplanowaneJad³ospisy.IDU¿ytkownika
	JOIN Jad³ospisy ON ZaplanowaneJad³ospisy.IDJad³ospisu=Jad³ospisy.IDJad³ospisu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa
)
GO

CREATE FUNCTION WyœwietlOcenioneJad³ospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(SELECT Jad³ospisy.NazwaJad³ospisu, OcenioneJad³ospisy.Ocena
        FROM U¿ytkownicy JOIN OcenioneJad³ospisy ON U¿ytkownicy.IDU¿ytkownika=OcenioneJad³ospisy.IDU¿ytkownika
		JOIN Jad³ospisy ON OcenioneJad³ospisy.IDJad³ospisu=Jad³ospisy.IDJad³ospisu
        WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa
)
GO

CREATE FUNCTION WyœwietlZaplanowaneTreningiNaDziœ (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.StopieñTrudnoœci
    FROM U¿ytkownicy JOIN ZaplanowaneTreningi ON U¿ytkownicy.IDU¿ytkownika=ZaplanowaneTreningi.IDU¿ytkownika
	JOIN Treningi ON ZaplanowaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa 
	AND CONVERT(DATE,GETDATE()) BETWEEN ZaplanowaneTreningi.DataRozpoczêcia AND ZaplanowaneTreningi.DataZakoñczenia
)
GO

CREATE FUNCTION WyœwietlZaplanowaneJad³ospisyNaDziœ (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Jad³ospisy.NazwaJad³ospisu, Jad³ospisy.Kalorie, Jad³ospisy.Wêglowodany, Jad³ospisy.Bia³ka, Jad³ospisy.T³uszcze
    FROM U¿ytkownicy JOIN ZaplanowaneJad³ospisy ON U¿ytkownicy.IDU¿ytkownika=ZaplanowaneJad³ospisy.IDU¿ytkownika
	JOIN Jad³ospisy ON ZaplanowaneJad³ospisy.IDJad³ospisu=Jad³ospisy.IDJad³ospisu
    WHERE U¿ytkownicy.NazwaU¿ytkownika=@Nazwa 
	AND (SELECT DATEDIFF(day,GETDATE(),ZaplanowaneJad³ospisy.Data)) = 0
)
GO

CREATE FUNCTION WyœwietlZnajomych(@nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN(
SELECT C.NazwaU¿ytkownika
FROM U¿ytkownicy A
JOIN Znajomi B ON A.IDU¿ytkownika=B.IDU¿ytkownika1
JOIN U¿ytkownicy C ON B.IDU¿ytkownika2=C.IDU¿ytkownika
WHERE A.NazwaU¿ytkownika=@nazwa
)
GO
--TRIGGER

IF OBJECT_ID ('U¿ytkownicyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER U¿ytkownicyTrigger
IF OBJECT_ID ('OcenioneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneTreningiTrigger
IF OBJECT_ID ('OcenioneTreningiUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneTreningiUpdateTrigger
IF OBJECT_ID ('OcenioneJad³ospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneJad³ospisyTrigger
IF OBJECT_ID ('OcenioneJad³ospisyUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneJad³ospisyUpdateTrigger
IF OBJECT_ID ('ZaplanowaneJad³ospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZaplanowaneJad³ospisyTrigger
IF OBJECT_ID ('ZaplanowaneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZaplanowaneTreningiTrigger
IF OBJECT_ID ('ZnajomiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZnajomiTrigger
IF OBJECT_ID ('ZapisaneJad³ospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZapisaneJad³ospisyTrigger
IF OBJECT_ID ('ZapisaneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZapisaneTreningiTrigger
IF OBJECT_ID ('PomiaryUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER PomiaryUpdateTrigger

GO
CREATE TRIGGER PomiaryUpdateTrigger
ON AktualnePomiary
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDU¿ytkownika INT, @Data DATETIME, @Waga INT, @ObwódPasa INT
	SELECT @IDU¿ytkownika = INSERTED.IDU¿ytkownika,
	@Data = SYSDATETIME(),
	@Waga = INSERTED.Waga,
	@ObwódPasa = INSERTED.ObwódPasa FROM INSERTED
	IF (@Waga > 0 AND @ObwódPasa>0)
	BEGIN
		INSERT INTO AktualnePomiary VALUES
				(@IDU¿ytkownika, @Data, @Waga, @ObwódPasa)
	END
	ELSE
		RAISERROR('Waga lub obwód pasa ujemne', 16,1)
END
GO

CREATE TRIGGER ZapisaneTreningiTrigger
ON ZapisaneTreningi
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @IDU¿ytkownika INT, @IDTreningu INT
	SELECT
	@IDU¿ytkownika = inserted.IDU¿ytkownika,
	@IDTreningu = inserted.IDTreningu
	FROM INSERTED
	IF EXISTS (SELECT * FROM ZapisaneTreningi WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDTreningu = @IDTreningu)
		RAISERROR('Zapisa³eœ ju¿ ten trening', 16,1)
	ELSE
		INSERT INTO ZapisaneTreningi VALUES
		(@IDU¿ytkownika, @IDTreningu)

END
GO


CREATE TRIGGER ZapisaneJad³ospisyTrigger
ON ZapisaneJad³ospisy
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT
	SELECT
	@IDU¿ytkownika = inserted.IDU¿ytkownika,
	@IDJad³ospisu = inserted.IDJad³ospisu
	FROM INSERTED
	IF EXISTS (SELECT * FROM ZapisaneJad³ospisy WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDJad³ospisu = @IDJad³ospisu)
		RAISERROR('Zapisa³eœ ju¿ ten jad³ospis', 16,1)
	ELSE
		INSERT INTO ZapisaneJad³ospisy VALUES
		(@IDU¿ytkownika, @IDJad³ospisu)

END
GO

CREATE TRIGGER ZnajomiTrigger
ON Znajomi
INSTEAD OF INSERT
AS
BEGIN
	DECLARE	@IDU¿ytkownika1 INT, @IDU¿ytkownika2 INT
	SELECT @IDU¿ytkownika1=INSERTED.IDU¿ytkownika1,
	@IDU¿ytkownika2=INSERTED.IDU¿ytkownika2
	FROM INSERTED
		IF EXISTS (SELECT IDU¿ytkownika1 FROM Znajomi WHERE IDU¿ytkownika1 = @IDU¿ytkownika1 AND IDU¿ytkownika2 = @IDU¿ytkownika2)
			BEGIN
				RAISERROR('Taka znajomoœæ ju¿ istnieje', 16,1)
			END
		ELSE
			BEGIN
				INSERT INTO Znajomi VALUES
					(@IDU¿ytkownika1,@IDU¿ytkownika2),(@IDU¿ytkownika2,@IDU¿ytkownika1)
			END 
END
GO

CREATE TRIGGER ZaplanowaneTreningiTrigger
ON ZaplanowaneTreningi
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDU¿ytkownika INT, @IDTreningu INT, @DataRozpoczêcia DATE, @DataZakoñczenia DATE
	SELECT @IDU¿ytkownika = INSERTED.IDU¿ytkownika,
	@IDTreningu = INSERTED.IDTreningu,
	@DataRozpoczêcia = INSERTED.DataRozpoczêcia,
	@DataZakoñczenia = INSERTED.DataZakoñczenia FROM INSERTED
	IF (@DataRozpoczêcia <= @DataZakoñczenia)
		INSERT INTO ZaplanowaneTreningi VALUES
		(@IDU¿ytkownika, @IDTreningu, @DataRozpoczêcia, @DataZakoñczenia)
	ELSE
		RAISERROR('Data rozpoczêcia jest póŸniejsza ni¿ data zakoñczenia', 16,1)
END
GO

CREATE TRIGGER ZaplanowaneJad³ospisyTrigger
ON ZaplanowaneJad³ospisy
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT, @Data DATE
	SELECT @IDU¿ytkownika = INSERTED.IDU¿ytkownika,
	@IDJad³ospisu = INSERTED.IDJad³ospisu,
	@Data = INSERTED.Data FROM INSERTED
	IF NOT EXISTS (SELECT * FROM ZaplanowaneJad³ospisy WHERE ZaplanowaneJad³ospisy.IDU¿ytkownika=@IDU¿ytkownika AND ZaplanowaneJad³ospisy.Data=@Data )
		INSERT INTO ZaplanowaneJad³ospisy VALUES
		(@IDU¿ytkownika, @IDJad³ospisu, @Data)
	ELSE
		RAISERROR('Na ten dzieñ jest ju¿ zaplanowany jad³ospis', 16,1)
END
GO


CREATE TRIGGER OcenioneJad³ospisyTrigger
ON OcenioneJad³ospisy
INSTEAD OF INSERT
AS BEGIN
	DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT, @Ocena INT
	SELECT
	@IDU¿ytkownika = inserted.IDU¿ytkownika,
	@IDJad³ospisu = inserted.IDJad³ospisu,
	@Ocena = inserted.Ocena
	FROM INSERTED
	IF EXISTS (SELECT * FROM OcenioneJad³ospisy WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDJad³ospisu = @IDJad³ospisu)
		RAISERROR('Doda³eœ ju¿ ocenê do tego jad³ospisu', 16,1)
	ELSE
		IF (@Ocena BETWEEN 1 AND 5)
			INSERT INTO OcenioneJad³ospisy VALUES
			(@IDU¿ytkownika, @IDJad³ospisu, @Ocena)
		ELSE
			RAISERROR('Ocena nie zawiera siê w skali', 16,1)

END
GO


CREATE TRIGGER OcenioneTreningiTrigger
ON OcenioneTreningi
INSTEAD OF INSERT
AS BEGIN
	DECLARE @IDU¿ytkownika INT, @IDTreningu INT, @Ocena INT
	SELECT
	@IDU¿ytkownika = inserted.IDU¿ytkownika,
	@IDTreningu = inserted.IDTreningu,
	@Ocena = inserted.Ocena
	FROM INSERTED
	IF EXISTS (SELECT * FROM OcenioneTreningi WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDTreningu = @IDTreningu)
		RAISERROR('Doda³eœ ju¿ ocenê do tego treningu', 16,1)
	ELSE
		IF (@Ocena BETWEEN 1 AND 5)
			INSERT INTO OcenioneTreningi VALUES
			(@IDU¿ytkownika, @IDTreningu, @Ocena)
		ELSE
			RAISERROR('Ocena nie zawiera siê w skali', 16,1)

END
GO

CREATE TRIGGER OcenioneTreningiUpdateTrigger
ON OcenioneTreningi
INSTEAD OF UPDATE
AS BEGIN
	DECLARE @IDU¿ytkownika INT, @IDTreningu INT, @Ocena INT
	SELECT
	@IDU¿ytkownika = inserted.IDU¿ytkownika,
	@IDTreningu = inserted.IDTreningu,
	@Ocena = inserted.Ocena
	FROM INSERTED	
	IF (@Ocena BETWEEN 1 AND 5)
		UPDATE OcenioneTreningi
		SET Ocena = @Ocena
		WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDTreningu = @IDTreningu
	ELSE
		RAISERROR('Ocena nie zawiera siê w skali', 16,1)

END
GO

CREATE TRIGGER OcenioneJad³ospisyUpdateTrigger
ON OcenioneJad³ospisy
INSTEAD OF UPDATE
AS BEGIN
	DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT, @Ocena INT
	SELECT
	@IDU¿ytkownika = inserted.IDU¿ytkownika,
	@IDJad³ospisu = inserted.IDJad³ospisu,
	@Ocena = inserted.Ocena
	FROM INSERTED	
	IF (@Ocena BETWEEN 1 AND 5)
		UPDATE OcenioneJad³ospisy
		SET Ocena = @Ocena
		WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDJad³ospisu = @IDJad³ospisu
	ELSE
		RAISERROR('Ocena nie zawiera siê w skali', 16,1)

END
GO

CREATE TRIGGER U¿ytkownicyTrigger
ON U¿ytkownicy
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDU¿ytkownika INT, @NazwaU¿ytkownika VARCHAR(20), @ImiêU¿ytkownika VARCHAR(20), @NazwiskoU¿ytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9)
	SELECT @IDU¿ytkownika = INSERTED.IDU¿ytkownika,
	@NazwaU¿ytkownika = INSERTED.NazwaU¿ytkownika,
	@ImiêU¿ytkownika = INSERTED.ImiêU¿ytownika,
	@NazwiskoU¿ytkownika = INSERTED.NazwiskoU¿ytkownika,
	@NumerTelefonu = INSERTED.NumerTelefonu
	FROM INSERTED
		IF EXISTS (SELECT NazwaU¿ytkownika FROM U¿ytkownicy WHERE NazwaU¿ytkownika = @NazwaU¿ytkownika)
			BEGIN
				RAISERROR('Zajêta nazwa u¿ytkownika!', 16,1)
			END
		ELSE
			BEGIN
				IF (LEN(@NumerTelefonu)=9 AND ISNUMERIC(@NumerTelefonu)=1)
					BEGIN
						INSERT INTO U¿ytkownicy VALUES
						(@NazwaU¿ytkownika,@ImiêU¿ytkownika,@NazwiskoU¿ytkownika,@NumerTelefonu)
						DECLARE @ID INT
						SET @ID=(SELECT MAX(IDU¿ytkownika) FROM U¿ytkownicy)
						INSERT INTO ListaZakupów VALUES
						('Biedronka',@ID),('Lidl',@ID)
					END
				ELSE
					RAISERROR('Numer telefonu ma za ma³o cyfr lub znaki niebêd¹ce cyframi', 16,1)
			END 
END

--PROCEDURE
GO
IF OBJECT_ID('AktualizujPomiar','P') IS NOT NULL
DROP PROC AktualizujPomiar
IF OBJECT_ID('DodajU¿ytkownika','P') IS NOT NULL
DROP PROC DodajU¿ytkownika
IF OBJECT_ID('DodajDoListyZakupów','P') IS NOT NULL
DROP PROC DodajDoListyZakupów
IF OBJECT_ID('UsuñZListyZakupów','P') IS NOT NULL
DROP PROC UsuñZListyZakupów
IF OBJECT_ID('DodajOcenêTreningu','P') IS NOT NULL
DROP PROC DodajOcenêTreningu
IF OBJECT_ID('DodajOcenêJad³ospisu','P') IS NOT NULL
DROP PROC DodajOcenêJad³ospisu
IF OBJECT_ID('ZaplanujTrening','P') IS NOT NULL
DROP PROC ZaplanujTrening
IF OBJECT_ID('ZaplanujJad³ospis','P') IS NOT NULL
DROP PROC ZaplanujJad³ospis
IF OBJECT_ID('ZapiszTrening','P') IS NOT NULL
DROP PROC ZapiszTrening
IF OBJECT_ID('ZapiszJad³ospis','P') IS NOT NULL
DROP PROC ZapiszJad³ospis
IF OBJECT_ID('ZmieñOcenêTreningu','P') IS NOT NULL
DROP PROC ZmieñOcenêTreningu
IF OBJECT_ID('ZmieñOcenêJad³ospisu','P') IS NOT NULL
DROP PROC ZmieñOcenêJad³ospisu
IF OBJECT_ID('DodajZnajomego','P') IS NOT NULL
DROP PROC DodajZnajomego
GO

CREATE PROCEDURE AktualizujPomiar
(@Nazwa VARCHAR(20), @Waga INT, @ObwódPasa INT)
AS
DECLARE @IDU¿ytkownika VARCHAR(20)
DECLARE @DataPomiaru DATETIME
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@nazwa)
SET @DataPomiaru=SYSDATETIME()
INSERT INTO AktualnePomiary VALUES
(@IDU¿ytkownika,@dataPomiaru,@waga,@obwódPasa)
GO

CREATE PROCEDURE DodajZnajomego
(@NazwaU¿ytkownika1 VARCHAR(20),@NazwaU¿ytkownika2 VARCHAR(100))
AS
DECLARE @IDU¿ytkownika1 INT, @IDU¿ytkownika2 INT
SET @IDU¿ytkownika1=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika1)
SET @IDU¿ytkownika2=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika2)
INSERT INTO Znajomi
VALUES (@IDU¿ytkownika1,@IDU¿ytkownika2),(@IDU¿ytkownika2,@IDU¿ytkownika1)
GO

CREATE PROCEDURE ZmieñOcenêJad³ospisu
(@NazwaU¿ytkownika VARCHAR(20),@NazwaJad³ospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDJad³ospisu=(SELECT IDJad³ospisu FROM Jad³ospisy WHERE Jad³ospisy.NazwaJad³ospisu=@NazwaJad³ospisu)
UPDATE OcenioneJad³ospisy
SET OcenioneJad³ospisy.Ocena=@Ocena WHERE OcenioneJad³ospisy.IDU¿ytkownika=@IDU¿ytkownika AND OcenioneJad³ospisy.IDJad³ospisu=@IDJad³ospisu
GO

CREATE PROCEDURE ZmieñOcenêTreningu
(@NazwaU¿ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU¿ytkownika INT, @IDTreningu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
UPDATE OcenioneTreningi 
SET
Ocena = @Ocena
WHERE IDU¿ytkownika = @IDU¿ytkownika AND IDTreningu = @IDTreningu
GO

CREATE PROCEDURE ZapiszTrening
(@NazwaU¿ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100))
AS
DECLARE @IDU¿ytkownika INT, @IDTreningu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZapisaneTreningi VALUES
(@IDU¿ytkownika,@IDTreningu)
GO

CREATE PROCEDURE ZapiszJad³ospis
(@NazwaU¿ytkownika VARCHAR(20),@NazwaJad³ospisu VARCHAR(100))
AS
DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDJad³ospisu=(SELECT IDJad³ospisu FROM Jad³ospisy WHERE Jad³ospisy.NazwaJad³ospisu=@NazwaJad³ospisu)
INSERT INTO ZapisaneJad³ospisy VALUES
(@IDU¿ytkownika,@IDJad³ospisu)
GO

CREATE PROCEDURE ZaplanujTrening
(@NazwaU¿ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@DataRozpoczêcia DATE, @DataZakoñczenia DATE)
AS
DECLARE @IDU¿ytkownika INT, @IDTreningu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZaplanowaneTreningi VALUES
(@IDU¿ytkownika,@IDTreningu,@DataRozpoczêcia,@DataZakoñczenia)
GO

CREATE PROCEDURE ZaplanujJad³ospis
(@NazwaU¿ytkownika VARCHAR(20),@NazwaJad³ospisu VARCHAR(100),@Data DATE)
AS
DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDJad³ospisu=(SELECT IDJad³ospisu FROM Jad³ospisy WHERE Jad³ospisy.NazwaJad³ospisu=@NazwaJad³ospisu)
INSERT INTO ZaplanowaneJad³ospisy VALUES
(@IDU¿ytkownika,@IDJad³ospisu,@Data)
GO

CREATE PROCEDURE DodajOcenêTreningu
(@NazwaU¿ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU¿ytkownika INT, @IDTreningu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO OcenioneTreningi VALUES
(@IDU¿ytkownika,@IDTreningu,@Ocena)
GO

CREATE PROCEDURE DodajOcenêJad³ospisu
(@NazwaU¿ytkownika VARCHAR(20),@NazwaJad³ospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU¿ytkownika INT, @IDJad³ospisu INT
SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
SET @IDJad³ospisu=(SELECT IDJad³ospisu FROM Jad³ospisy WHERE Jad³ospisy.NazwaJad³ospisu=@NazwaJad³ospisu)
INSERT INTO OcenioneJad³ospisy VALUES
(@IDU¿ytkownika,@IDJad³ospisu,@Ocena)
GO

CREATE PROCEDURE UsuñZListyZakupów
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaU¿ytkownika VARCHAR(20))
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDU¿ytkownika INT
	SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakupów WHERE ListaZakupów.NazwaSklepu=@NazwaSklepu AND ListaZakupów.IDU¿ytkownika=@IDU¿ytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	DELETE  FROM Sk³adListyZakupów WHERE 
	Sk³adListyZakupów.IDListy=@IDListy AND Sk³adListyZakupów.IDProduktu=@IDProduktu

GO

CREATE PROCEDURE DodajDoListyZakupów
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaU¿ytkownika VARCHAR(20), @IloœæPorcji INT)
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDU¿ytkownika INT
	SET @IDU¿ytkownika=(SELECT IDU¿ytkownika FROM U¿ytkownicy WHERE U¿ytkownicy.NazwaU¿ytkownika=@NazwaU¿ytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakupów WHERE ListaZakupów.NazwaSklepu=@NazwaSklepu AND ListaZakupów.IDU¿ytkownika=@IDU¿ytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	INSERT INTO Sk³adListyZakupów VALUES
	(@IDListy,@IDProduktu,@IloœæPorcji)
GO
 
CREATE PROCEDURE DodajU¿ytkownika
(@NazwaU¿ytkownika VARCHAR(20), @ImiêU¿ytkownika VARCHAR(20), @NazwiskoU¿ytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9))
AS
INSERT INTO U¿ytkownicy VALUES
(@NazwaU¿ytkownika, @ImiêU¿ytkownika, @NazwiskoU¿ytkownika, @NumerTelefonu)
GO

--VIEW

IF OBJECT_ID('WyœwietlSk³adyTreningów','V') IS NOT NULL
DROP VIEW WyœwietlSk³adyTreningów
IF OBJECT_ID('WyœwietlJad³ospisy','V') IS NOT NULL
DROP VIEW WyœwietlJad³ospisy
IF OBJECT_ID('WyœwietlSk³adyJad³ospisów','V') IS NOT NULL
DROP VIEW WyœwietlSk³adyJad³ospisów
IF OBJECT_ID('WyœwietlProdukty','V') IS NOT NULL
DROP VIEW WyœwietlProdukty
IF OBJECT_ID('WyœwietlTreningi','V') IS NOT NULL
DROP VIEW WyœwietlTreningi
IF OBJECT_ID('WyœwietlTagiSportowe','V') IS NOT NULL
DROP VIEW WyœwietlTagiSportowe
IF OBJECT_ID('WyœwietlTagiSpo¿ywcze','V') IS NOT NULL
DROP VIEW WyœwietlTagiSpo¿ywcze
IF OBJECT_ID('WyœwietlPosi³ki','V') IS NOT NULL
DROP VIEW WyœwietlPosi³ki

GO
CREATE VIEW WyœwietlPosi³ki AS
SELECT Posi³ki.NazwaPosi³ku, Posi³ki.Kalorie, Posi³ki.Wêglowodany, Posi³ki.Bia³ka, Posi³ki.T³uszcze FROM
Posi³ki
GO

CREATE VIEW WyœwietlTagiSportowe AS
SELECT Tag.NazwaTagu, TagSportowy.Ogólnorozwojowy FROM
Tag JOIN TagSportowy ON Tag.IDTagu=TagSportowy.IDTagu
GO

CREATE VIEW WyœwietlTagiSpo¿ywcze AS
SELECT Tag.NazwaTagu, TagSpo¿ywczy.OpisTagu FROM
Tag JOIN TagSpo¿ywczy ON Tag.IDTagu=TagSpo¿ywczy.IDTagu
GO

CREATE VIEW WyœwietlTreningi AS
SELECT T.NazwaTreningu, A.NazwaTagu, B.Ogólnorozwojowy FROM 
Treningi T JOIN TagiTreningów TT on T.IDTreningu = TT.IDTreningu
JOIN Tag A ON A.IDTagu = TT.IDTagu  
JOIN TagSportowy B ON A.IDTagu = B.IDTagu
GO

CREATE VIEW WyœwietlProdukty AS
SELECT Produkty.NazwaProduktu, Produkty.Kalorie, Produkty.MasaPorcji, Produkty.Wêglowodany, Produkty.Bia³ka, Produkty.T³uszcze FROM Produkty
GO 

CREATE VIEW WyœwietlSk³adyJad³ospisów AS
SELECT Jad³ospisy.NazwaJad³ospisu, Posi³ki.NazwaPosi³ku
FROM Jad³ospisy JOIN Sk³adJad³ospisów
ON Jad³ospisy.IDJad³ospisu=Sk³adJad³ospisów.IDJad³ospisu
JOIN Posi³ki ON Sk³adJad³ospisów.IDPosi³ku=Posi³ki.IDPosi³ku
GO

CREATE VIEW WyœwietlJad³ospisy AS
SELECT Jad³ospisy.NazwaJad³ospisu, Jad³ospisy.Kalorie, Jad³ospisy.Wêglowodany, Jad³ospisy.Bia³ka, Jad³ospisy.T³uszcze FROM Jad³ospisy
GO 

CREATE VIEW WyœwietlSk³adyTreningów AS
SELECT Treningi.NazwaTreningu, Æwiczenia.NazwaÆwiczenia
FROM Treningi JOIN Sk³adTreningu
ON Treningi.IDTreningu=Sk³adTreningu.IDTreningu
JOIN Æwiczenia ON Sk³adTreningu.IDÆwiczenia=Æwiczenia.IDÆwiczenia
GO








