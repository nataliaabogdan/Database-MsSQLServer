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