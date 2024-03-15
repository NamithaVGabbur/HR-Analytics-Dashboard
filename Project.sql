SELECT * FROM HREXCEL.HRDATA2;
SELECT * FROM HREXCEL.HRDATA1;
use hrexcel;
SELECT COUNT(`Employee ID`) AS `Total Employees` FROM hrdata1;

SELECT  ROUND(AVG(hrdata1.PerformanceRating),3) AS `Ex-Employees Average Performance Rating` FROM hrdata1 JOIN hrdata2 ON hrdata1.`Employee ID`=hrdata2.`EmployeeNumber`
WHERE Attrition="Yes";