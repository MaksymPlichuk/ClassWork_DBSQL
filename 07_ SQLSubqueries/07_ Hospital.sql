use [master];
go

if db_id('07_Hospital') is not null
begin
	drop database [07_Hospital];
end
go

create database [07_Hospital];
go

use [07_Hospital];
go

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	[Building] int not null check ([Building] between 1 and 5),
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Doctors]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Premium] money not null check ([Premium] >= 0.0) default 0.0,
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

create table [DoctorsExaminations]
(
	[Id] int not null identity(1, 1) primary key,
	[EndTime] time not null,
	[StartTime] time not null check ([StartTime] between '08:00' and '18:00'),
	[DoctorId] int not null,
	[ExaminationId] int not null,
	[WardId] int not null,
	check ([StartTime] < [EndTime])
);
go

create table [Donations]
(
	[Id] int not null identity(1, 1) primary key,
	[Amount] money not null check ([Amount] > 0.0),
	[Date] date not null check ([Date] <= getdate()) default getdate(),
	[DepartmentId] int not null,
	[SponsorId] int not null
);
go

create table [Examinations]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Sponsors]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Wards]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(20) not null unique check ([Name] <> N''),
	[Places] int not null check ([Places] >= 1),
	[DepartmentId] int not null
);
go

alter table [DoctorsExaminations]
add foreign key ([DoctorId]) references [Doctors]([Id]);
go

alter table [DoctorsExaminations]
add foreign key ([ExaminationId]) references [Examinations]([Id]);
go

alter table [DoctorsExaminations]
add foreign key ([WardId]) references [Wards]([Id]);
go

alter table [Donations]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

alter table [Donations]
add foreign key ([SponsorId]) references [Sponsors]([Id]);
go

alter table [Wards]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

-------

select dp.Name
from Departments as dp
where Building = (select Building
					from Departments
					where name='Cardiology')

select dp.Name
from Departments as dp
where Building in (select Building 
					from Departments
					where name='Gastroenterology' or name = 'General Surgery')

select dp.Name
from Departments as dp join Donations as d on dp.Id=d.DepartmentId
where d.Amount = (select MIN(Amount)
					from Donations)



select * from Departments

-------

insert into Departments (Building, Name) values (1, 'Cardiology');
insert into Departments (Building, Name) values (2, 'Neurology');
insert into Departments (Building, Name) values (3, 'Oncology');
insert into Departments (Building, Name) values (4, 'Pediatrics');
insert into Departments (Building, Name) values (5, 'Orthopedics');
insert into Departments (Building, Name) values (1, 'Dermatology');
insert into Departments (Building, Name) values (2, 'Psychiatry');
insert into Departments (Building, Name) values (3, 'Emergency');
insert into Departments (Building, Name) values (4, 'Gastroenterology');
insert into Departments (Building, Name) values (5, 'General Surgery');
insert into Departments (Building, Name) values (1, 'Urology');
insert into Departments (Building, Name) values (2, 'Microbiology');
insert into Departments (Building, Name) values (3, 'ENT');
insert into Departments (Building, Name) values (4, 'Rheumatology');
insert into Departments (Building, Name) values (5, 'Infectious Diseases');

insert into Doctors (Name, Surname, Salary, Premium) values ('John', 'Smith', 6780.05, 578.90);
insert into Doctors (Name, Surname, Salary, Premium) values ('Thomas', 'Gerada', 5898.45, 308.08);
insert into Doctors (Name, Surname, Salary, Premium) values ('Robert', 'Williams', 6200.87, 704.45);
insert into Doctors (Name, Surname, Salary, Premium) values ('Sophia', 'Brown', 5598.06, 470.02);
insert into Doctors (Name, Surname, Salary, Premium) values ('Daniel', 'Jones', 5870.00, 4000.45);
insert into Doctors (Name, Surname, Salary, Premium) values ('Olivia', 'Garcia', 6100.40, 20.65);
insert into Doctors (Name, Surname, Salary, Premium) values ('Michael', 'Miller', 6325.98, 600.30);
insert into Doctors (Name, Surname, Salary, Premium) values ('Anthony', 'Davis', 56.08, 40.05);
insert into Doctors (Name, Surname, Salary, Premium) values ('James', 'Martinez', 5360.09, 500.20);
insert into Doctors (Name, Surname, Salary, Premium) values ('Charlotte', 'Lopez', 5487.90, 345.04);
insert into Doctors (Name, Surname, Salary, Premium) values ('William', 'Gonzalez', 6282.70, 565.08);
insert into Doctors (Name, Surname, Salary, Premium) values ('Joshua', 'Bell', 68000.00, 400.00);
insert into Doctors (Name, Surname, Salary, Premium) values ('Benjamin', 'Anderson', 6150.00, 350.00);
insert into Doctors (Name, Surname, Salary, Premium) values ('Mia', 'Thomas', 5950.00, 370.00);
insert into Doctors (Name, Surname, Salary, Premium) values ('Elijah', 'Taylor', 5850.00, 480.00);

