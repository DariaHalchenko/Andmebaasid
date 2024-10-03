--92.DDL_trigger_SQL_Serveris

--DDL trigger saab luua konkreetsesse andmebaasi või serveri tasemel.
Create trigger trMyFirstTrigger
ON database
FOR CREATE_TABLE
AS
BEGIN
  Print 'New table created'
END
Create Table Test (Id int)

--see trigger käivitatakse mitu korda nagu muuda ja kustuta tabel, siis eralda sündmused ning kasuta koma
Alter trigger trMyFirstTrigger
ON database
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
  Print 'A table has just been created, modified or deleted'
END

ALTER TABLE Test
ADD test varchar(10)

--kuidas ära hoida kasutajatel loomaks, muutmaks või kustatamiseks tabelit. 
Alter trigger trMyFirstTrigger
ON Database
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
Rollback
  Print 'You cannot create, alter or drop a table'
END

DROP TABLE Test
  
--Kui lubada triggerit
DISABLE Trigger trMyFirstTrigger ON Database

--Kuidas kustutada triggerit
Drop Trigger trMyFirstTrigger ON Database

--Järgnev kood muudab TestTable nime NewTestTable nimeks
Create trigger trRenameTable
ON Database
FOR RENAME
AS
BEGIN
  Print 'You just renamed something'
END

sp_rename 'Test','NewTesttable'

--93. Server-Scoped DDL triggerid

--See ei luba luua, muuta ja kustutada tabeleid andmebaasist sinna, kuhu see on loodud.
Create trigger tr_DatabaseScopeTrigger
ON Database
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
Rollback
  Print 'You cannot create, alter or drop a table in the current database'
END

--See on nagu andembaasi vahemiku trigger, aga erinevus seisneb, et sa pead lisama koodis sõna ALL peale
Create trigger tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
Rollback
  Print 'You cannot create, alter or drop a table in any database on the server'
END

--Kuidas saab Serveri ulatuses olevat DDL trigerit kinni panna
DISABLE Trigger tr_ServerScopeTrigger ON ALL SERVER

--Kuidas lubada Serveri ulatuses olevat DDL trigerit
ENABLE Trigger tr_ServerScopeTrigger ON ALL SERVER

--Kuidas kustutada serveri ulatuses olevat DDL trigerit
DROP Trigger tr_ServerScopeTrigger ON ALL SERVER
