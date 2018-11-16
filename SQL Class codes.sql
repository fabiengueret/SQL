-- This is the first statement you need to execute (Comments)
use[AdventureWorks2012]

-- select is a command for printing
-- select column_names (If you want all columns of a table, write * )
-- from table_name

-- Print all the columns of the table humanresources.employee
select *
from [HumanResources].[Employee]

-- Print limited columns
select [BusinessEntityID],[NationalIDNumber],[LoginID]
from [HumanResources].[Employee]

-- Print FirstName, LastName and MiddleName from the table person.person
select [FirstName],[MiddleName],[LastName]
from [Person].[Person]

-- Top n - to print limited number of rows
select top 5 *
from [Person].[Person]

select top 10 * 
from [HumanResources].[Employee]

--distinct 
select distinct [Gender]
from [HumanResources].[Employee]

-- where - To subset the data or retrieve a part of your data

--select col_names
--from table_name
--where condition

-- Print only the male employees data
select *
from [HumanResources].[Employee]
where [Gender]='M'

select top 10*
from [HumanResources].[Employee]

-- Print all the information about employees which are married
select * 
from [HumanResources].[Employee]
where [MaritalStatus] = 'M'

--and / or - used tocombine multiple conditions
-- and makes sure that all the condition are satisfied
-- or makes sure that any one of the condition is satisfied

-- Print the information about employees which are male and married
select *
from [HumanResources].[Employee]
where [Gender] ='M' and [MaritalStatus] = 'M'

-- Print the information about employees which are either male or married
select *
from [HumanResources].[Employee]
where [Gender] ='M' or [MaritalStatus] = 'M'

-- Print the information about products where color of the product is blue and the daystomanufacture
-- are either 2 or 4 (Production.Product)

select *
from [Production].[Product]
where [Color]= 'blue' and ([DaysToManufacture]=2 or [DaysToManufacture]=4)

-- Logical operators - >(Greater), <(Less), >=, <=, <>(Not equal to)

-- Print information about products whose color is not blue and daystomanufacture are
-- greater than equal to 2

select *
from [Production].[Product]
where [Color] <> 'blue' and [DaysToManufacture]>=2

-- Between ( when you need to specify a range) 
-- Not between (which can be used to exclude a range)

-- print the information about products where daystomanufacture is between 2 and 4
-- order for confditions: where column_name operator value
select *
from [Production].[Product]
where [DaysToManufacture] between 2 and 4

select *
from [Production].[Product]
where [DaysToManufacture] >= 2 and  [DaysToManufacture] <= 4

select *
from [Production].[Product]
where [DaysToManufacture] not between 2 and 4

-- Print the data for products if listprice is between 10 and 50 and class is H

select *
from [Production].[Product]
where [ListPrice] between 10 and 50 and [Class] ='H'

-- In / Not in 
-- color in('blue', 'black', 'red') / color='blue' or color='black' or color = 'red'

-- Print information about products where color is either blue, black, red or yellow
select *
from [Production].[Product]
where [Color] in ('blue', 'black', 'red' , 'yellow')

select *
from [Production].[Product]
where [Color] = 'blue' or [Color]='black' or [Color]= 'red' or [Color]='yellow'

-- is null / is not null (Used to check for missing values)
select *
from [Production].[Product]
where [Size] is not null

-- Retrieve information about the products with color values except null, 
-- Red, silver/black, white and list price between £75 and £750

select * 
from [Production].[Product]
where [Color] is not null 
and [Color] not in ('Red', 'silver/black', 'white',' ')
and [ListPrice] between 75 and 750

-- Like ( %-any  number of characters, _ one character)
-- Color like 'M%', '%M', '_M%'. '%M%'
-- where col_name like ''

--Print all the products whose color value begins with B and ends with K
select *
from [Production].[Product]
where[Color] like 'B%K'

--select
--from 
--where (If needed)
--order by col_name (ascending is the default order), col_name desc

select *
from [Production].[Product]
order by [Color] desc, [ListPrice], [Name] desc

--Extract employee Login ID, Job Title, Birth Date, Gender and Marital Status of 
--all employees that are single or Male arranged by their job title
select [LoginID],[JobTitle],[BirthDate],[Gender],[MaritalStatus]
from [HumanResources].[Employee] 
where [Gender]='M' or [MaritalStatus] = 'S'
order by [JobTitle]


