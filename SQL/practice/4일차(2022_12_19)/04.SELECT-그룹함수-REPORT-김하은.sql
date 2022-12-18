/*
<<< 07. 그룹 함수.pdf >>>
1. 사원테이블에서 부서별 인원수가 6명 이상인 부서코드를 검색하시오.
*/

select deptno 
from emp
group by deptno
having count(*) >= 6;


/*
2. 사원테이블로부터 부서번호, 업무별 급여합계를 계산하고자 한다.
    다음과 같은 결과를 출력할 수 있는 SQL문장을 작성하시오.
*/
-- 일반출력

select  deptno,
        job,
        sum(sal)
from emp
group by deptno,job
order by deptno;

-- 가로출력 (과제아님)
select  deptno,
        max(decode(job,'CLERK',sal)) "CLERK",
        max(decode(job,'MANAGER',sal)) "MANAGER" ,
        max(decode(job,'PRESIDENT',sal))"PRESIDENT" ,
        max(decode(job,'ANALYST',sal)) "ANALYST",
        max(decode(job,'SALESMAN',sal)) "SALESMAN"
from(
select deptno,job,sum(sal) as sal
from emp
group by deptno,job)
group by deptno
order by deptno;



-- 3. 사원테이블로부터 년도별 , 월별 급여합계를 출력할 수 있는 SQL문장을 작성하시오.

-- 일반출력

select extract(year from hiredate) "년",
       to_char(extract(month from hiredate),'09') "월",
       sum(sal)
from emp
group by extract(year from hiredate), extract(month from hiredate)
order by "년" asc;

-- 가로출력(과제아님) 
/*
	------------------ ----------------------------------
	연도   1월    2월   3월   4월... 12월  연도별급여합
	---------------------------------------------------
	2018    10    20    40                       320
	2019
	2020
*/
select 연도,
        max(decode(월,'1',sal)) "1월",
        max(decode(월,'2',sal)) "2월",
        max(decode(월,'3',sal)) "3월",
        max(decode(월,'4',sal)) "4월",
        max(decode(월,'5',sal)) "5월",
        max(decode(월,'6',sal)) "6월",
        max(decode(월,'7',sal)) "7월",
        max(decode(월,'8',sal)) "8월",
        max(decode(월,'9',sal)) "9월",
        max(decode(월,'10',sal)) "10월",
        max(decode(월,'11',sal)) "11월",
        max(decode(월,'12',sal)) "12월"
from(
    select  extract(year from hiredate) as 연도,
            extract(month from hiredate) as 월,
            sum(sal) as sal
    from emp
    group by extract(year from hiredate),extract(month from hiredate)
    )
group by 연도
order by "연도" desc;

select extract(year from hiredate),
        max(decode(extract(month from hiredate),'1',sal)) "1월",
        max(decode(extract(month from hiredate),'2',sal)) "2월",
        max(decode(extract(month from hiredate),'3',sal)) "3월",
        max(decode(extract(month from hiredate),'4',sal)) "4월",
        max(decode(extract(month from hiredate),'5',sal)) "5월",
        max(decode(extract(month from hiredate),'6',sal)) "6월",
        max(decode(extract(month from hiredate),'7',sal)) "7월",
        max(decode(extract(month from hiredate),'8',sal)) "8월",
        max(decode(extract(month from hiredate),'9',sal)) "9월",
        max(decode(extract(month from hiredate),'10',sal)) "10월",
        max(decode(extract(month from hiredate),'11',sal)) "11월",
        max(decode(extract(month from hiredate),'12',sal)) "12월"
from(
    select  extract(year from hiredate) as 연도,
            extract(month from hiredate) as 월,
            sum(sal) as sal
    from emp
    group by extract(year from hiredate),extract(month from hiredate)
    )
group by extract(year from hiredate)
order by "연도" desc;

select  extract(year from hiredate) "연도",
        decode(extract(month from hiredate),'1',sum(sal)) "1월",
        decode(extract(month from hiredate),'2',sum(sal)) "2월",
        decode(extract(month from hiredate),'3',sum(sal)) "3월",
        decode(extract(month from hiredate),'4',sum(sal)) "4월",
        decode(extract(month from hiredate),'5',sum(sal)) "5월",
        decode(extract(month from hiredate),'6',sum(sal)) "6월",
        decode(extract(month from hiredate),'7',sum(sal)) "7월",
        decode(extract(month from hiredate),'8',sum(sal)) "8월",
        decode(extract(month from hiredate),'9',sum(sal)) "9월",
        decode(extract(month from hiredate),'10',sum(sal)) "10월",
        decode(extract(month from hiredate),'11',sum(sal)) "11월",
        decode(extract(month from hiredate),'12',sum(sal)) "12월",
        sum(sal)
from emp
group by extract(year from hiredate),extract(month from hiredate)
order by "연도" desc;

/*
4. 사원테이블에서 부서별 comm(커미션) 을 포함하지 않은 연봉의 합과
   포함한 연봉의 합을 구하는 SQL을 작성하시오.
*/
-- 커미션 포함 X

select  deptno,
        sum(sal) "커미션 불포함"
from emp
group by deptno
order by deptno asc;


-- 커미션 포함 

select  deptno,
        sum(sal+nvl(comm,0)) "연봉"
from emp
group by deptno
order by deptno asc;

/*
5. 사원테이블에서 SALESMAN을 제외한 JOB별 급여합계를 구하시오.
*/

select  job,
        sum(sal)
from emp
where job != 'SALESMAN'
group by job;