DECLARE @nazwa VARCHAR(50)
DECLARE @sciezka VARCHAR(256) 
DECLARE @nazwaPliku VARCHAR(256)
DECLARE @data VARCHAR(20)

SET @sciezka = 'C:\\'  
SELECT @data = CONVERT(VARCHAR(20),GETDATE(),112) 
 
DECLARE db_kursor CURSOR READ_ONLY FOR  
SELECT name
FROM master.sys.databases 
WHERE name ='DietetycznaBazaDanych'
AND state = 0
AND is_in_standby = 0
 
OPEN db_kursor   
FETCH NEXT FROM db_kursor INTO @nazwa   
 
WHILE @@FETCH_STATUS = 0   
BEGIN   
   SET @nazwaPliku = @sciezka + @nazwa + '_' + @data + '.BAK'  
   BACKUP DATABASE @nazwa TO DISK = @nazwaPliku  
 
   FETCH NEXT FROM db_kursor INTO @nazwa 
END   

 
CLOSE db_kursor   
DEALLOCATE db_kursor