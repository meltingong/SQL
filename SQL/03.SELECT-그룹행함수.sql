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