insert into Examinations (Name) values ('Blood Test');
insert into Examinations (Name) values ('MRI Scan');
insert into Examinations (Name) values ('X-Ray');
insert into Examinations (Name) values ('Ultrasound');
insert into Examinations (Name) values ('ECG');
insert into Examinations (Name) values ('CT Scan');
insert into Examinations (Name) values ('Endoscopy');
insert into Examinations (Name) values ('Colonoscopy');
insert into Examinations (Name) values ('Skin Biopsy');
insert into Examinations (Name) values ('Allergy Test');
insert into Examinations (Name) values ('Urinalysis');
insert into Examinations (Name) values ('Liver Function Test');
insert into Examinations (Name) values ('Thyroid Test');
insert into Examinations (Name) values ('Eye Exam');
insert into Examinations (Name) values ('Hearing Test');

insert into Wards (Name, Places, DepartmentId) values ('Ward A1', 89, 1);
insert into Wards (Name, Places, DepartmentId) values ('Ward B2', 12, 2);
insert into Wards (Name, Places, DepartmentId) values ('Ward C3', 8, 3);
insert into Wards (Name, Places, DepartmentId) values ('Ward D4', 9, 4);
insert into Wards (Name, Places, DepartmentId) values ('Ward E5', 11, 5);
insert into Wards (Name, Places, DepartmentId) values ('Ward F6', 24, 6);
insert into Wards (Name, Places, DepartmentId) values ('Ward G7', 14, 7);
insert into Wards (Name, Places, DepartmentId) values ('Ward H8', 6, 8);
insert into Wards (Name, Places, DepartmentId) values ('Ward I9', 7, 9);
insert into Wards (Name, Places, DepartmentId) values ('Ward J10', 15, 10);
insert into Wards (Name, Places, DepartmentId) values ('Ward K11', 8, 11);
insert into Wards (Name, Places, DepartmentId) values ('Ward L12', 10, 12);
insert into Wards (Name, Places, DepartmentId) values ('Ward M13', 9, 13);
insert into Wards (Name, Places, DepartmentId) values ('Ward N14', 5, 14);
insert into Wards (Name, Places, DepartmentId) values ('Ward O15', 13, 15);
insert into Wards (Name, Places, DepartmentId) values ('Ward B25', 16, 15);

insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('08:00', '09:00', 1, 6, 9);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('09:15', '10:00', 4, 2, 2);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('10:00', '11:00', 3, 8, 3);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('08:30', '09:30', 9, 5, 4);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('11:00', '12:00', 2, 2, 7);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('12:00', '13:00', 6, 6, 7);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('13:00', '14:00', 7, 7, 7);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('14:00', '15:00', 8, 8, 7);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('15:00', '16:00', 11, 9, 7);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('10:30', '11:30', 5, 8, 11);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('11:45', '12:30', 12, 2, 1);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('12:45', '13:45', 13, 9, 4);
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('12:30', '15:00', 10, 8, 6);

insert into Sponsors (Name) values ('Noll');
insert into Sponsors (Name) values ('Sibella');
insert into Sponsors (Name) values ('Alana');
insert into Sponsors (Name) values ('Mona');
insert into Sponsors (Name) values ('Rennie');
insert into Sponsors (Name) values ('Ebba');
insert into Sponsors (Name) values ('Carilyn');
insert into Sponsors (Name) values ('Addy');
insert into Sponsors (Name) values ('Godfry');
insert into Sponsors (Name) values ('Kingsley');
insert into Sponsors (Name) values ('Kory');
insert into Sponsors (Name) values ('Maria');
insert into Sponsors (Name) values ('Kissiah');
insert into Sponsors (Name) values ('Skip');
insert into Sponsors (Name) values ('Roxine');

insert into Donations (Amount, Date, DepartmentId, SponsorId) values (32894.16, '12/18/2023', 14, 6);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (76156.15, '1/31/2017', 13, 1);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (126724.44, '9/1/2000', 2, 6);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (31722.68, '1/17/2015', 5, 9);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (75845.12, '7/10/2018', 6, 9);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (89148.15, '4/3/2010', 12, 12);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (57367.59, '4/4/2024', 7, 2);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (44930.75, '10/20/2004', 13, 13);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (130655.09, '7/19/2017', 8, 13);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (120493.86, '8/15/2007', 10, 5);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (118630.79, '6/17/2014', 1, 9);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (117031.18, '2/9/2012', 11, 11);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (95985.56, '9/7/2006', 14, 15);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (142122.05, '11/8/2007', 12, 13);
insert into Donations (Amount, Date, DepartmentId, SponsorId) values (117962.07, '4/26/2016', 11, 15);





