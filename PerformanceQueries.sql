--1. Look up a student by their email address.
create index std_emailIndex on student(email)
select * from Student where email='ammar@gmail.com'

-- 2. List every enrollment for a given student, most recent term first.
create function getEnrollForGivenStudent(@std_num int)
returns table 
as return
		select top(1000)e.* from Enrollment e
		inner join Course_offerings co
		on e.offer_id=co.offer_id
		where std_num=@std_num
		order by co.term_name

select * from getEnrollForGivenStudent(1)

-- 3. Find all students enrolled in a specific course offering.

alter function getStudentEnrollInCrsOffer(@offerId int)
returns table 
as return
	 select s.* from student s 
	 inner join Enrollment e 
	 on s.std_num=e.std_num 
	 where e.offer_id=@offerId

select * from getStudentEnrollInCrsoffer(2)

--4. Retrieve every course offering taught by a given instructor in a given term.
alter function getCourseOfferingUsingInstAndTerm(@inst_id int,@term varchar(20))
returns table
as return
		select * from course_offerings 
		where inst_id=@inst_id and term_name=@term

select * from getCourseOfferingUsingInstAndTerm(5,'July')

-- 5. Produce each student's GPA by aggregating their grades across all enrollments.

select e.std_num, e.offer_id,e.degree,avg(e.crs_std_grade) as GPA from Enrollment e
group by e.std_num,e.offer_id,e.degree
	




