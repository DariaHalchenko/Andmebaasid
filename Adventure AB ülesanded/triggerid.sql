--92.DDL_trigger_SQL_Serveris
--DDL trigger saab luua konkreetsesse andmebaasi või serveri tasemel.
create trigger trMyFirstTrigger
on database
for CREATE_TABLE
as
begin
print 'New table created'
end

create table Test (id int)


--Kui soovid, et see trigger käivitatakse mitu korda nagu muuda ja kustuta tabel, siis eralda sündmused ning kasuta koma.
alter trigger trMyFirstTrigger
on database
for CREATE_TABLE,ALTER_TABLE,DROP_TABLE
as
begin
print 'A table has just been created, modified or deleted'
end

alter table Test
add test varchar(50)

--Nüüd vaatame näidet, kuidas ära hoida kasutajatel loomaks, muutmaks või kustatamiseks tabelit. 
alter trigger trMyFirstTrigger
on database
for CREATE_TABLE,ALTER_TABLE,DROP_TABLE
as
begin
rollback
print 'You cannot create, alter or drop a table'
end

drop table Test

--Kui lubada triggerit:
disable trigger trMyFirstTrigger on database

--Kuidas kustutada triggerit:
drop trigger trMyFirstTrigger on database

--Järgnev trigger käivitub, kui peaksid kasutama sp_rename käsklust süsteemi stored procedurite muutmisel.
--Järgnev kood muudab TestTable nime NewTestTable nimeks
create trigger trRenameTable
on database
for RENAME
as
begin
print 'You just renamed something'
end

sp_rename 'Test','NewTesttable'