-- print the minimum , maximum  and average listprice of products belonging to the same color
select [Color], min([ListPrice]) as Minprice, max([ListPrice]) as maxprice, 
avg([ListPrice]) as avgprice
from [Production].[Product]
group by [Color]

-- as is used to give alias names to column while printing

--Print the number of employees and the sum of vacation hours for each gender

select [Gender], count([BusinessEntityID]) as NoofEmployees, sum([VacationHours]) as sumvactionhours
from[HumanResources].[Employee]
group by [Gender]
having sum([VacationHours])> 5000

-- Print the average list price of products, grouped by colour only where
--  the average price is greater than 1200

select [Color], avg([ListPrice]) as avglistprice
from [Production].[Product]
group by [Color]
having avg([ListPrice])>1200


 -- Create a table called employee, columns- Id, Name, Salary, Gender

 create table employee
 (
	ID int primary key,
	Name varchar(30), 
	Salary int,
	Gender char(1)
)

select *
from [dbo].[employee]

-- Insert values to into the table

-- insert into table_name (all column_names)
-- values () , (),  ()

insert into  [dbo].[employee] (ID, Name, Salary, Gender)
values (1,'Mary',10000,'F'), (2, 'Joe', 12000, 'M')

select *
from [dbo].[employee]

-- drop (deltes the entire table from the database)
-- delete from (Deletes all the rows)

delete from
[dbo].[employee]
where ID = 1

select *
from [dbo].[employee]

drop table [dbo].[employee]

select *
from [dbo].[employee]

-- Create a table employeedetails. Add columns Employee ID (int) , name (varchar) , 
-- gender (varchar), age( int), salary (int)
-- Insert three rows of values in it 

-- consraints - not null, unique, default, check, primary key
create table employeedetails
(
 EmployeeID int primary key,
 name varchar(255) not null unique,
 gender varchar(255),
 age int,
 salary int check(salary>0) default 10000
)

insert into [dbo].[employeedetails](EmployeeID,name,gender,age,salary)
values (1,'Kruti','F',23,12345), (2, 'Mary', 'F', 24, default)

select *
from [dbo].[employeedetails]

-- Please provide me with volume of products sold, and revenue generated grouped by their product ID 
-- where volume sold is greater than 650

select [ProductID],sum([OrderQty]) as [volume of products], sum([LineTotal]) as revenue
from [Sales].[SalesOrderDetail]
group by [ProductID]
having sum([OrderQty]) > 650

----------------------------------------------------------DAY 2-------------------------------------------------------------------
-- alter table
-- Add a column
alter table [dbo].[employeedetails]
add maritalstatus char(1)

select * 
from [dbo].[employeedetails]

-- Delete the column
alter table [dbo].[employeedetails]
drop column [maritalstatus]

select * 
from [dbo].[employeedetails]

alter table [dbo].[employeedetails]
alter column [gender] char(1)

-- Change the gender value in the employee details table to male/female

alter table [dbo].[employeedetails]
alter column [gender] varchar(10)

-- Set is replacing
update [dbo].[employeedetails]
set [gender] ='Female'
where [gender] ='F'

select *
from [dbo].[employeedetails]

-- Set is replacing
update [dbo].[employeedetails]
set [Salary] = [Salary]+5000
where [Name] in ('Kruti','Mary')

select * from [dbo].[employeedetails]

-- If you want to change all the values of a column , remove the where statement
-- this will update the salary of the employees
update [dbo].[employeedetails]
set [Salary] = [Salary]+5000

-- customer table 
-- annualspend (how much each customer is spending with  me)
-- segment (The vlaue of the column segment are dependant on annual spend)
-- case 
-- when annualspend between 0 and 1000 then 'Low value'
-- when annualspend between 1001 and 5000 then 'Mid value'
-- when annualspend>=5000 then 'High value' OR 
-- else 'High value'
-- end as [Segment]
-- case when statements will come in the select statement

-- Create a list of product segmentation depending on the list price. If price is less than 200 then
-- low value, if price is between 201 and 750 then mid value. If between 750 and 1250 then mid
-- to high value else higher value. Do this only for colors black , silver and red

select 
*,
case
when [ListPrice]<200 then 'Low value'
when [ListPrice] between 201 and 750 then 'Mid value'
when [ListPrice] between 751 and 1250 then 'Mid to High'
else 'Higher value'
end as [Product Segmentation]

from [Production].[Product]
where [Color] in ('Black','Silver','Red')

