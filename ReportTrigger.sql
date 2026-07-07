create table report 
(	
	dep_name varchar(20),
	offer_id int,
	cnt_of_std int,
	avg_of_grade int,
	last_modified date
)
truncate table report
insert into report
	select  d.dep_name,e.offer_id,count(e.std_num) as NumOfStudent,avg(e.grade) as AvgOfGrade,GETDATE()
	from Department d
	inner join Program p
	on d.dep_name=p.dep_name
	inner join Student s
	on p.prog_name=s.prog_name
	inner join Enrollment e
	on s.std_num=e.std_num
	group by d.dep_name,e.offer_id

alter function getUpdatedReport()
returns table
as return 
				select d.dep_name,e.offer_id,count(s.std_num) as NumOfStudent
				,avg(e.grade) as AvgOfGrade,last_modified=GETDATE()
				from Department d
				inner join Program p
				on d.dep_name=p.dep_name
				inner join Student s
				on p.prog_name=s.prog_name
				inner join Enrollment e
				on s.std_num=e.std_num
				group by d.dep_name,e.offer_id

alter trigger updateReport
on Enrollment after insert,update
as
	begin	
			merge report as target 
			using
				(
				select distinct n.* 
				from getUpdatedReport() n
				inner join inserted i
				on i.offer_id=n.offer_id 
				) 
				as source
				on target.offer_id=source.offer_id and target.dep_name=source.dep_name
			when matched then 
				update set cnt_of_std=source.NumOfStudent , avg_of_grade= source.AvgOfGrade ,last_modified=getdate()
			when not matched then
				insert (dep_name,offer_id, cnt_of_std, avg_of_grade,last_modified)
				values (source.dep_name,source.offer_id,source.NumOfStudent,source.AvgOfGrade,getdate());
				select * from report order by offer_id

	end

delete from enrollment where offer_id=1 and std_num=7 and grade=90 and degree=2
delete from enrollment where offer_id=1 and std_num=5 and grade=90 and degree=2
delete from enrollment where offer_id=1 and std_num=2 and grade=90 and degree=2

insert into Enrollment(offer_id,std_num,grade,degree) values
(1,7,90,2),
(1,2,90,2),
(1,5,90,2)
select * from getUpdatedReport() order by offer_id

