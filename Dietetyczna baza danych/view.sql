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