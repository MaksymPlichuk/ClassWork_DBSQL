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

--5

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