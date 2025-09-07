create Database [08_MusicCollection]
use [08_MusicCollection]


create table Styles(
	Id int not null primary key identity,
	Name nvarchar(50) not null unique check(Name<>'')
);
create table Performers(
	Id int not null primary key identity,
	Name nvarchar(50) not null unique check(Name<>'')
);

create table Countries(
	Id int not null primary key identity,
	Name nvarchar(50) not null unique check(Name<>'')
);

create table Publishers(
	Id int not null primary key identity,
	Name nvarchar(50) not null unique check(Name<>''),
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
	StyleName int not null references Styles(Id),
	PerformerName int not null references Performers(Id)
);

----

create view PerformersName
as
	select Name
	from Performers

select * from PerformersName

create view AllSongInfo(SongName,DiscName,SongLength,Style,Performer)
as
select s.Name,d.Name,s.Length,st.Name,p.Name
from Songs as s join AboutDisk as d on d.Id=s.DiscName
				join Styles as st on st.Id=s.StyleName
				join Performers as p on p.Id=s.PerformerName

select * from AllSongInfo

create view PerformerDiscInfo(PerformerName,DiscName,DateOfRelease,Style,Publisher)
as
select p.Name,d.Name,d.DateOfRealease,st.Name,ps.Name
from AboutDisk as d join Performers as p on p.Id=d.PerformerId
				join Styles as st on st.Id=d.StyleId
				join Publishers as ps on ps.Id=d.PublisherId

select * from PerformerDiscInfo
order by PerformerName

create view TopPerformer(PerformerName,NumberOfDiscs)
as
select TOP 1 p.Name,COUNT(d.Id)
from AboutDisk as d join Performers as p on p.Id=d.PerformerId
group by p.Name
order by COUNT(d.Id) desc

select * from TopPerformer

create view Top3Performers(PerformerName,NumberOfDiscs)
as
select TOP 3 p.Name,COUNT(d.Id)
from AboutDisk as d join Performers as p on p.Id=d.PerformerId
group by p.Name
order by COUNT(d.Id) desc

select * from Top3Performers

create view LongestAlbum(DiscName,TotalLength)
as
select d.Name,s.Length
from AboutDisk as d join Songs as s on s.DiscName=d.Id
where s.Length = (select MAX(Length)
							from Songs)

select * from LongestAlbum

---

insert into Styles (Name) values ('Rock');
insert into Styles (Name) values ('Pop');
insert into Styles (Name) values ('Jazz');
insert into Styles (Name) values ('Hip-Hop');
insert into Styles (Name) values ('Classical');
insert into Styles (Name) values ('Electronic');
insert into Styles (Name) values ('Reggae');
insert into Styles (Name) values ('Metal');
insert into Styles (Name) values ('Blues');
insert into Styles (Name) values ('Folk');

insert into Performers (Name) values ('The Beatles');
insert into Performers (Name) values ('Eminem');
insert into Performers (Name) values ('Taylor Swift');
insert into Performers (Name) values ('Miles Davis');
insert into Performers (Name) values ('Mozart');
insert into Performers (Name) values ('Daft Punk');
insert into Performers (Name) values ('Bob Marley');
insert into Performers (Name) values ('Metallica');
insert into Performers (Name) values ('B.B. King');
insert into Performers (Name) values ('Ed Sheeran');

insert into Countries (Name) values ('USA');
insert into Countries (Name) values ('UK');
insert into Countries (Name) values ('Canada');
insert into Countries (Name) values ('Germany');
insert into Countries (Name) values ('France');
insert into Countries (Name) values ('Italy');
insert into Countries (Name) values ('Spain');
insert into Countries (Name) values ('Jamaica');
insert into Countries (Name) values ('Japan');
insert into Countries (Name) values ('Australia');

insert into Publishers (Name, CountryId) values ('Universal Music Group', 1);
insert into Publishers (Name, CountryId) values ('Sony Music', 2);
insert into Publishers (Name, CountryId) values ('Warner Music', 3);
insert into Publishers (Name, CountryId) values ('EMI Records', 4);
insert into Publishers (Name, CountryId) values ('Polydor', 5);
insert into Publishers (Name, CountryId) values ('Atlantic Records', 6);
insert into Publishers (Name, CountryId) values ('Island Records', 7);
insert into Publishers (Name, CountryId) values ('Columbia Records', 8);
insert into Publishers (Name, CountryId) values ('Def Jam Recordings', 9);
insert into Publishers (Name, CountryId) values ('Nuclear Blast', 10);

insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Abbey Road', 1, '1969-09-26', 1, 1);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('The Marshall Mathers LP', 2, '2000-05-23', 4, 2);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('1989', 3, '2014-10-27', 2, 3);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Kind of Blue', 4, '1959-08-17', 3, 4);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Requiem', 5, '1791-12-05', 5, 5);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Discovery', 6, '2001-03-12', 6, 6);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Legend', 7, '1984-05-08', 7, 7);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Master of Puppets', 8, '1986-03-03', 8, 8);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Live at the Regal', 9, '1965-11-21', 9, 9);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Divide', 10, '2017-03-03', 2, 10);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('The Eminem Show', 2, '2002-05-26', 4, 2);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Encore', 2, '2004-11-12', 4, 3);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Relapse', 2, '2009-05-15', 2, 2);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Sgt. Pepper''s Lonely Hearts Club Band', 1, '1967-06-01', 1, 1);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Revolver', 1, '1966-08-05', 1, 2);
insert into AboutDisk (Name, PerformerId, DateOfRealease, StyleId, PublisherId) values ('Fearless', 3, '2008-11-11', 2, 3);

insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Come Together', 1, 259, 1, 1);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Lose Yourself', 2, 326, 4, 2);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Blank Space', 3, 231, 2, 3);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('So What', 4, 545, 3, 4);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Lacrimosa', 5, 720, 5, 5);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Harder Better Faster Stronger', 6, 224, 6, 6);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('No Woman No Cry', 7, 270, 7, 7);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Master of Puppets', 8, 515, 8, 8);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Sweet Little Angel', 9, 220, 9, 9);
insert into Songs (Name, DiscName, Length, StyleName, PerformerName) values ('Shape of You', 10, 240, 2, 10);