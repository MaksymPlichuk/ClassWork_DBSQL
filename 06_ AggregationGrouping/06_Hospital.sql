use [master];
go

if db_id('06_Hospital') is not null
begin
	drop database [06_Hospital];
end
go

create database [06_Hospital];
go

use [06_Hospital];
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

create table [Examinations]
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

alter table [Wards]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

---


select COUNT(w.Name) as [Wards With Places > 10]
from Wards as w
where w.Places>10

select d.Name,COUNT(w.Id) as [Number of Wards]
from Departments as d join Wards as w on w.DepartmentId=d.Id
group by d.Name

select d.Name, SUM(doc.Premium)
from Doctors as doc join DoctorsExaminations as de on doc.Id=de.DoctorId
				join Wards as w on w.Id=de.WardId
				join Departments as d on d.Id=w.DepartmentId
group by d.Name

select d.Name
from Departments as d join Wards as w on w.DepartmentId=d.Id
					join DoctorsExaminations as de on w.Id=de.WardId
group by d.Name
Having COUNT(de.DoctorId)>=5

select COUNT(d.Id),SUM(d.Salary+d.Premium)
from Doctors as d

select AVG(d.Salary+d.Premium)
from Doctors as d

select w.Name
from Wards as w
where w.Places = (select MIN(w.Places) from Wards as w)

select d.Name
from Departments as d join Wards as w on d.Id=w.DepartmentId
where d.Id in (1,6,7,8) and w.Places > 10
Group by d.Name
having SUM(w.Places) > 100


---

insert into Departments (Building, Name) values (1, 'Cardiology');
insert into Departments (Building, Name) values (2, 'Neurology');
insert into Departments (Building, Name) values (3, 'Oncology');
insert into Departments (Building, Name) values (4, 'Pediatrics');
insert into Departments (Building, Name) values (5, 'Orthopedics');
insert into Departments (Building, Name) values (1, 'Dermatology');
insert into Departments (Building, Name) values (2, 'Psychiatry');
insert into Departments (Building, Name) values (3, 'Emergency');
insert into Departments (Building, Name) values (4, 'Gastroenterology');
insert into Departments (Building, Name) values (5, 'Nephrology');
insert into Departments (Building, Name) values (1, 'Urology');
insert into Departments (Building, Name) values (2, 'Ophthalmology');
insert into Departments (Building, Name) values (3, 'ENT');
insert into Departments (Building, Name) values (4, 'Rheumatology');
insert into Departments (Building, Name) values (5, 'Infectious Diseases');

insert into Doctors (Name, Surname, Salary, Premium) values ('John', 'Smith', 6780.05, 578.90);
insert into Doctors (Name, Surname, Salary, Premium) values ('Emily', 'Johnson', 5898.45, 308.08);
insert into Doctors (Name, Surname, Salary, Premium) values ('Robert', 'Williams', 6200.87, 704.45);
insert into Doctors (Name, Surname, Salary, Premium) values ('Sophia', 'Brown', 5598.06, 470.02);
insert into Doctors (Name, Surname, Salary, Premium) values ('Daniel', 'Jones', 5870.00, 4000.45);
insert into Doctors (Name, Surname, Salary, Premium) values ('Olivia', 'Garcia', 6100.40, 20.65);
insert into Doctors (Name, Surname, Salary, Premium) values ('Michael', 'Miller', 6325.98, 600.30);
insert into Doctors (Name, Surname, Salary, Premium) values ('Isabella', 'Davis', 5620.08, 450.05);
insert into Doctors (Name, Surname, Salary, Premium) values ('James', 'Martinez', 5360.09, 500.20);
insert into Doctors (Name, Surname, Salary, Premium) values ('Charlotte', 'Lopez', 5487.90, 345.04);
insert into Doctors (Name, Surname, Salary, Premium) values ('William', 'Gonzalez', 6282.70, 565.08);
insert into Doctors (Name, Surname, Salary, Premium) values ('Amelia', 'Wilson', 6000.00, 400.00);
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
insert into DoctorsExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values ('13:30', '14:30', 10, 8, 6);
