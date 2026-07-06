use UniversityEnrollmnet
insert into Department values
(newid(),'dep_1',1,'123'),
(newid(),'dep_2',2,'456'),
(newid(),'dep_3',3,'679')
go
insert into Program (prog_name,dep_name) values
('prg_1','dep_1'),
('prg_2','dep_2'),
('prg_3','dep_3')
go
insert into Term(term_name) values
('July'),
('Jan'),
('sep')
go
insert into Office(inst_id,office_name) values
(2,'off_2'),
(4,'off_4'),
(5,'off_5'),
(3,'off_3')
go
insert into Student(std_num,fullName,dateOfBirth,prog_name,grade,email) values
(1,'ammar mostafa','2001-06-13','prg_1',1,'ammar@gmail.com'),
(2,'ali khaled','2001-07-10','prg_3',2,'ali@gmail.com'),
(3,'saad samir','2003-01-31','prg_2',3,'saad@gmail.com'),
(4,'ahmed mohamed','2002-05-20','prg_1',4,'ahmed@gmail.com'),
(5,'hany ahmed','2000-09-30','prg_2',5,'hany@gmail.com'),
(6,'mostafa mohamed','2000-02-12','prg_3',6,'mostafa@gmail.com'),
(7,'mohamed ibrahim','2001-08-31','prg_1',3,'mohamed@gmail.com'),
(8,'mahmoud nagy','2002-03-29','prg_2',5,'mahmoud@gmail.com'),
(9,'eman mohamed','2001-02-25','prg_1',6,'eman@gmail.com'),
(10,'waleed mostafa','2002-03-19','prg_3',4,'waleed@gmail.com')

go
insert into Course(code,title,credit_hours,dep_name) values
(1,'c#',20,'dep_1'),
(2,'javascript',40,'dep_1'),
(3,'c#',50,'dep_2'),
(4,'c#',30,'dep_3'),
(5,'Algorithm',15,'dep_2'),
(6,'data structure',40,'dep_1'),
(7,'Angular',30,'dep_3'),
(8,'css',10,'dep_2')

go
insert into Instructor(inst_id,name,depName) values
(1,'sameh','dep_1'),
(2,'mahmoud','dep_2'),
(3,'abdo','dep_2'),
(4,'omar','dep_1'),
(5,'smay','dep_3')
go
insert into Prerequisites values
(1,4),
(4,3),
(1,3),
(1,6),
(5,6),
(8,2),
(2,7),
(8,7)
go
insert into Enrollment (offer_id,std_num,grade,degree) values
(1,1,61,1),
(3,2,72,6),
(5,5,61,4),
(2,3,92,5),
(3,4,95,3),
(6,10,33,2),
(5,7,82,5),
(1,9,75,4),
(4,8,51,6),
(1,8,64,1),
(5,6,32,3),
(2,5,43,5),
(4,4,47,4),
(6,1,78,2),
(3,6,94,1)

go
insert into course_offerings(offer_id,room_num,crs_code,inst_id,crs_time,term_name) values
(1,1,1,1,'2026-01-16','Jan'),
(2,2,3,4,'2026-07-05','July'),
(3,3,8,2,'2026-09-26','sep'),
(4,2,6,5,'2026-07-12','July'),
(5,5,5,3,'2026-01-15','Jan'),
(6,4,7,1,'2026-09-25','sep')


