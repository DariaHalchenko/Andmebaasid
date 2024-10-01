--35. Ineksid serveris
Select * From DimEmployee where BaseRate>50 and BaseRate<70

--Loome indeksi BaseRate  veerule.
CREATE Index IX_tblEmployee_BaseRate
ON DimEmployee (BaseRate ASC)
Execute sp_helptext DimEmployee

--kustutada indeksit
Drop Index DimEmployee.IX_tblEmployee_BaseRate
