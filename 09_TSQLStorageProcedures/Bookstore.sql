create database [Bookstore]
go
use [Bookstore]
go
create table Themes(
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>'') unique
);
go
create table Countires(
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>'') unique
);
go
create table Authors(
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>''),
	Surname nvarchar(50) not null check(Surname<>''),
	CountryId int not null references Countires(Id)
);
go
create table Books(
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>''),
	Pages int not null check(Pages>0),
	Price int not null check(Price>0),
	PublishDate date not null check(PublishDate<GetDate()) default(GETDATE()),
	AuthorId int not null references Authors(Id),
	ThemeId int not null references Themes(Id)
);
go
create table Shops(
	Id int not null primary key identity,
	Name nvarchar(50) not null check(Name<>''),
	CountryId int not null references Countires(Id)
);
go
create table Sales(
	Id int not null primary key identity,
	Price int not null check(Price>0),
	Quantity int not null check(Quantity>0),
	SaleDate date not null check(SaleDate<GETDATE()) default(GETDATE()),
	BookId int not null references Books(Id),
	ShopId int not null references  Shops(Id)
);
go
------
select * from Themes
order by Id
select * from Books
select * from Shops
select* from Countires
order by Id
select * from Authors
select * from Sales
------

create view BooksPagesRange(BookName,Pages)
as
select Name,Pages
from Books
where Pages > 500 and Pages <=650

select * from BooksPagesRange


create view BooksStartingAZ(BookName)
as
select Name
from Books
where Name Like N'А%' or Name like N'З%'

select * from BooksStartingAZ


create proc BookSelection
@GenreId int,
@Quantity int
as
begin
	select b.Name
	from Books as b join Sales as s on s.BookId=b.Id
	where @GenreId=b.ThemeId and s.Quantity>@Quantity
end;
GO

exec BookSelection @GenreID=3,@Quantity=0


create view ContainsMicrosoftinName
as
select Name
from Books
where Name like '%Microsoft%' and Name not like '%Windows%'

select * from ContainsMicrosoftinName


create view PagePriceLess65coins
as
select b.Name +', ' + t.Name +', ' + a.Name +' '+a.Surname as [Full Info]
from Books as b join Authors as a on a.Id=b.AuthorId
				join Themes as t on t.Id=b.ThemeId
where b.Price/b.Pages < 0.65

select* from PagePriceLess65coins


create view BooksName4Words
as
select Name as [BookName]
from Books
where Name LIKE '% % % %'
  AND Name NOT LIKE '% % % % %';

select* from BooksName4Words


create view BooksWithParams(BookName,Theme,AuthorName,Price,Quantity,ShopName)
as
select b.Name,t.Name,a.Name+' '+a.Surname,s.Price,s.Quantity,sp.Name
from Books as b join Sales as s on s.BookId=b.Id
				join Themes as t on t.Id=b.ThemeId
				join Authors as a on a.Id=b.AuthorId
				join Shops as sp on sp.Id=s.ShopId

where b.Name not like '%A%' and b.ThemeId!=17
and a.Name!='Herbert'and a.Surname!='Shield' and s.Price>100 and s.Price<200 
and s.Quantity>8 and sp.Id=1

select * from BooksWithParams


select 'Number Of Authors',COUNT(Id)
from Authors
UNION
select 'Number Of Books',COUNT(Id)
from Books
UNION
select 'Average Sell Price',AVG(Price)
from Sales
UNION
select 'Average Page Count',AVG(Pages)
from Books

create view ThemePages(Theme,TotalPages)
as
select t.Name,SUM(b.Pages)
from Books as b join Themes as t on t.Id=b.ThemeId
group by t.Name

select * from ThemePages


create view AuthorBooksCount(AuthorName,NumberOfBooks,TotalPages)
as
select a.Name+' '+a.Surname,COUNT(b.Id),SUM(b.Pages)
from Books as b join Authors as a on a.Id=b.AuthorId
group by a.Name,a.Surname

select * from AuthorBooksCount


create view ProgramingBooksWithMaxPages(BookName,NumberOfPages)
as
select Name,Pages
from Books
where ThemeId=17 and Pages = (select (MAX(Pages))from Books)

