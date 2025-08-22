create database [02_Hospital];
use [02_Hospital];

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

select * from Departments
select * from Diseases
select * from Doctors
select * from Examinations

insert into Departments
values(1,5000,'Vasiliev'),(2,6000,'Volkodav'),(5,9000,'Petrenko')

insert into Diseases
values('Grip',5),('Rak',3),('Spid',2)

insert into Doctors
values('Ivan','0985641234',15000,'Saharov'),('Vasiliy','0978941234',25000,'Lebedev'),('Vlad','0969874234',10000,'Kalancha')

insert into Examinations
values(5,'18:00','Lecheniye','10:00'),(6,'18:00','KOVID','09:00'),(1,'19:00','TRAVA','09:00')