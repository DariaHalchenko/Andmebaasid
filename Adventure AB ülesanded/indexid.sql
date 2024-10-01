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

--uue klastreeritud ühendindeksi loomiseks Gender ja Salary veeru põhjal
Create Clustered Index IX_tblEmployee_Gender_Salary
ON DimEmployee (Gender DESC, BaseRate ASC)

-- loob SQL-s mitte-klastreeritud indeksi Name veeru järgi DimEmployee tabelis
Create NonClustered Index IX_DimEmployee_Name
ON DimEmployee(FirstName)