select* from ProgramingBooksWithMaxPages


create view ThemesAvgPagesLess400(ThemeName,AvgPages)
as
select t.Name,AVG(Pages)
from Books as b join Themes as t on t.Id=b.ThemeId
group by t.Name
having AVG(Pages)<400 

select * from ThemesAvgPagesLess400


create view SumOfThemesCodingAdminDesign(Theme,NumberOfPages)
as
select t.Name,SUM(b.Pages)
from Books as b join Themes as t on t.Id=b.ThemeId
where b.Pages>400 and t.Id=16 or t.Id=17 or t.Id=18
group by t.Name

select * from SumOfThemesCodingAdminDesign


create view ShopWorkInfo(ShopName,BookName,SaleDate,Price,Quantity)
as
select sp.Name,b.Name,s.SaleDate,s.Price,s.Quantity
from Shops as sp join Sales as s on s.ShopId=sp.Id
				join Books as b on s.BookId=b.Id
				join Countires as c on c.Id=sp.CountryId

select* from ShopWorkInfo


create view MostProfitableShop(ShopName,BookName,SaleDate,Price,Quantity,TotalProfit)
as
select sp.Name,b.Name,s.SaleDate,s.Price,s.Quantity,MAX(s.Price*s.Quantity)
from Shops as sp join Sales as s on s.ShopId=sp.Id
				join Books as b on s.BookId=b.Id
				join Countires as c on c.Id=sp.CountryId
where s.Price*s.Quantity= (select(MAX(Price*Quantity))from Sales)
group by sp.Name,b.Name,s.SaleDate,s.Price,s.Quantity

select* from MostProfitableShop


-------

