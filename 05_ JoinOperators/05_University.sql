create database [05_University]
use [05_University]

create table Subjects(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name<>'')
);

create table Curators(
	Id int primary key identity,
	Name nvarchar(max) not null check(Name<>''),
	Surname nvarchar(max) not null check(Surname<>'')
);

create table Faculties(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name<>'') unique,
	Financing money not null check(Financing!<0) default(0)
);

create table Teachers(
	Id int primary key identity,
	Name nvarchar(max) not null check(Name<>''),
	Salary money not null check(Salary!<1),
	Surname nvarchar(max) not null check(Surname<>'')
);

create table Lectures(
	Id int primary key identity,
	LectureRoom nvarchar(max) not null check(LectureRoom <>'') ,
	SubjectId int not null references Subjects(Id),
	TeacherId int not null references Teachers(Id),
);

create table Departments(
	Id int primary key identity,
	Financing money not null check(Financing!<0) default(0),
	Name nvarchar(100) not null check(Name<>'') unique,
	FaculityID int not null references Faculties(Id)
);

create table Groups(
	Id int primary key identity,
	Name nvarchar(10) not null check(Name<>'') unique,
	[Year] int not null check([Year] between 1 and 5 ),
	DepartmentId int not null references Departments(Id)
);

create table GroupsCurators(
	Id int primary key identity,
	CuratorID int not null references Curators(Id),
	GroupID int not null references Groups(Id)
);

create table GroupsLectures(
	Id int primary key identity,
	LectureID int not null references Lectures(Id),
	GroupID int not null references Groups(Id)
);

select * from Subjects;
select * from Curators;
select * from Faculties;
select * from Teachers;
select * from Lectures;
select * from Departments;
select * from Curators;
select * from GroupsCurators;
select * from GroupsLectures;

----------------------
insert into subjects (Name) values ('Curb & Gutter');
insert into subjects (Name) values ('Retaining Wall and Brick Pavers');
insert into subjects (Name) values ('Framing (Steel)');
insert into subjects (Name) values ('Rebar & Wire Mesh Install');
insert into subjects (Name) values ('Electrical');
insert into subjects (Name) values ('Drilled Shafts');
insert into subjects (Name) values ('Soft Flooring and Base');
insert into subjects (Name) values ('Structural & Misc Steel Erection');
insert into subjects (Name) values ('Masonry & Precast');
insert into subjects (Name) values ('Exterior Signage');

insert into curators (Name, Surname) values ('Vanda', 'Anton');
insert into curators (Name, Surname) values ('Kathryn', 'Halsall');
insert into curators (Name, Surname) values ('Gorden', 'Brothers');
insert into curators (Name, Surname) values ('Walsh', 'Tolworthie');
insert into curators (Name, Surname) values ('Nert', 'Barkhouse');
insert into curators (Name, Surname) values ('Anthea', 'Ginman');
insert into curators (Name, Surname) values ('Mason', 'Elkington');
insert into curators (Name, Surname) values ('Lucienne', 'de Voiels');
insert into curators (Name, Surname) values ('Hewet', 'Burgwin');
insert into curators (Name, Surname) values ('Colleen', 'Britnell');

insert into Faculties (Name, Financing) values ('Hamnet', 121878.79);
insert into Faculties (Name, Financing) values ('Saba', 31066.25);
insert into Faculties (Name, Financing) values ('Ham', 58327.69);
insert into Faculties (Name, Financing) values ('Paul', 67100.93);
insert into Faculties (Name, Financing) values ('Brian', 39644.18);
insert into Faculties (Name, Financing) values ('Sebastien', 45501.7);
insert into Faculties (Name, Financing) values ('Jennette', 62099.55);
insert into Faculties (Name, Financing) values ('Hatti', 132565.84);
insert into Faculties (Name, Financing) values ('Pandora', 40265.68);
insert into Faculties (Name, Financing) values ('Charmian', 144905.29);

