create table report 
(	
	dep_name varchar(20),
	offer_id int,
	cnt_of_std int,
	avg_of_grade int,
	last_modified date
)
insert into report
select  d.dep_name,e.offer_id,count(s.std_num) as NumOfStudent,avg(e.grade) as AvgOfGrade,GETDATE() from Department d
	inner join Program p
	on d.dep_name=p.dep_name
	inner join Student s
	on p.prog_name=s.prog_name
	inner join Enrollment e
	on s.std_num=e.std_num
	inner join course_offerings co
	on co.offer_id=e.offer_id
	group by d.dep_name,e.offer_id

alter trigger updateReport
on enrollment after insert,update
as
	begin
			truncate table report
			insert into report
			select  d.dep_name,e.offer_id,count(s.std_num) as NumOfStudent,avg(e.grade) as AvgOfGrade,GETDATE() from Department d
				inner join Program p
				on d.dep_name=p.dep_name
				inner join Student s
				on p.prog_name=s.prog_name
				inner join Enrollment e
				on s.std_num=e.std_num
				inner join course_offerings co
				on co.offer_id=e.offer_id
				group by d.dep_name,e.offer_id
	end

delete from enrollment where offer_id=1 and std_num=5 and grade=90 and degree=2
select * from report

insert into Enrollment(offer_id,std_num,grade,degree) values
(1,2,90,2),
(1,5,90,2),
(1,7,90,2)
select * from report
select * from Enrollment

