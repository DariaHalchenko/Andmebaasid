--35. Ineksid serveris
Select * From DimEmployee where BaseRate>50 and BaseRate<70

--Loome indeksi BaseRate  veerule.
CREATE Index IX_tblEmployee_BaseRate
ON DimEmployee (BaseRate ASC)
Execute sp_helptext DimEmployee

--kustutada indeksit
Drop Index DimEmployee.IX_tblEmployee_BaseRate

--36. Klastreeritud ja mitte-klastreeritud indeksid

--klastreeritud indeks Id veerus.
--Selle tulemusel SQL server ei luba luua rohkem, kui ühte klastreeritud indeksit tabeli kohta.
Create Clustered Index IX_tblEmployee_Name
ON DimEmployee(FirstName)

-- kustutama praeguse klastreeritud indeksi Id veerus (siis saad veateate)
Drop index DimEmployee.PK_DimEmployee_EmployeeKey

--uue klastreeritud ühendindeksi loomiseks Gender ja BaseRate veeru põhjal
Create Clustered Index IX_tblEmployee_Gender_Salary
ON DimEmployee (Gender DESC, BaseRate ASC)

-- loob SQL-s mitte-klastreeritud indeksi Name veeru järgi DimEmployee tabelis
Create NonClustered Index IX_DimEmployee_Name
ON DimEmployee(FirstName)

--37. Unikaalne ja mitte-unikaalne indeks

--Loome tabeli Employee
Create table tblEmployee
(
id int Primary Key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
);

Execute sp_helpindex DimEmployee
Execute sp_helpindex tblEmployee

--Kui proovime kustutada Unique Clustered Index-st, siis anna meile veateate
Drop index DimEmployee.PK_DimEmployee_EmployeeKey
Drop index tblEmployee.PK_DimEmplo_3213E83F49F15F99

-- luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru põhjal.
Create Unique NonClustered Index UIX_DimEmployee_FirstName_LastName
ON tblEmployee(FirstName, LastName)

-- tõestuseks lisame koodiga unikaalse piirangu City veerule.
ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

--siis tekib nimekiri UNIQUE NONCLUSTERED indeks.
EXECUTE SP_HELPCONSTRAINT DimEmployee
EXECUTE SP_HELPCONSTRAINT tblEmployee

--Kui soovin ainult viie rea tagasi lükkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.
CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY




