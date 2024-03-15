SELECT * FROM HREXCEL.HRDATA2;
SELECT * FROM HREXCEL.HRDATA1;
use hrexcel;

ALTER TABLE hrdata1
CHANGE COLUMN `employee Id` employeeid INT;



/* KPIs */
-- Total employees
select count(*) as TotalEmployes from hrdata2;

-- Active Employees
select count(case 
when attrition='No' then 1
else null
end) as 'Active Employees' from hrdata2;

-- attrition Rate
select (count(case 
when attrition='Yes' then 1
else null
end)/sum(employeecount))*100 as 'Attrition Rate' from hrdata2;

-- Average Monthy Income
select round(avg(monthlyincome)) as 'Avg Monthly Income' from hrdata1;

-- Experience amomg  Employees
select round(avg(NumCompaniesWorked)) as 'Experience' from Hrdata1;

-- higest Performance Rating
select max(PerformanceRating) as 'Performace rating' from hrdata1;

-- lowest rating in Work life Balance
select min(WorkLifeBalance) as 'Least rating in work life balance' from hrdata1;

-- Average Age
select round(avg(age)) as 'Average Age of Employees' from hrdata2;

-- Percentage of employees who travel regularly
select round((count(if(BusinessTravel='Travel_Frequently',1,null))/sum(employeecount))*100) as 'Percentage of Regular Travellers' from hrdata2;

-- Average Daily rate
select round(avg(dailyrate)) as ' Average daily rate' from hrdata2;

-- Number of Employess based on gender
SELECT gender, count(*) AS 'Count Of Employess'
FROM hrdata2
GROUP BY gender;

-- Job Satisfaction
select round(avg(jobsatisfaction),2) as 'Avg Job Satisfaction' from hrdata2;

-- age distibution of employees in the company
select 
case
when age<20 then 'less than 20'
when age<=30 then '20-30'
when age<=40 then '30-40'
when age<=50 then '40-50'
when age<60 then '50-59'
else '60=retiring this year'
end as age_group,
count(*) as 'Number of employees'
from hrdata2
group by age_group
order by age_group desc ;


-- Department wise employees
select count(employeeNumber) as HeadCount ,department
from hrdata2
group by department;

-- Monthy Income by Department
select hrdata2.department, round(Avg(hrdata1.monthlyincome)) as MonthyIncome
from hrdata1 
cross join  hrdata2 
on  hrdata1.employeeid = hrdata2.employeenumber
group by hrdata2.department;

-- Education Field wise Attrition
select Educationfield,count(case 
when attrition='No' then 1
else null
end) as 'Attrition Count' 
from hrdata2
group by Educationfield;

-- Department Wise PerformanceRating,RelationshipSatisfaction 
select round(max(PerformanceRating)), 
round(min(PerformanceRating)),
round(max(RelationshipSatisfaction)),
round(min(RelationshipSatisfaction))
from hrdata1;


select b.Department,round(avg(a.PerformanceRating)) as 'PerformanceRating', round(avg(a.RelationshipSatisfaction)) as 'RelationshipSatisfaction'
from hrdata1 as a
cross join  hrdata2  as b
on a.employeeid = b.employeenumber
group by b.department;

-- Distribution of Employees job satisfaction  across Education Field

select Educationfield,(case
when Jobsatisfaction = 1 then 'Not Satisfied'
when Jobsatisfaction between 2 and 3 then 'Average'
else 'Satisfied' 
end) as 'Job_Satisfaction',count(*) as Employees
from hrdata2
group by EducationField, Job_Satisfaction
order by  Job_Satisfaction, Employees Desc;

-- Martial status Wise Business travel
select Maritalstatus,Businesstravel,count(*) as 'Employees'
from hrdata2
group by Maritalstatus,Businesstravel
order by BusinessTravel, Employees desc;

-- Jobrole wise WorklifeBalnce and MonthyIncome
select b.Jobrole, round(avg(a.worklifeBalance)) as 'Average Worklife Balance', round(avg(a.Monthlyincome)) as  MonthlyIncome
from hrdata1 as a
cross join hrdata2 as b
on a.employeeid=b.employeenumber
group by b.jobrole
order by MonthlyIncome Desc;

-- gender wise Monthly Rate and Income
select b.gender,round(avg(a.MonthlyRate)) as 'Monthy Rate', round(avg(a.monthlyIncome)) as ' Monthy Income'
from hrdata1 as a
cross join hrdata2 as b
on a.employeeid=b.employeenumber
group by gender
order by 'Monthy Rate';













