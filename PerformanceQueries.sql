--1. Look up a student by their email address.
create unique index std_emailIndex on student(email)
select * from Student where email='ammar@gmail.com'

-- 2. List every enrollment for a given student, most recent term first.
create index std_num_index on Enrollment(std_num)
create index term_date_index on Term(term_date)
alter proc sp_getEnrollForGivenStudent @std_num int
as
	select top(1000)e.* from Enrollment e
		inner join Course_offerings co
		on e.offer_id=co.offer_id
		inner join Term t
		on t.term_name=co.term_name
		where std_num=@std_num
		order by t.term_date desc
execute  sp_getEnrollForGivenStudent 1
select * from Course_offerings

-- 3. Find all students enrolled in a specific course offering.
create index offer_id on Enrollment(offer_id) 
create proc sp_getStudentEnrollInCrsOffer @offerId int
as
	 select s.* from student s 
	 inner join Enrollment e 
	 on s.std_num=e.std_num 
	 where e.offer_id=@offerId

sp_getStudentEnrollInCrsOffer 4

--4. Retrieve every course offering taught by a given instructor in a given term.
create index inst_id_index on course_offerings(inst_id)
--create nonclustered index on course_offerings(inst_id) include term_name
create index termIndex on course_offerings(term_name)
create proc sp_getCourseOfferingUsingInstAndTerm @inst_id int,@term varchar(20)
as
	select * from Course_offerings
	where inst_id=@inst_id and term_name=@term

execute sp_getCourseOfferingUsingInstAndTerm 4,'July'
select * from Course_offerings
-- 5. Produce each student's GPA by aggregating their grades across all enrollments.
create index grade_index on enrollment(grade)
select std_num,offer_id,degree,avg(grade) as GPA from Enrollment 
where std_num=1
group by std_num,offer_id,degree
select std_num,degree,avg(grade) as GPA from Enrollment 
group by std_num,degree 
order by std_num