-- Create a column called manufacturing speed , based on the values of dataset
select [ProductID],
[DaysToManufacture],
case
when [DaysToManufacture] <2 then 'Fast'
--when [DaysToManufacture] >=2 then 'Slow'
else 'Slow'
end as [Manufacturing Speed]
from [Production].[Product]

-- character functions
-- concat(col_nam1, col_name2) Combine the values in different columns
-- len(col_name) The number of characters in the column
-- lower(col_name) - lowercase, upper(col_name) - uppercase
-- left(col_name, no_of_char) , right(col_name, no_of_char)
-- substring(col_name, which position, how many characters)
-- left(Kruti,2) =Kr  right(Kruti,1) = I, substring(Kruti,3,3) = uti

select [FirstName],
concat([FirstName],' ',[MiddleName],' ',[LastName]) as fullname,
len([FirstName]) as lenfirstname,
lower([FirstName]) as lowercase,
upper([FirstName]) as uppercase,
left([FirstName],2) as firsttwo,
right([FirstName],2) as lasttwo,
substring([FirstName],2,3) as subfirstname
from [Person].[Person]

-- concatenate first name, middle name and last name only when the first two letters of the
-- first name are equal to last two letters of the last name

select concat([FirstName],' ',[MiddleName],' ',[LastName]) as fullname
from [Person].[Person]
where left([FirstName],2) = right([LastName],2)

-- case when 
select [FirstName],[LastName],
case
when left([FirstName],2) = right([LastName],2) 
then concat([FirstName],' ',[MiddleName],' ',[LastName])
else ' '
end as [FullName]
from [Person].[Person]

-- Numeric functions
-- max(), min(), avg(), sum(), count() [aggregate functions]
-- abs() - Removes the sign [abs(-23) = 23]
-- floor(), ceiling() [floor(23.23) = 23 ceiling(23.23) = 24]
-- sqrt() - square root
-- round() - Rounds up the value

select abs(-23) as absolutevalue, 
floor(23.26) as lowervalue, 
ceiling(23.26) as highervalue, 
sqrt(16) as squareroot, 
round(23.415,0) as roundedvalue

-- get the square root of -16
select sqrt(abs(-16))


-- count the number of employees which are male and married
-- use humanresources.employee

select count([BusinessEntityID])
from [HumanResources].[Employee]
where [Gender]='M' and [MaritalStatus]='M'

--Date functions
select getdate()
--day(col_name), month(col_name), year(col_name) - numerical value
-- datename(interval,col_name) [interval - month, quarter, day, year] - character value
-- dateadd(interval, number, col_name)
-- dateadd(year,2, col_name)  - add 2 years
-- dateadd(year, -2 , col_name) - subtract 2 years
-- datediff(interval, date1, date2) - difference between dates in specified interval
-- date2 - higher date

-- extract day, month, year and month name from the column sellstartdate (Production.product)

select [SellStartDate],
day([SellStartDate]) as dayno, 
month([SellStartDate]) as monthno,
year([SellStartDate]) as yearno,
datename(month,[SellStartDate]) as nameofmonth
from [Production].[Product]

-- Print the age of each employee in years and in days .
-- Also add three months to their birthdate to create a new column called addthreemonths

select [BusinessEntityID],
datediff(year,[BirthDate],getdate()) as ageinyear,
datediff(day,[BirthDate],getdate()) as ageindays,
dateadd(month,3,[BirthDate]) as addthreemonths
from [HumanResources].[Employee]

select datediff(day, [OrderDate],[ShipDate])
from [Sales].[SalesOrderHeader]

-- set operators
select *
from [HumanResources].[Employee]
where [Gender] ='M'
except 
select *
from [HumanResources].[Employee]
where [MaritalStatus] ='M'

-- UNION ALL - 352
-- UNION - 255
-- EXCEPT - 107
-- INTERSECT - 97
-- Joins

create table one
(
	ID int,
	A int,
	B int
)

insert into one (ID,A,B)
values(10,1,2), (20,3,4), (30,5,6)

create table two
(
	ID int,
	C int
)

insert into two (ID,C)
values(10,7),(30,8),(40,9)

--Left join 
select 
[dbo].[one].*, [dbo].[two].C
from [dbo].[one] 
left join [dbo].[two] 
on [dbo].[one].ID = [dbo].[two].ID

select 
do.*, dt.C
from [dbo].[one] as do left join [dbo].[two] as dt
on do.ID = dt.ID

-- Equivalent to right join example below
select 
do.*, dt.C
from  [dbo].[two] as do left join [dbo].[one] as dt
on do.ID = dt.ID

