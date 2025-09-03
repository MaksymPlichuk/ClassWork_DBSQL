create Database [08_MusicCollection]
use [08_MusicCollection]


create table Styles(
	Id int not null primary key identity,
	Name nvarchar(50) not null unique check(Name<>'')
);
create table Performers(
	Id int not null primary key identity,
);

create table Countries(
	Id int not null primary key identity,
	Name nvarchar(50) not null unique check(Name<>'')
);

create table Publishers(
	Id int not null primary key identity,
	CountryId int not null references Countries(Id)
);
create table AboutDisk(	
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>''),
	PerformerId int not null references Performers(Id),
	DateOfRealease date not null check(DateOfRealease<GETDATE()) default(GETDATE()),
	StyleId int not null references Styles(Id),
	PublisherId int not null references Publishers(Id)
);

create table Songs(
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>''),
	DiscName int not null references AboutDisk(Id),
	Length int not null check(Length > 0),
	StyleName int not null references AboutDisk(Id),
	PerformerName int not null references AboutDisk(Id)
);

