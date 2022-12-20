--ORACLE JOIN

--cross join(catesian product)
select e.*,d.* from emp e, dept d;

--equi join(동등조인)
/*
 inner join : 조인조건에 만족하는     행만 출력
 outer join : 조인조건에 만족하지않는 행도 출력
*/

/*
inner join :
    - 조인조건에 만족하는     행만 출력
    - 부서번호를 가진사원만출력(부서를 배정받은사원출력)
*/
select *
from emp e, dept d
where e.deptno = d.deptno;

/*
left outer join :
    - 조인조건에 만족하지않는 왼쪽테이블의 행도 출력
    - 부서번호를 가지지않는 사원도출력(부서를 배정받지못한사원도출력)
*/

select e.*,d.*
from emp e, dept d
where e.deptno = d.deptno (+);

/*
right outer join :
    - 조인조건에 만족하지않는 오른쪽테이블의 행도 출력
    - 사원이소속되있지않은 부서정보도출력
*/

select e.*,d.*
from emp e, dept d
where e.deptno (+) = d.deptno;

/*************************************************************************
full outer join 
    - 조인조건에 만족하지 않는 왼쪽,오른쪽 테이블의 행도 출력
    - 부서번호를 가지지 않은 사원 및 사원이 소속되어있지 않은 부서정보도 출력
**************************************************************************/
select e.*,d.*
from emp e, dept d
where e.deptno = d.deptno (+)
union 
select e.*,d.*
from emp e, dept d
where e.deptno (+) = d.deptno;

--non-equi-join(비동등조인)
select e.empno, e.ename, e.sal, g.grade 
from emp e, salgrade g
where e.sal >= g.losal and e.sal < g.hisal;

--3개 테이블조인
--student + professor + department

select s.studno,s.name "학생이름",s.profno,p.name "교수이름",s.deptno1, d.dname
from student s , professor p , department d
where s.profno = p.profno(+) and s.deptno1 = d.deptno;


select count(*) from student;
select count(*) from professor;
select count(*) from department;
select 20*16*12 "총 개수" from dual;

--self join
--inner join
select e.empno , e.ename, e.mgr, m.empno "매니저 사번", m.ename "매니저 이름" from emp e, emp m
where e.mgr = m.empno;

--left outer join(매니저가 없는 사원도 출력)
select e.empno , e.ename, e.mgr, m.empno "매니저 사번", m.ename "매니저 이름" from emp e, emp m
where e.mgr = m.empno(+);

--right outer join(담당하는 사원이 없는 매니저도 출력)
select e.empno , e.ename, e.mgr, m.empno "매니저 사번", m.ename "매니저 이름" from emp e, emp m
where e.mgr(+) = m.empno;

--full outer join(매너지가 없는 사원 및 담당하는 사원이 없는 매니저 모두 출력)
select e.empno , e.ename, e.mgr, m.empno "매니저 사번", m.ename "매니저 이름" from emp e, emp m
where e.mgr(+) = m.empno
union
select e.empno , e.ename, e.mgr, m.empno "매니저 사번", m.ename "매니저 이름" from emp e, emp m
where e.mgr = m.empno(+);




