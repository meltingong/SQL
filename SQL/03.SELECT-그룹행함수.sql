--그룹함수
--emp테이블 (전체사원그룹)
select  sum(sal) "사원전체급여합",
        min(sal) "사원전체최소급여",
        max(sal) "사원전체최대급여",
        avg(sal) "사원급여평균",
        avg(nvl(comm,0)) "평균커미션",
        count(empno) "사원번호 개수",
        count(comm) "커미션 받는 사원 수??",
        count(*) "사원수(null포함)"
from emp;

--부서별로 그룹핑(emp 테이블 안에서)
select deptno,
        count(*) "부서별 인원 수",
        round(avg(sal)) "부서별 급여 평균",
        max(sal) "부서별 최소 급여",
        min(sal) "부서별 최소 급여",
        sum(sal) "부서별 급여 합"
from emp
where 1=1
group by deptno
order by deptno;

--부서별인원수 5명이하인 부서출력
--having(grouping 이후 filtering)
select deptno,count(*) "사원수"
from emp
group by deptno
having count(*) >= 5;
--부서별 평균 급여가 2000 이상인 부서 부서번호,부서별 평균 급여 출력
select  deptno,
        avg(sal) "부서별 평균 급여"
from emp
group by deptno
having avg(sal) >= 2000
order by "부서별 평균 급여" desc;

--직급별로 그룹핑
select  job ,
        count (*) "직급별 사원 수",
        round(avg(sal)) "직급별 급여 평균",
        sum(sal) "직급별 급여 합"
from emp
group by job
order by job;

--직급별 급여평균이 3000이상인 직급,직급별급여평균,직급별 사원수 출력
select  job,
        round(avg(sal)) "직급별 급여 평균",
        count(*) "직급별 사원 수"
from emp
group by job
having avg(sal) >= 3000;

--사원테이블에서 부서별 부서내에서 업무별 인원 수(급여평균,급여합계)

select  deptno,job,
        count(*) "부서 및 업무별 인원수",
        round(avg(sal)) "부서,업무별 급여평균",
        sum(sal) "부서,업무별 급여합계"
from emp
group by deptno,job
order by deptno asc,job asc;

--가로출력
select  deptno,
        sum(sal)
from emp
group by deptno
order by deptno;

/*
  DEPTNO   SUM(SAL)
---------- ----------
        10       8750
        20      10875
        30       9400
*/

select  sum(sal) from emp;
/*
        10         20         30      
---------- ---------- ----------
      8750      10875       9400    
*/
select  sum(decode(deptno,'10',sal)) as "10" , 
        sum(decode(deptno,'20',sal)) as "20" , 
        sum(decode(deptno,'30',sal)) as "30" , 
        sum(sal) "전체급여합" from emp;
        
/*
JOB         SUM(SAL)
--------- ----------
CLERK           4150
SALESMAN        5600
PRESIDENT       5000
MANAGER         8275
ANALYST         6000

*/

select job,sum(sal) from emp
group by job;

--rollup()함수 : 총계 산출(아래쪽에 총계 산출)
select job,sum(sal) from emp
group by rollup(job);

select deptno,job,sum(sal) from emp
group by rollup(deptno,job);

--cube()함수 : 총계 산출(위쪽에 총계 산출)
select job,sum(sal) from emp
group by cube(job);

select deptno,job,sum(sal) from emp
group by cube(deptno,job);


select  sum(decode(job,'CLERK',sal)) "CLERK",
        sum(decode(job,'MANAGER',sal)) "MANAGER",
        sum(decode(job,'PRESIDENT',sal)) "PRESIDENT",
        sum(decode(job,'ANALYST',sal)) "ANALYST",
        sum(decode(job,'SALESMAN',sal)) "SALESMAN"
from emp;




/*
 DEPTNO      CLERK    MANAGER  PRESIDENT    ANALYST   SALESMAN
---------- ---------- ---------- ---------- ---------- ----------
        10       1300       2450       5000                      
        20       1900       2975                  6000           
        30        950       2850                             5600
*/
select  deptno,
        sum(decode(job,'CLERK',sal)) "CLERK",
        sum(decode(job,'MANAGER',sal)) "MANAGER",
        sum(decode(job,'PRESIDENT',sal)) "PRESIDENT",
        sum(decode(job,'ANALYST',sal)) "ANALYST",
        sum(decode(job,'SALESMAN',sal)) "SALESMAN"
from emp
group by deptno
order by deptno asc;



select  deptno, 
        sum(sal) "CLERK", sum(sal) "MANAGER",sum(sal) "PRESIDENT",sum(sal) "ANALYST" ,sum(sal) "SALESMAN"
from emp
group by deptno
order by deptno asc;

--listagg() : 가로출력 함수

select listagg(ename,',') within group(order by ename) from emp;

select deptno,listagg(ename,'/') within group(order by ename) 
    from emp
    group by deptno;

select deptno,job,listagg(ename,'/') within group(order by ename) 
    from emp
    group by deptno,job;

select job,sum(sal),listagg(ename||'('||sal||')',',') within group (order by sal) from emp group by job;

