insert into Teachers (Name, Salary, Surname) values ('Emanuel', 51963.28, 'Ceaplen');
insert into Teachers (Name, Salary, Surname) values ('Jacquetta', 37981.14, 'Eeles');
insert into Teachers (Name, Salary, Surname) values ('Elwin', 56981.26, 'Noden');
insert into Teachers (Name, Salary, Surname) values ('Vitoria', 21598.0, 'Crawcour');
insert into Teachers (Name, Salary, Surname) values ('Isabel', 76273.85, 'Gooding');
insert into Teachers (Name, Salary, Surname) values ('Ashton', 63274.6, 'Sabattier');
insert into Teachers (Name, Salary, Surname) values ('Darius', 62464.67, 'O''Devey');
insert into Teachers (Name, Salary, Surname) values ('Aggie', 15985.76, 'McKeveney');
insert into Teachers (Name, Salary, Surname) values ('Catha', 65933.76, 'Willmot');
insert into Teachers (Name, Salary, Surname) values ('Suzanne', 45654.01, 'Garbett');

insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Northview', 4, 5);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Shasta', 4, 3);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Dixon', 5, 3);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Sullivan', 10, 5);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Bashford', 4, 3);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Monument', 4, 7);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Anderson', 7, 8);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Ruskin', 3, 1);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('International', 4, 1);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values ('Buhler', 8, 5);

insert into Departments (Financing, Name, FaculityID) values (106175.68, 'Vidon', 8);
insert into Departments (Financing, Name, FaculityID) values (101151.33, 'Loomis', 1);
insert into Departments (Financing, Name, FaculityID) values (152981.18, 'Fulton', 6);
insert into Departments (Financing, Name, FaculityID) values (74398.53, 'Dottie', 9);
insert into Departments (Financing, Name, FaculityID) values (25753.07, 'Comanche', 7);
insert into Departments (Financing, Name, FaculityID) values (24791.04, 'Summit', 6);
insert into Departments (Financing, Name, FaculityID) values (45385.06, 'Sheridan', 4);
insert into Departments (Financing, Name, FaculityID) values (50625.84, 'Lillian', 10);
insert into Departments (Financing, Name, FaculityID) values (134750.62, 'Becker', 3);
insert into Departments (Financing, Name, FaculityID) values (8288.74, 'Charing Cross', 3);


insert into Groups (Name, [Year], DepartmentId) values ('dodio', 3, 3);
insert into Groups (Name, [Year], DepartmentId) values ('acne', 1, 7);
insert into Groups (Name, [Year], DepartmentId) values ('ins', 1, 7);
insert into Groups (Name, [Year], DepartmentId) values ('mainec', 5, 1);
insert into Groups (Name, [Year], DepartmentId) values ('veet', 3, 1);
insert into Groups (Name, [Year], DepartmentId) values ('sana', 1, 8);
insert into Groups (Name, [Year], DepartmentId) values ('curoin', 3, 2);
insert into Groups (Name, [Year], DepartmentId) values ('rhcui', 4, 1);
insert into Groups (Name, [Year], DepartmentId) values ('neon', 4, 3);
insert into Groups (Name, [Year], DepartmentId) values ('erat', 4, 3);

insert into GroupsCurators (CuratorID, GroupID) values (7, 8);
insert into GroupsCurators (CuratorID, GroupID) values (5, 3);
insert into GroupsCurators (CuratorID, GroupID) values (7, 4);
insert into GroupsCurators (CuratorID, GroupID) values (6, 7);
insert into GroupsCurators (CuratorID, GroupID) values (1, 6);
insert into GroupsCurators (CuratorID, GroupID) values (2, 9);
insert into GroupsCurators (CuratorID, GroupID) values (2, 3);
insert into GroupsCurators (CuratorID, GroupID) values (9, 6);
insert into GroupsCurators (CuratorID, GroupID) values (2, 2);
insert into GroupsCurators (CuratorID, GroupID) values (9, 1);

insert into GroupsLectures (LectureID, GroupID) values (1, 7);
insert into GroupsLectures (LectureID, GroupID) values (4, 5);
insert into GroupsLectures (LectureID, GroupID) values (1, 5);
insert into GroupsLectures (LectureID, GroupID) values (5, 7);
insert into GroupsLectures (LectureID, GroupID) values (2, 5);
insert into GroupsLectures (LectureID, GroupID) values (9, 7);
insert into GroupsLectures (LectureID, GroupID) values (6, 7);
insert into GroupsLectures (LectureID, GroupID) values (6, 7);
insert into GroupsLectures (LectureID, GroupID) values (2, 7);
insert into GroupsLectures (LectureID, GroupID) values (9, 3);



