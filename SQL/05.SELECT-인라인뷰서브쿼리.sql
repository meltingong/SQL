--in line view subquery
--view (논리적테이블)

create or replace view emp10_view
as
select empno, ename, job, sal
from emp
where deptno = 10;

--view
select * from emp10_view;


select * from (select empno, ename, job, sal
                from emp
                where deptno = 10);
/********************************************************
부서별로 최소연봉을 가진 직원의 사번,이름,연봉을 읽어오세요
*********************************************************/

--부서별 최소 연봉
select deptno, min(sal) "min_sal" 
from emp 
group by deptno;

--직원의 사번,이름, 연봉테이블
select empno,ename, sal, deptno from emp;

select * 
from emp e1
    join (select deptno, min(sal) "min_sal" 
                        from emp 
                        group by deptno) e2
    on e1.deptno = e2.deptno and e1.sal = e2."min_sal"; 

/*************************************************************
동일한 직급을 가진 사원의 평균연봉 보다 연봉이 높은 사원들 출력
**************************************************************/

--1. 동일한 직급을 가진 사원 평균 연봉테이블
    select job ,avg(sal) "job_avg_sal" from emp group by job;
    
--사원테이블
    select e1.*,e2.job,round(e2."job_avg_sal") 
    from emp e1
    join(select job ,avg(sal) "job_avg_sal" 
            from emp 
            group by job) e2 
    on e1.job = e2.job and e1.sal > e2."job_avg_sal";

--rank()함수 , dense_rank()함수
select  empno,ename,job,sal, 
        rank() over(order by sal desc) "급여순위" 
    from emp;

--2975 sal값의 순위(within group)
select rank(2975) within group(order by sal desc) "급여순위" from emp;
    
select  empno,ename,job,sal, 
        dense_rank() over(order by sal desc) "급여순위" 
    from emp;
    
select  empno,ename,job,sal,deptno, 
        rank() over(partition by deptno order by sal desc) "급여순위" 
    from emp;
    
select  empno,ename,job,sal, 
        rank() over(order by ename asc) "이름순위" 
    from emp;

--사원테이블에서 입사일의 순위
select  empno,ename,hiredate, 
        rank() over(order by hiredate asc) "입사일 순위" 
    from emp;

--1981/09/28 입사한 사원의 순위
select  rank(to_date('1981/09/28','YYYY/MM/DD'))  within group(order by hiredate asc) "순위" from emp;


select * from (select empno, ename, sal, 
                    rank() over(order by sal desc) "급여순위" 
                    from emp) e
            where e."급여순위" >= 1 and e."급여순위" <=3;

--row_number()
select empno,ename,job,sal, row_number() over (order by sal desc) "급여순위" from emp;

--rownum
/*
 rownum (pseudo(유사) column)
    - 오라클에서만 사용가능한컬럼
    - select시에 조건에맞는 행에 순차적부여
    - where 조건문에서 1번을 포함하는범위조건내에서는 사용가능
    - where 조건문에서 1번을 포함하지않는 범위조건내에서는 사용불가능
*/
select rownum, empno, ename, sal from emp order by sal desc;

select * from (select rownum rn,e.* 
                from  (select * 
                        from emp 
                        order by sal desc) e
                    )
where rn =1;
                
--fetch rows
--오라클 12버전부터 추가
select empno, ename, job, sal from emp order by sal desc fetch first 5 rows only;
select empno, ename, job, sal from emp order by sal desc fetch first 2 rows with ties;
select empno, ename, job, sal from emp order by sal desc offset 9 rows; --offset 0 base 9 (10번째 이후~)
select empno, ename, job, sal from emp order by sal desc offset 9 rows fetch first 2 rows only; --offset 0 base 9 (9번째 이후 2 row)
-- select rownum,empno, ename, job, sal from emp where rownum < 5 order by sal desc;
select * from (select rownum rn,e.* 
                from(select empno,ename,job,sal from emp order by sal desc) e 
                    )
        where rn < 5;

                
                
                
                
                
                
                
