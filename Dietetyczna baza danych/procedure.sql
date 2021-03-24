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