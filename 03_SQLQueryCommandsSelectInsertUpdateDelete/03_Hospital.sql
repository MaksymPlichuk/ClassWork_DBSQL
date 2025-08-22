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

select Name + Surname as 'Fullname'
from Doctors

select Name + CONVERT(nvarchar(50),StartTime) + CONVERT(nvarchar(50),EndTime) as 'Examination Time'
from Examinations

select Name + CONVERT(nvarchar(50),Building) as 'Full Building'
from Departments

select Name from Departments Where([Floor]=5 and Financing>=30000)


--new
select * from Departments
select * from Diseases
select * from Doctors
select * from Examinations
select * from Wards


insert into Departments
values(1,5000,'Vasiliev',2),(2,6000,'Volkodav',3),(5,9000,'Petrenko',4)

insert into Diseases
values('Grip',5),('Rak',3),('Spid',2)

insert into Doctors
values('Ivan','0985641234',15000,'Saharov',150),('Vasiliy','0978941234',25000,'Lebedev',750),('Vlad','0969874234',10000,'Kalancha',650)

insert into Examinations
values(5,'18:00','Lecheniye','10:00'),(6,'18:00','KOVID','09:00'),(1,'19:00','TRAVA','09:00')

insert into Wards
values(5,'18:00','Lecheniye','10:00'),(6,'18:00','KOVID','09:00'),(1,'19:00','TRAVA','09:00')