-- right join 
select dt.Id, do.A, do.B, dt.C
from [dbo].[one] as do right join [dbo].[two] as dt
on do.ID = dt.ID

-- inner join 
select do.*, dt.C
from [dbo].[one] as do inner join [dbo].[two] as dt
on do.ID = dt.ID

-- full outer join 
select do.*, dt.*
from [dbo].[one] as do full outer join [dbo].[two] as dt
on do.ID = dt.ID

-- Print the account number and sub total for only those customers, who have made sales
-- Account no and sub total are in the table - sales.salesorderheader
-- customers are present in the sales.customer table
-- Print the store ID also (sales.customer)

select 
sc.[CustomerID],
sc.[StoreID],
ssoh.[AccountNumber],
ssoh.[SubTotal]

from [Sales].[SalesOrderHeader] as ssoh
inner join [Sales].[Customer] as sc
on ssoh.[CustomerID] = sc.[CustomerID]

--FOR each employee in the person.person table. I would like to know the employee 
--firstname, lastname, job title, gender and maritalstatus (HumanResources.Employee)
-- Get the emailId for each employee

select pp.[FirstName],
pp.[LastName],
hre.[JobTitle],
hre.[Gender],
hre.[MaritalStatus],
pea.[EmailAddress]

from [Person].[Person] as pp
inner join [HumanResources].[Employee] as hre
on pp.[BusinessEntityID] = hre.[BusinessEntityID]
inner join [Person].[EmailAddress] as pea
on pea.[BusinessEntityID] = pp.[BusinessEntityID]


-- Please provide information  on all customers who made orders and the product they ordered,
-- including the product color. Also provide the information on the year, month name and quarter 
-- of the order date and how many days did it take to ship the product once the order was placed

select ssoh.CustomerID,
ssod.ProductID,
pp.Color,
year(ssoh.[OrderDate]) as orderyear,
datename(month,ssoh.[OrderDate]) as ordermonth,
datename(quarter,ssoh.[OrderDate]) as orderquarter,
datediff(day,ssoh.[OrderDate],ssoh.[ShipDate]) as daystoship

from [Sales].[SalesOrderHeader] as ssoh
inner join [Sales].[SalesOrderDetail] as ssod
on ssoh.SalesOrderID = ssod.SalesOrderID
inner join [Production].[Product] as pp
on ssod.ProductID = pp.ProductID



------------------------------------------------- DAY 3 ---------------------------------------------------------------------------------
-- subquery
-- views
-- stored procedures


-- Print the productId, color and listprice of the products whose list price is
-- greater than the average list price of the products with color red

select avg([ListPrice]) 
from [Production].[Product]
where color = 'red'

select [ProductID],[Color],[ListPrice]
from [Production].[Product]
where [ListPrice] > 1401.95

-- Subquery
select [ProductID],[Color],[ListPrice]
from [Production].[Product]
where [ListPrice] > 
(select avg([ListPrice]) 
from [Production].[Product]
where color = 'red')

-- Using a subquery, display the product names and product ID numbers from the
-- Production.Product table that have been ordered.

select [ProductID],[Name]
from [Production].[Product]
where [ProductID] in
(select distinct [ProductID]
from [Sales].[SalesOrderDetail])

-- select the salesorderID, orderdate, accountnumber, customerId, salespersonId, totaldue
-- from sales.salesorderheader only for the sales person who have bonus > 5000
-- use sales.salesorderheader and sales.salesperson 
-- salespersonID is the same as businessentityID

SELECT SalesOrderID,
       OrderDate,
       AccountNumber,
       CustomerID,
       SalesPersonID,
       TotalDue
  FROM Sales.SalesOrderHeader
  WHERE SalesPersonID IN (SELECT BusinessEntityID
                            FROM Sales.SalesPerson
                           WHERE Bonus > 5000)



-- Print the customer ID and the number of products they purchased using  a subquery
-- sales.salesorderdetail and sales.salesorderheader

select ssoh.[CustomerID], count(ssod.[ProductID])
from [Sales].[SalesOrderDetail] as ssod
inner join [Sales].[SalesOrderHeader]as ssoh
on ssod.[SalesOrderID] = ssoh.[SalesOrderID]
group by ssoh.[CustomerID]

--For each salesorderId, print the orderdate and maximum unit price 