insert into Themes (Name) values ('Fantasy');
insert into Themes (Name) values ('Science Fiction');
insert into Themes (Name) values ('Romance');
insert into Themes (Name) values ('History');
insert into Themes (Name) values ('Philosophy');
insert into Themes (Name) values ('Mystery');
insert into Themes (Name) values ('Thriller');
insert into Themes (Name) values ('Biography');
insert into Themes (Name) values ('Drama');
insert into Themes (Name) values ('Horror');
insert into Themes (Name) values ('Adventure');
insert into Themes (Name) values ('Poetry');
insert into Themes (Name) values ('Politics');
insert into Themes (Name) values ('Satire');
insert into Themes (Name) values ('Mythology');
insert into Themes (Name) values ('Administration');
insert into Themes (Name) values ('Computer Science');
insert into Themes (Name) values ('Design');
go
insert into Countires (Name) values ('Ukraine');
insert into Countires (Name) values ('USA');
insert into Countires (Name) values ('UK');
insert into Countires (Name) values ('Germany');
insert into Countires (Name) values ('France');
insert into Countires (Name) values ('Italy');
insert into Countires (Name) values ('Japan');
insert into Countires (Name) values ('Canada');
insert into Countires (Name) values ('Spain');
insert into Countires (Name) values ('Norway');
insert into Countires (Name) values ('Poland');
insert into Countires (Name) values ('Sweden');
insert into Countires (Name) values ('Australia');
insert into Countires (Name) values ('Brazil');
insert into Countires (Name) values ('India');
go
insert into Authors (Name, Surname, CountryId) values ('George', 'Martin', 14);
insert into Authors (Name, Surname, CountryId) values ('Haruki', 'Murakami', 7);
insert into Authors (Name, Surname, CountryId) values ('Igor', 'Kolomoyskiy', 1);
insert into Authors (Name, Surname, CountryId) values ('Umberto', 'Bush', 6);
insert into Authors (Name, Surname, CountryId) values ('Stephen', 'King', 2);
insert into Authors (Name, Surname, CountryId) values ('Margaret', 'Tetcher', 8);
insert into Authors (Name, Surname, CountryId) values ('Hanz', 'Ferdinant', 3);
insert into Authors (Name, Surname, CountryId) values ('Albert', 'Einsteim', 5);
insert into Authors (Name, Surname, CountryId) values ('Aleksandr', 'Dyagtarov', 9);
insert into Authors (Name, Surname, CountryId) values ('Henrik', 'Ibsen', 10);
insert into Authors (Name, Surname, CountryId) values ('Ivan', 'Semenyk', 11);
insert into Authors (Name, Surname, CountryId) values ('Astrid', 'Lindgren', 12);
insert into Authors (Name, Surname, CountryId) values ('Tim', 'Carlos', 13);
insert into Authors (Name, Surname, CountryId) values ('Winston', 'Cherchil', 2);
insert into Authors (Name, Surname, CountryId) values ('Joseph', 'Roy', 15);
go
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Great Day', 1200, 500, '2005-06-01', 1, 1);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Oppenheimer', 480, 300, '2002-09-12', 2, 2);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Fieldwork', 350, 200, '1996-03-22', 3, 3);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Fine Weather', 650, 400, '1980-01-10', 4, 6);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('The Shining', 450, 250, '1977-01-28', 5, 10);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Lost Victories', 320, 220, '1985-05-01', 6, 13);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Harry Potter', 400, 280, '1997-06-26', 7, 1);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('The Stranger', 200, 180, '1942-04-01', 8, 5);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Shadow of Chernobyl', 550, 320, '2001-06-17', 9, 6);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Doctor House', 190, 150, '1879-12-21', 10, 9);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Flights', 420, 260, '2007-05-01', 11, 12);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Call of Pripyat', 160, 140, '1945-11-26', 12, 11);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Cloudstreet', 430, 270, '1991-01-01', 13, 4);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('The Alchemist', 210, 230, '1988-04-15', 14, 14);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('The God', 340, 250, '1997-05-04', 15, 3);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Автономна Україна', 1600, 250, '1917-06-20', 3, 16);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Microsoft Excel', 1600, 250, '2005-04-29', 9, 17);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('Microsoft Windows in Nuthshell', 1600, 250, '2005-04-29', 9, 17);
insert into Books (Name, Pages, Price, PublishDate, AuthorId, ThemeId) values ('The Rules of Design', 800, 175, '2012-09-17', 2, 18);
go
insert into Shops (Name, CountryId) values ('Book Planet', 1);
insert into Shops (Name, CountryId) values ('Knowledge & Noble', 2);
insert into Shops (Name, CountryId) values ('Waterstones', 3);
insert into Shops (Name, CountryId) values ('Thalia', 4);
insert into Shops (Name, CountryId) values ('Freedom Shop', 5);
insert into Shops (Name, CountryId) values ('La Shop', 6);
insert into Shops (Name, CountryId) values ('Kinokuniya', 7);
insert into Shops (Name, CountryId) values ('Indigo', 8);
insert into Shops (Name, CountryId) values ('Libretto', 9);
insert into Shops (Name, CountryId) values ('Trotskiy', 10);
insert into Shops (Name, CountryId) values ('Empik', 11);
insert into Shops (Name, CountryId) values ('Nordiks', 12);
insert into Shops (Name, CountryId) values ('Dymocks', 13);
insert into Shops (Name, CountryId) values ('Saraevo', 14);
insert into Shops (Name, CountryId) values ('Crossword', 15);
go
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (500, 3, '2024-01-10', 1, 2);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (300, 5, '2024-02-15', 2, 7);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (200, 2, '2024-03-20', 3, 1);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (400, 4, '2024-04-12', 4, 6);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (250, 6, '2024-05-25', 5, 2);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (220, 3, '2024-06-18', 6, 8);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (280, 10, '2024-07-01', 7, 3);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (180, 7, '2024-08-09', 8, 5);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (320, 4, '2024-09-12', 9, 9);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (150, 5, '2024-10-03', 10, 10);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (260, 6, '2024-10-20', 11, 11);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (140, 8, '2024-11-05', 12, 12);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (270, 3, '2024-11-15', 13, 13);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (230, 9, '2024-11-28', 14, 14);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (250, 2, '2024-12-10', 15, 15);
insert into Sales (Price, Quantity, SaleDate, BookId, ShopId) values (110, 50, '2025-04-10', 10, 1);
