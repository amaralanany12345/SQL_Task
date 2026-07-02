-- 1
select * from Student
-- 2
select distinct s.fullName,co.crs_std_grade from Student s
inner join Course_offerings co
on s.std_num=co.std_num
order by co.crs_std_grade
-- 3
select * from Course where credit_hours>20
-- 4
select count(*),depName from Instructor group by depName
-- 5
select * from (
select *,dense_rank() over (order by dep_name) as rn from Course
) as newTable
where rn>2
-- 6
select top(2)* from Course_offerings order by crs_std_grade desc
-- 7
select * from prerequisites p
left join Course c
on p.crs_code=c.code
--8
select *,lag(std_num) over(order by crs_std_grade) as lagStd,
lead(std_num) over (order by crs_std_grade) from Course_offerings
--9
select * from Student where fullName like '%a' or fullName like 'a%'
--10
select * from Course_offerings where crs_time>GETDATE()
--11
select grade,count(title) as cnt from Enrollment 
inner join Course 
on crs_code=code
group by grade
having count(title)>3
--12
select count(inst_id) as cnt,term_name from Course_offerings group by term_name
--13
alter view getStudentV1
as
	select * from Student

select * from getStudentV1
--14
create function getCourseNameById(@code int)
returns varchar(20)
begin
	declare @name varchar(20)
	select @name=title from Course where code=@code
	return @name
end

select  dbo.getCourseNameById(2)
--15
create proc insertInEnrollMent @grade int, @std_num int ,@code int,@inst_id int
as
	insert into Enrollment values
	(@grade,@std_num,@code,@inst_id)

execute insertInEnrollMent 3,8,3,5
select * from Enrollment 
--16
declare c1 cursor
for select std_num,crs_code,crs_std_grade from Course_offerings
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
--17
select count(inst_id),term_name from course_offerings group by term_name
--18
select top(1)* from Course_offerings co
inner join Enrollment e
on co.std_num=e.std_num and co.crs_code=e.std_num
order by co.crs_std_grade 
--19
select c.* from Course c
left join Prerequisites p 
on p.crs_code=c.code
--20
select s.fullname , c.title from student s
inner join Enrollment e
on s.std_num=e.std_num
inner join Course_offerings co
on co.offer_id=e.offer_id
inner join Course c
on c.code=co.crs_code
--21
select top(1) fullname from Student order by len(fullName) desc
--22
select i.* from Instructor i
left join Office o
on o.inst_id=i.inst_id
--23
select * from
(
select *,dense_RANK() over (order by crs_std_grade ) as dr from Enrollment 
) as newTable 
where dr=2
--24
update Enrollment set crs_std_grade=83 where degree=3and std_num=6