select ssoh.[SalesOrderID],ssoh.[OrderDate], maxunitprice = 
(select max([UnitPrice]) 
from [Sales].[SalesOrderDetail] as ssod
where ssoh.[SalesOrderID]= ssod.[SalesOrderID])
from [Sales].[SalesOrderHeader] as ssoh


-- views

create view view1 as
select ssoh.[SalesOrderID],ssoh.[OrderDate], maxunitprice = 
(select max([UnitPrice]) 
from [Sales].[SalesOrderDetail] as ssod
where ssoh.[SalesOrderID]= ssod.[SalesOrderID])
from [Sales].[SalesOrderHeader] as ssoh

select *
from [dbo].[view1]

-- alter
-- update

delete from  [dbo].[view1]
where SalesOrderID = 43659

select * 
from [dbo].[view1]

-- To create a table from a view or another table
select * into table1 
from [dbo].[view1]

-- Rank over partition
create view rankoverpartition as
select [Name],[Color],[ListPrice], 
rank() over (partition by [Color] order by [ListPrice] desc)Rank 
from [Production].[Product]

select * from [dbo].[rankoverpartition]
where (Rank =1 or Rank =2)
and [Color] is not NULL

select [Name],[Color],[ListPrice], 
row_number() over (partition by Color order by ListPrice) Rownumber
from [Production].[Product]

select [Name],[Color],[ListPrice], 
ntile(2) over (partition by Color order by ListPrice) Rownumber
from [Production].[Product]
where color = 'Red'

-- Rank the sales person according to the bonus separately for each territory ID
-- use table sales.salesperson
-- Put the results in a view

create view view6 as 
select [BusinessEntityID],[TerritoryID],[Bonus],
rank() over 
(partition by [TerritoryID] order by [Bonus] desc)Rank
from [Sales].[SalesPerson]
where [TerritoryID] is not null


select *
from [dbo].[view6]

-- From the view print the salesperson with highest bonus from every territory ID
select * from view6
where Rank=1


-- Stored Procedures

-- create procedure proc_name
-- as
-- begin

------ SQL QUERY

-- end
-- Creation / Definition

create procedure procedure1
as 
begin
	select * from [HumanResources].[Employee]
end 

-- Calling the procedure
execute procedure1


-- Crerate a stored procedure called procedure2, to find all the male employees born 
-- between 1962 and 1970 and hired after 2001.
create procedure procedure2
as
begin
	select [BusinessEntityID],[BirthDate],[HireDate],[Gender]
	from [HumanResources].[Employee]
	where year([BirthDate]) between 1962 and 1970
	and year([HireDate]) > 2001
	and [Gender] ='M'
end 

-- Run
execute procedure2

-- Alter
alter procedure procedure2
as
begin
-- Updated query
end


-- Stored procedure with input
create procedure procedure3
(
	@gen char(1),
	@mar char(1),
	@vac int -- declaring an input variable
)
as
begin
	select * 
	from [HumanResources].[Employee]
	where [Gender] = @gen 
	and [MaritalStatus]= @mar
	and [VacationHours] > @vac
end 

execute procedure3 M,S,65
execute procedure3 F,M,80

-- Create a procedure to give the min, max, avg list price for each color and class
-- Make color and class as the input variables

create procedure procedure4
(
	@color varchar(20),
	@class varchar(20)
)
as
begin
	select min([ListPrice]) as minprice, max([ListPrice]) as maxprice, avg([ListPrice]) as avgprice
	from [Production].[Product]
	where [Color] = @color 
	and [Class] =@class
	
end 

execute procedure4 red,H


-- stored proedures with input and output
create procedure procedure5 
(
	@color varchar(30),
	@avglp int OUT
)
as
begin
	select @avglp = avg([ListPrice]) 
	from [Production].[Product]
	where [Color] =@color
end

declare @avglp as int
execute procedure5 red, @avglp OUTPUT
select @avglp

select [ProductID]
from [Production].[Product]
where [ListPrice]>@avglp

-- create a stored procedure to output the concatenation of middle name and last name of the
-- person when you provide first name as the input
-- use table person.person

create procedure procedure6 
(
	@firstname varchar(50),
	@middlelastname varchar(100) out
)
as
begin
	select @middlelastname= concat([MiddleName],[LastName])
	from [Person].[Person]
	where [FirstName]= @firstname
end

declare @middlelastname as varchar(100) 
execute procedure6 syed,@middlelastname output 
select @middlelastname 

select  firstname,middlename, lastname from Person.Person
where firstname ='syed'


