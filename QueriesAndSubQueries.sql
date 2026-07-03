go
select * from Student
go
select distinct s.fullName,e.crs_std_grade from Student s
inner join Enrollment e
on s.std_num=e.std_num
order by e.crs_std_grade
go
select * from Course where credit_hours>20
go
select count(*),depName from Instructor group by depName
go
select * from (
select *,dense_rank() over (order by dep_name) as rn from Course
) as newTable
where rn>2
go
select top(2)* from Enrollment order by crs_std_grade desc
go
select * from prerequisites p
left join Course c
on p.crs_code=c.code
go
select *,lag(std_num) over(order by crs_std_grade) as lagStd,
lead(std_num) over (order by crs_std_grade) from Enrollment
go
select * from Student where fullName like '%a' or fullName like 'a%'
go
select * from Course_offerings where crs_time>GETDATE()
go
select degree,count(title) as cnt from Enrollment e
inner join Course_offerings co
on e.offer_id=co.offer_id
inner join Course c
on co.crs_code=c.code
group by degree
having count(title)>3
go
select count(inst_id) as cnt,term_name from Course_offerings group by term_name
go
alter view getStudentV1
as
	select * from Student

select * from getStudentV1
go
create function getCourseNameById(@code int)
returns varchar(20)
begin
	declare @name varchar(20)
	select @name=title from Course where code=@code
	return @name
end

select  dbo.getCourseNameById(2)
go
create proc insertInEnrollMent @grade int, @std_num int ,@code int,@inst_id int
as
	insert into Enrollment values
	(@grade,@std_num,@code,@inst_id)

execute insertInEnrollMent 3,8,3,5
select * from Enrollment 
go
declare c1 cursor
for select e.std_num,co.crs_code,e.crs_std_grade from Course_offerings co
inner join Enrollment e
on e.offer_id=co.offer_id
declare @std_num int,@crs_code int,@grade int
open c1
fetch c1 into @std_num ,@crs_code,@grade 
while @@FETCH_STATUS=0
	begin
		declare @t table(name varchar(20),grade int,rate varchar(20))
		if @grade<60
			begin
				insert into @t select fullName,grade,'good' from Student where std_num=@std_num
			end
		else if @grade>=60 and @grade<75
			insert into @t select fullName,grade,'very good' from Student where std_num=@std_num
		else
			insert into @t select fullName,grade,'excellent' from Student where std_num=@std_num
		fetch c1 into @std_num ,@crs_code,@grade
	end
select * from @t
close c1
deallocate c1
go
select count(inst_id),term_name from course_offerings group by term_name
go
select top(1)s.fullName,e.crs_std_grade from Student s
inner join Enrollment e
on s.std_num=e.std_num
order by crs_std_grade desc
go
select c.* from Course c
left join Prerequisites p 
on p.crs_code=c.code
go
select s.fullname , c.title from student s
inner join Enrollment e
on s.std_num=e.std_num
inner join Course_offerings co
on co.offer_id=e.offer_id
inner join Course c
on c.code=co.crs_code
go
select top(1) fullname from Student order by len(fullName) desc
go
select i.* from Instructor i
left join Office o
on o.inst_id=i.inst_id
go
select * from
(
select *,dense_RANK() over (order by crs_std_grade ) as dr from Enrollment 
) as newTable 
where dr=2
go
update Enrollment set crs_std_grade=83 where degree=3and std_num=6
go
create function getCoursePreRequites(@code int)
returns table
as return
		select c.title as crs,c2.title as pre from prerequisites p
		inner join Course c
		on p.crs_code=c.code
		inner join Course c2
		on c2.code=p.pre_req
		where c.code=@code
select * from getCoursePreRequites(6)
go
select t.term_name,count(co.crs_code) from Course_offerings co
inner join Term t
on t.term_name=co.term_name
group by t.term_name
go
alter function getInstructorNameById(@id int)
returns varchar(20)
	begin
		declare @name varchar(20)
		select @name=name from Instructor
		where inst_id=@id
		return @name
	end
go
select  dbo.getInstructorNameById(2)
select * from Instructor




