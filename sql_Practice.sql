create database TranThanhDung_Lap3;
use TranThanhDung_Lap3;
create table Class(
ClassID int primary key not null auto_increment ,
ClassName nvarchar(255) not null,
StartDate datetime not null,
Status bit);

create table Student(
StudentID int not null primary key,
StudentName nvarchar(30) not null,
Address nvarchar(50),
Phone varchar(20),
Status bit,
ClassID int not null);

create table Subject(
SubID int not null primary key auto_increment,
SubName nvarchar(30) not null,
Credit tinyint not null default 1 check(credit >=1),
Status bit default 1);

create table Mark (
MarkID int not null primary key auto_increment,
SubID int not null unique,
StudentID int not null unique,
Mark float default 0 check(Mark between 0 and 100),
ExamTimes tinyint default 1);

-- 3
-- a
alter table Student
add foreign key (ClassID) references Class(ClassID);
-- b
alter table Class
alter startDate set default (current_date());
-- c
alter table Student
alter Status set default 1;
-- d
alter table Mark
add foreign key (SubID) references Subject(SubID),
add foreign key (StudentID) references Student(StudentID);
-- 4
insert into Class values
 (1,'A1','2008/12/20',1),
 (2,'A2','2008/12/22',1),
 (3,'B3', CURRENT_DATE,0);
 
 insert into Student values
(1,'Hung','Ha Noi','0912113113',1,1),
(2,'Hoa','Hai Phong','',1,1),
(3,'Manh','HCM','0123123123',0,2);

insert into Subject values
(1,'CF',5,1),
(2,'C',6,1),
(3,'HDJ',5,1),
(4,'RBDMS',10,1);

insert into Mark values
(1,1,1,8,1),
(2,1,2,10,2),
(3,2,1,12,1);

-- 5
-- a
set SQL_SAFE_UPDATES=0;
update student
set classID=2 
where studentname='Hung';

-- b
update Student
set Phone ='No phone'
where Phone ='' or Phone is null ;

-- c
Update Class
set ClassName = concat('New',ClassName)
Where Status =0;

-- d
update Class
set ClassName = replace(ClassName,'New','Old')
where Status = 1 and ClassName like 'New%';

-- e
Update Class
Set Status=0
Where ClassID not in (Select ClassID from Student);

-- f
Update Subject
Set Status=0
Where SubID not in (Select SubID from Mark);

-- 6
-- a
Select * From Student where StudentName like 'h%';

-- b
Select * from Class where Month(StartDate)=12;

-- c
Select Max(Credit) from Subject;

-- d
Select * from Subject
Where Credit=(Select Max(Credit) from Subject);

-- e
Select * from Subject
where Credit >=3 and Credit <=5;

-- f
SELECT   Class.ClassID, Class.ClassName, Student.StudentName, Student.Address
from  Class INNER JOIN
Student ON Class.ClassID = Student.ClassID;

-- g
Select * from Subject
Where SubID not in (Select SubID from Mark);

-- 7
-- a
Delete from Class where Status=0;
-- b
Delete from Subject Where SubID Not in (Select SubID from Mark);

-- 8
-- a
alter table mark
drop column examtimes;

-- b
alter table Class
change status ClassStatus bit;

-- c
rename table Mark to SubjectTest;

-- e
drop database tranthanhdung_lap3