--집합연산자
select val from a;
select num,val from b;


--union(합집합 - 중복제거)
select val from a
union
select val from b;

--union all(합집합 - 중복포함)
select val from a
union all
select val from b;

--intersect (교집합 - 중복제거)
select val from a
intersect
select val from b;

--minus(차집합)
select val from a
minus
select val from b;

select val from b
intersect
select val from a;

--컬럼의 개수가 다른 경우

select val,null from a
union 
select val,num from b;


















