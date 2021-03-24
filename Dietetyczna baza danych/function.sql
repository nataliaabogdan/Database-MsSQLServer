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
	AND GETDATE() >= ZaplanowaneTreningi.DataRozpoczêcia AND GETDATE() <= ZaplanowaneTreningi.DataZakoñczenia
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