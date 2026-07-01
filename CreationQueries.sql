create database UniversityEnrollment
create table Student 
(  
	std_id uniqueidentifier default newid() primary key,
	std_num int unique,
	fullName varchar(200),
	dateOfBirth date,
	email varchar(100),
	prog_name varchar(50),
	grade int,
	constraint std_c1 foreign key(prog_name) references Program(prog_name),
)
go
create table Department
(
	dep_id uniqueidentifier default newid() primary key,
	dep_name varchar(20) unique,
	building_number int,
	phone_number varchar(20),
)
go
create table Term
(
	term_id uniqueidentifier default newid() primary key,
	term_name varchar(20) unique,
)
go
create table Program
(
	prog_id uniqueidentifier default newid() primary key,
	prog_name varchar(20) unique,
	dep_name varchar(20),
	constraint prg_c1 foreign key(dep_name) references Department(dep_name)
)
go
create table Office 
(
	office_id uniqueidentifier default newid() ,
	inst_id int,
	office_name varchar(20),
	primary key(office_id,inst_id),
	constraint off_c1 foreign key (inst_id) references Instructor(inst_id)
)
go
create table Instructor 
(
	id uniqueidentifier default newid() primary key,
	inst_id int unique,
	name varchar(20),
	depName varchar(20),
	constraint inst_c1 foreign key (depName) references Department(dep_name)
)
go
create table Course
(
	crs_id uniqueidentifier default newid() primary key,
	code int unique,
	title varchar(20),
	credit_hours int,
	dep_name varchar(20),
	constraint crs_c1 foreign key(dep_name) references Department(dep_name),
)
go
create table Prerequisites
(
	pre_req int ,
	crs_code int,
	primary key (crs_code,pre_req),
	constraint req_c1 foreign key(crs_code) references Course(code),
	constraint req_c2 foreign key(pre_req) references Course(code),
	constraint req_c3 check (pre_req!=crs_code)
)
go
create table Enrollment
(
	enroll_id uniqueidentifier default newid() primary key,
	offer_id int,
	std_num int,
	crs_std_grade int,
	degree int,
	constraint enroll_c1 foreign key(offer_id) references Course_offerings(offer_id),
	constraint enroll_c2 foreign key(std_num) references Student(std_num),
)
go
create table Course_offerings
(
	crs_offer_id uniqueidentifier default newid() primary key,
	offer_id int unique,
	room_num int,
	crs_code int,
	inst_id int,
	crs_time date,
	term_name varchar(20),
	constraint crs_offer_c1 foreign key(term_name) references Term(term_name),
	constraint crs_offer_c2 foreign key(crs_code) references Course(code),
	constraint crs_offer_c3 foreign key(inst_id) references Instructor(inst_id),
	constraint crs_offer_c4 unique(crs_code,inst_id,term_name)
)


