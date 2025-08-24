create database [03_Hospital];
use [03_Hospital];

create table Departments(
	ID int primary key identity not null,
	Building int not null check(Building between 1 and 5),
	Financing money not null default(0) check(Financing !<0),
	Name nvarchar(100) not null check(Name <>'') unique
);

create table Diseases(
	ID int identity not null primary key,
	Name nvarchar(100) not null check(Name <>'') unique,
	Severity int not null check(Severity !<1) default(1)
);

create table Doctors(
	ID int identity not null primary key,
	Name nvarchar(max) not null check(Name <>''),
	Phone char(10) not null,
	Salary money not null check(Salary !<0),
	Surname nvarchar(max) not null check(Surname <>'')
);

create table Examinations(
	ID int identity not null primary key,
	DayOfWeek int not null check(DayOfWeek between 1 and 7),
	EndTime time not null,
	Name nvarchar(100) not null check(Name <>'') unique,
	StartTime time not null check(StartTime between '8:00' and '18:00'),
	check(EndTime > StartTime)
);
--new
alter table Doctors
add Premium money not null check(Premium>=0) default(500);

alter table Departments
add [Floor] int not null check([Floor]>=1) default(1);

create table Wards(
	ID int primary key identity,
	Building int not null check(Building between 1 and 5),
	[Floor] int not null check([Floor]>=1),
	Name nvarchar(20) not null check(Name <>'') unique
);

select * from Wards
select Surname, Phone from Doctors

select Distinct [Floor]
from Wards	

select Name as 'Name of Disease', Severity as 'Severity of Disease'
from Diseases

select Name + ' ' + Surname as 'Fullname'
from Doctors

select Name + ' ' +CONVERT(nvarchar(50),StartTime) + ' ' +CONVERT(nvarchar(50),EndTime) as 'Examination Time'
from Examinations

select Name + ' ' +CONVERT(nvarchar(50),Building) as 'Full Building'
from Departments

select Name from Departments Where([Floor]=5 and Financing<30000)

select Name from Departments Where([Floor]=3 and Financing between 12000 and 15000)

select Name from Wards Where(Building in (4,5) and [Floor]=1)

select Name,Building,Financing 
from Departments Where(Building in (3,6) and Financing<11000 or Financing>=25000)

select Surname from Doctors Where(Salary > 1500 and Premium > 1500)

select Surname from Doctors Where((Salary/2)>Premium*3)

select distinct Name from Examinations Where((DayOfWeek in (1,2,3)) and (StartTime between '12:00' and '15:00') and (EndTime between '12:00' and '15:00'))

select Name,Building from Departments Where(Building in (1,3,8,10))

select Name from Diseases Where(Severity<>1 or Severity<>2)

select Name from Departments Where(Building<>1 or Building<>3)

select Name from Departments Where(Building in (1,3))

select Surname from Doctors Where(Surname Like 'N%')

--new end
select * from Departments
select * from Diseases
select * from Doctors
select * from Examinations
select * from Wards

insert into Departments(Building,Financing,Name,[Floor])
values(1,15000,'Vasiliev',2),(2,14000,'Volkodav',3),(5,90000,'Petrenko',4),(4,1500,'New Corp',1),(3,25000,'Administrative Corp',5)

insert into Diseases(Name,Severity)
values('Grip',5),('Rak',3),('Spid',2)

insert into Doctors(Name,Phone,Salary,Surname,Premium)
values('Ivan','0985641234',15000,'Saharov',150),('Vasiliy','0978941234',25000,'Lebedev',7500),('Vlad','0969874234',10000,'Kalancha',6500),('Herman','0969874444',45000,'Nautilious',37800)

insert into Examinations(DayOfWeek,EndTime,Name,StartTime)
values(5,'18:00','Lecheniye','10:00'),(6,'18:00','KOVID','09:00'),(1,'19:00','TRAVA','09:00'),(3,'14:00','Ebola Terapy','12:00')
--new start
insert into Wards(Building,[Floor],Name)
values(5,4,'Aplha'),(2,3,'Beta'),(1,2,'Gamma'),(4,1,'Delta')