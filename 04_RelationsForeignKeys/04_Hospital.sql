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

create table Specializations(
	ID int identity not null primary key,
	Name nvarchar(100) not null check(Name<>'') unique,
);

create table DoctorsSpecializations(
	DoctorId int not null references Doctors(ID),
	SpecializationId int not null references Specializations(ID),
	primary key(DoctorId,SpecializationId)
);
 
create table Sponsors(
	ID int identity not null primary key,
	Name nvarchar(100) not null check(Name<>'') unique,
);

create table Donations(
	ID int primary key identity not null,
	Ammount money not null Check(Ammount!<1),
	[Date] date not null default(GETDATE()) check([Date]!>GETDATE()),
	DepartmentId int not null references Departments(ID),
	SponsorID int not null references Sponsors(ID)
);

create table Vacations(
	ID int identity not null primary key,
	EndDate date not null,
	StartDate date not null,
	DoctorId int not null references Doctors(ID),
	check(EndDate>StartDate)
);

create table Wards(
	ID int primary key identity,
	Name nvarchar(20) not null check(Name <>'') unique,
	DepartmentId int not null references Departments(ID)
);

----
alter table Doctors
add DepartmentID int not null references Departments(ID) default(1)

create table Examinations(
	ID int identity not null primary key,
	DayOfWeek int not null check(DayOfWeek between 1 and 7),
	EndTime time not null,
	Name nvarchar(100) not null check(Name <>'') unique,
	StartTime time not null check(StartTime between '8:00' and '18:00'),
	DoctorID int not null references Doctors(ID),
	check(EndTime > StartTime)
);
create table Diseases(
	ID int identity not null primary key,
	Name nvarchar(100) not null check(Name <>'') unique,
	Severity int not null check(Severity !<1) default(1),
	SpecializationID int not null references Specializations(ID)
);
----
select * from Wards
select * from Departments
select * from Donations
select * from Sponsors
select * from Specializations
select * from DoctorsSpecializations
select * from Doctors
select * from Vacations

select d.Name + ' ' + d.Surname as [FullName], s.Name as [Specialization]
from Doctors as d,Specializations as s, DoctorsSpecializations as ds
Where(d.ID=ds.DoctorId and s.ID=ds.SpecializationId)

select d.Surname,Salary+Premium as [Salary]
from Doctors as d,Vacations as v
Where(d.ID=v.DoctorId and v.EndDate < GetDate())

select w.Name
from Departments as dp, Wards as w
Where(dp.Name like 'Intensive Treatment')

select distinct dp.Name
from Departments as dp,Sponsors as s, Donations as d
Where(s.Name like 'Umbrella Corporation' and d.SponsorID = s.ID and dp.ID = d.DepartmentId)

select dp.Name,s.Name,d.Ammount,d.Date
from Departments as dp, Donations as d, Sponsors as s
Where(dp.ID=d.DepartmentId and s.ID=d.SponsorID)

--6 невистачає таблиці
select d.Surname,dp.Name
from Doctors as d, Examinations as e, Departments as dp
Where(e.DoctorID=d.ID and d.DepartmentID = dp.ID and e.DayOfWeek between 1 and 5)

--7 невистачає таблиці
select w.Name,dp.Name
from Departments as dp, Wards as w, Doctors as d
Where(d.Name like 'Helen' and d.Surname like 'Williams' and d.DepartmentID = dp.ID and w.DepartmentId=dp.ID)

select dp.Name,doc.Name+' ' +doc.Surname as [FullName]
from Departments as dp,Donations as d, Doctors as doc
Where(d.DepartmentId = dp.ID and d.Ammount>100000 and doc.DepartmentID = dp.ID)

select dp.Name
from Departments as dp, Doctors as doc
Where(dp.ID=doc.DepartmentID and doc.Premium<0)

--10 невистачає таблиці
select sp.Name
from Specializations as sp,Diseases as ds
Where(ds.SpecializationID=sp.ID and ds.Severity>3)

--11 невистачає таблиці
select dp.Name,ds.Name
from Diseases as ds, Examinations as e, Departments as dp

--12 невистачає таблиці
select dp.Name,w.Name
from Departments as dp, Wards as w, Diseases as d


-----------

insert into Departments(Name)
values('Cardiology'),('Neurology'),('Orthopedics'),('Pediatrics'),('Oncology'),('Dermatology'),('Radiology'),('Urology'),('Emergency'),('Intensive Treatment');

insert into Wards(Name,DepartmentId)
values('Ward A', 1),('Ward B', 2),('Ward C', 3),('Ward D', 4),('Ward E', 5),('Ward F', 6),('Ward G', 7),('Ward H', 8),('Ward I', 9),('Ward J', 10);

insert into Sponsors(Name)
values('HealthCare Plus'),('MediTrust'),('LifeLine Foundation'),('Wellness Corp'),('PharmaAid'),('Cure&Care'),('Umbrella Corporation'),('Vitality Group'),('Medical Angels'),('BioHealth Support');

insert into Donations(Ammount,Date,DepartmentId,SponsorID)
values(150000, '2025-01-05', 1, 1),(13000, '2025-01-10', 2, 2),(45000, '2025-01-15', 3, 3),(62000, '2025-01-20', 4, 4),(89000, '2025-01-22', 5, 5),(55500, '2025-01-25', 6, 6),(90000, '2025-01-28', 7, 7),(67010, '2025-02-01', 8, 8),(72800, '2025-02-05', 9, 9),(81050, '2025-02-10', 10, 10);

insert into Specializations(Name)
values('Cardiologist'),('Neurologist'),('Orthopedic Surgeon'),('Pediatrician'),('Oncologist'),('Dermatologist'),('Radiologist'),('Urologist'),('Emergency Physician'),('Gastroenterologist');

insert into Doctors(Name,Premium,Salary,Surname)
values('Sidorovich', 800, 5000, 'Kovalenko'),('Voronin', 600, 4200, 'Marchenko'),('Lukash', 700, 4600, 'Petrenko'),('Sakharov', 500, 4000, 'Bondarenko'),('Herman', 1000, 5500, 'Shevchenko'),('Brome', 750, 4700, 'Chernov'),('Helen', 500, 4100, 'Williams'),('Shulga', 900, 5300, 'Karpov'),('Vano', 650, 4400, 'Ivchenko'),('Danila', 550, 3900, 'Melnichuk');

insert into DoctorsSpecializations(DoctorId,SpecializationId)
values(1, 1),(2, 2),(3, 3),(4, 4),(5, 5),(6, 6),(7, 7),(8, 8),(9, 9),(10, 10);

insert into Vacations(EndDate,StartDate,DoctorId)
values('2025-02-15','2025-02-01',1),('2025-03-10','2025-02-25',2),('2025-04-05','2025-03-20',3),('2025-05-12','2025-04-30',4),('2025-06-25','2025-06-10',5),('2025-07-15','2025-07-01',6),('2025-08-10','2025-07-28',7),('2025-09-18','2025-09-01',8),('2025-10-30','2025-10-15',9),('2025-11-20','2025-11-05',10);

insert into Examinations(DayOfWeek,EndTime,Name,StartTime, DoctorID)
values(5,'18:00','Lecheniye','10:00',1),(6,'18:00','KOVID','09:00',2),(1,'19:00','TRAVA','09:00',3),(3,'14:00','Ebola Terapy','12:00',4)

insert into Diseases(Name,Severity,SpecializationID)
values('Grip',5,4),('Rak',4,6),('Spid',2,3)