create database [04_Hospital];
use [04_Hospital];

create table Departments(
	ID int primary key identity not null,
	Name nvarchar(100) not null check(Name <>'') unique
);

create table Doctors(
	ID int identity not null primary key,
	Name nvarchar(max) not null check(Name <>''),
	Premium money not null check(Premium>=0) default(500),
	Salary money not null check(Salary !<0),
	Surname nvarchar(max) not null check(Surname <>'')
);

create table DoctorsSpecializations(
	ID int identity not null primary key,
	DoctorId int not null references Doctors(ID),
	SpecializationId int not null references Specializations(ID),
);
 
create table Donations(
	ID int primary key identity not null,
	Ammount money not null Check(Ammount!<1),
	[Date] date not null default(GETDATE()) check([Date]!>GETDATE()),
	DepartmentId int not null references Departments(ID),
	SponsorID int not null references Sponsors(ID)
);

create table Specializations(
	ID int identity not null primary key,
	Name nvarchar(100) not null check(Name<>'') unique,
);

create table Sponsors(
	ID int identity not null primary key,
	Name nvarchar(100) not null check(Name<>'') unique,
);

create table Vacations(
	ID int identity not null primary key,
	EndDate date not null check(EndDate>StartDate),
	StartDate date not null,
	DoctorId int not null references Doctors(ID)
);

create table Wards(
	ID int primary key identity,
	Name nvarchar(20) not null check(Name <>'') unique,
	DepartmentId int not null references Departments(ID)
);

select * from Wards
select * from Departments
select * from Donations
select * from Sponsors
select * from Specializations
select * from DoctorsSpecializations
select * from Doctors
select * from Vacations

--to/do
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