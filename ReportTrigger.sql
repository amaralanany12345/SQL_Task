alter view reportView 
as
select  count(s.std_num) as NumOfStudent,avg(e.crs_std_grade) as AvgOfGrade,d.dep_name from Department d
	inner join Program p
	on d.dep_name=p.dep_name
	inner join Student s
	on p.prog_name=s.prog_name
	inner join Enrollment e
	on s.std_num=e.std_num
	inner join course_offerings co
	on co.offer_id=e.offer_id
	group by d.dep_name

create trigger updateReport
on Enrollment after insert
as
	begin
		select * from reportView
	end

insert into Enrollment(offer_id,std_num,crs_std_grade,degree) values
(4,5,82,1)

