<--------------- SQL 2018 Exam Paper --------------->

create table Location(
    LocationName varchar(255) not null, 
    primary key (LocationName)
    );

create sequence seq_GuideID
minvalue 1
start with 1
increment by 1
cache 10;

create table Guide (
    GuideID int not null,
    GivenName varchar(255) not null,
    FamilyName varchar(255) not null,
    MobileNo int null,
    primary key (GuideID)
    );
    
create sequence seq_TourID
minvalue 1
start with 1
increment by 1
cache 10;
    
create table Tour(
    TourID int not null,
    TourName varchar(255) not null,
    TourPrice int not null, 
    TourStartTime int not null, 
    GuideID int,
    primary key(TourID),
    constraint FK_GuideID foreign key (GuideID) references Guide(GuideID)
    );

    
create table TourLocations(
    TourID int not null, 
    LocationName varchar(255),
    constraint FK_TourID foreign key (TourID) references Tour(TourID),
    constraint FK_LocationName foreign key (LocationName) references Location(LocationName)
    );

------- Part (i) ---------
SELECT TourName, TourPrice
FROM Tour
ORDER BY (TourName) ASC;

------- Part (ii) --------- 
SELECT Tour.TourName, TourLocations.LocationName
FROM Tour, TourLocations
WHERE Tour.TourID=TourLocations.TourID
AND 
(SELECT COUNT(LocationName) from TourLocations
GROUP BY (Tour.TourName)) > 1;

------- Part (iii) --------- INCORRECT / CANT FIGURE OUT??!@?!?!?!
SELECT TourLocations.LocationName 

SELECT LocationName from TourLocations
GROUP BY LocationName
HAVING COUNT(LocationName) > 1;

SELECT Tour.TourName, TourLocations.LocationName
FROM Tour, TourLocations
WHERE Tour.TourID=TourLocations.TourID
AND
(SELECT LocationName from TourLocations
GROUP BY Tour.TourName
HAVING COUNT(LocationName) > 1);

SELECT LocationName from TourLocations
HAVING COUNT(LocationName) > 1
GROUP BY LocationName;


(SELECT LocationName from TourLocations
GROUP BY (LocationName)
HAVING COUNT(LocationName) > 1;

SELECT LocationName from TourLocations
GROUP BY (LocationName)
HAVING COUNT(LocationName) > 1;

------- Part (iv) ---------
SELECT * from Location
WHERE LocationName='%caves%';

------- Part (v) ---------
SELECT * from Guide
WHERE GuideID NOT IN 
(SELECT GuideID from Tour);

<--------------- SQL 2017 Exam Paper --------------->

create table Person (
    pid int not null,
    name varchar(255) not null,
    street varchar(255) not null,
    postcode varchar(255) not null,
    primary key (pid)
    );
    
create table car (
    cid int not null,
    year int not null,
    model varchar(255),
    primary key (cid)
    );
    
create table OwnedBy (
    pid int not null,
    cid int not null,
    constraint FK_pid foreign key (pid) references Person(pid),
    constraint FK_cid foreign key (cid) references car(cid)
    );

create table AccidentReport (
    rid int not null,
    damage int not null,
    details varchar(255) null,
    primary key (rid)
    );

create table ParticipatedIn (
    pid int not null,
    rid int not null,
    cid int not null,
    constraint FK_Part_pid foreign key (pid) references Person(pid),
    constraint FK_Part_rid foreign key (rid) references AccidentReport(rid),
    constraint FK_Part_cid foreign key (cid) references car(cid)
    );
------- Part (i) ---------   
SELECT DISTINCT pid 
FROM ParticipatedIn;

------- Part (ii) ---------
SELECT rid, COUNT(pid) from ParticipatedIn 
GROUP BY rid HAVING COUNT(pid) > 0;


SELECT rid, COUNT(cid) from ParticipatedIn 
GROUP BY  rid
HAVING COUNT (cid) > 0;
------- Part (iii) ---------
SELECT rid, COUNT(cid) from ParticipatedIn 
GROUP BY rid HAVING COUNT(cid) > 0;


<--------------- SQL 2016 Exam Paper --------------->


create table ORDERR (
    OrderNumber int not null,
    OrderDate DATE not null,
    CustomerCode int not null,
    primary key (OrderNumber)
    );
    
create table PRODUCT (
    ProductNumber int not null,
    Description varchar(255) not null,
    UnitPrice int not null,
    primary key (ProductNumber)
    );
    
create table ORDERLINE (
    OrderNumber int null,
    ProductNumber int null,
    QuantityOrder int not null,
    constraint FK_ORDERNO foreign key (OrderNumber) references ORDERR(OrderNumber),
    constraint FK_ProductNumber foreign key (ProductNumber) references PRODUCT(ProductNumber)
    );

------- Part (i) ---------   
SELECT Description from PRODUCT
WHERE ProductNumber=
(SELECT ProductNumber from ORDERLINE
    WHERE OrderNumber=3);
    
------- Part (ii) ---------
SELECT * FROM PRODUCT
WHERE ProductNumber=
    (SELECT ProductNumber from ORDERLINE
        WHERE OrderNumber=
        (SELECT OrderNumber from ORDERR
            WHERE CustomerCode=4));
            
------- Part (iii) --------- 
SELECT OrderNumber from ORDERLINE
WHERE ProductNumber NOT IN
    (SELECT ProductNumber from PRODUCT);
    
------- Part (iv) ---------
SELECT * from PRODUCT
WHERE ProductNumber NOT IN
    (SELECT ProductNumber from ORDERLINE);

------- Part (v) --------- ************** NOT SURE
    
SELECT OrderNumber, SUM(QuantityOrder) as TotalQuanity from ORDERLINE
GROUP BY OrderNumber;
<--------------- SQL 2016 Summer Exam Paper --------------->

create table Branch (
    Name varchar(64) not null,
    Location varchar(255) not null,
    primary key (Name)
    );
    
create table Book (
    ID int not null, 
    Title varchar(255) not null,
    Category varchar(255) null,
    Publisher varchar(255) null,
    DueDue DATE not null,
    BorrowerID int not null,
    BrachName varchar(255) not null,
    primary key (ID)
    );
    
create table Author (
    ID int not null,
    Name varchar(64) not null,
    BookID int not null,
    primary key (ID)
    );
    
create table Borrower (
    ID int not null,
    Name varchar(64) not null,
    Address varchar(255) not null,
    primary key (ID)
    );

------- Part (i) ---------
SELECT Name from Author
WHERE BookID=
(SELECT ID from Book
WHERE Title='%The Origin of Species%');

------- Part (ii) ---------
SELECT Title, COUNT(Title) as NumberofCopies from Book
WHERE ID=
(SELECT BookID from Author
WHERE Name='%Milan Kundera%')
GROUP BY Title;

------- Part (iii) ---------
SELECT * from Book
WHERE DueDue <= '2013-05-31' 
AND BrachName='Kevin Street';

------- Part (iv) --------- NO IDEA WHAT QUESTION EVEN IS?!?!?!?
SELECT


------- Part (v) ---------
SELECT * from Borrower
WHERE ID=
(SELECT BorrowerID FROM Book
GROUP BY BorrowerID
HAVING COUNT(BorrowerID) > 5);