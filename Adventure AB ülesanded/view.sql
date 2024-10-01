--39. View SQL serveris
--peaksime ühendama kaks tabelit omavahel
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

--loome view
Create View vWEmployeesByDepartment
AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
Select * FROM vWEmployeesByDepartment

--View, mis tagastab ainult IT osakonna töötajad
Create View vWITDepartment_Employees
AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
WHERE DimDepartmentGroup.DepartmentGroupName = 'IT'

--View, kus ei ole BaseRate veergu
Create View vWEmployeesNonConfidentialData
AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

--View, mis tagastab summeeritud andmed töötajate koondarvest.
Create View vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(EmployeeKey) AS TotalEmployees
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
Group By DepartmentName

sp_helptext vWEmployeesByDepartment
sp_helptext vWITDepartment_Employees
sp_helptext vWEmployeesNonConfidentialData
sp_helptext vWEmployeesCountByDepartment
