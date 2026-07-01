--1. Look up a student by their email address.
create index std_emailIndex on student(email)
select * from Student where email='ammar@gmail.com'

-- 2. List every enrollment for a given student, most recent term first.

select s.* from Student s inner join(
select e.std_num as sn,co.term_name as termName from Enrollment e
inner join Course_offerings co
on e.offer_id=co.offer_id) as newTable
on s.std_num=sn
order by termName

-- 3. Find all students enrolled in a specific course offering.

create function getStudentEnrollInCrsOffer(@offerId int)
returns table 
as return
	 select s.* from student s inner join(
	 select std_num as sd from Enrollment 
	 where offer_id=@offerId) as newTable 
	 on std_num=sd

select * from getStudentEnrollInCrsoffer(2)

--4. Retrieve every course offering taught by a given instructor in a given term.
create function getCourseOfferingUsingInstAndTerm(@inst_id int,@term varchar(20))
returns table
as return
		select * from course_offerings 
		where inst_id=@inst_id and term_name=@term

select * from getCourseOfferingUsingInstAndTerm(4,'July')

-- 5. Produce each student's GPA by aggregating their grades across all enrollments.

select avg(e.crs_std_grade) as GPA,e.std_num, e.offer_id,e.degree from Enrollment e
group by e.std_num,e.offer_id,e.degree
	




