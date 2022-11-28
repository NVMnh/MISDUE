Create Database TrainingDB
Use TrainingDB
Create Table COURSES
(
Cno char(6) not null primary key,Cname varchar(50) not null,Credit int not null)
Create Table STUDENTS
(
Sno char(8) not null primary key,Sname varchar(50) not null,DateOfBirth date,Class char(6) not null,Gender bit not null,Email varchar(50) not null
)
Create Table ENROLLMENTS
(
Sno char(8) not null,Cno char(6) not null,TimeEnroll Datetime not null,Semester int ,SchoolYear char(9),Fee int,Constraint PK_Enrollment primary key(Sno,Cno)
)
Alter Table STUDENTS
add Saddress varchar(120)
Alter Table STUDENTS
Drop column Email
Alter Table ENROLLMENTS
add Constraint FK_Course Foreign key (Cno) References COURSES(Cno)
Alter Table ENROLLMENTS
add Constraint FK_STUDENTS Foreign key (Sno) References STUDENTS(Sno)
Insert Into COURSES
Values ('DBI202', 'Database',3),
('BPI201','Basic Programming',3)
Select * from COURSES