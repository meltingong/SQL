/****************SELECT문실행순서************************
- FROM, JOIN > WHERE, GROUP BY, HAVING > SELECT > ORDER BY
1.FROM과 JOIN
    JOIN이 먼저 실행되어 데이터가 SET으로 모아지게 됨.
    여기에는 서브쿼리도 함께 포함되어 임시적인 테이블을 만들 수 있게 도와줌.
2.WHERE
    데이터셋을 형성하게 되면 WHERE의 조건이 개별 행에 적용이 된다. 
    이 WHERE절의 제약 조건은 FROM절로 가져온 테이블에 적용이 될 수 있다.
3.GROUP BY
    WHERE의 조건 적용 후 나머지 행은 GROUP BY절에 지정된 열의 공통 값을 기준으로 그룹화된다. 
    쿼리에 집계 기능이 있는 경우에만 이 기능을 사용해야 한다.
4.HAVING
    GROUP BY 절이 쿼리에 있을 경우 HAVING 절의 제약조건이 그룹화된 행에 적용됌.
5.SELECT
    SELECT에 표현된 식이 마지막으로 적용됨.
6.DISTINCT
    표현된 행에서 중복된 행은 삭제됨
7.ORDER BY
    지정된 데이터를 기준으로 오름차순, 내림차순을 지정
*******************************************************************************/

--JOIN[ANSI,SQL3,SQL1999]
--CROSS JOIN
select * from emp cross join dept;

--NATURAL JOIN (emp.deptno, dept.deptno 사용 불가능): 같은 이름을 가진 컬럼을 조인 조건으로 사용
select emp.empno,emp.ename,emp.job,emp.hiredate,emp.sal,deptno,dept.dname,dept.loc 
from emp 
natural join dept;

--join~using을 이요한 join : 동일이름의 컬럼이 여러 개인 경우 조인 컬럼을 지정
select empno,ename,dname,loc 
from emp join dept using (deptno);

--join ~ on
/*
    inner join : 조인조건에 만족하는      행만 출력
    outer join : 조인조건에 만족하지 않는  행도 출력
*/

/*
inner join [조인조건에 만족하는 행만 출력]
*/
select  emp.empno, emp.ename, 
        emp.deptno "사원부서번호", 
        dept.deptno "부서부서번호", 
        dept.dname, dept.loc 
from emp 
inner join dept 
on emp.deptno = dept.deptno;

--table alias (as를 사용하지 않는다)
select  e.empno, e.ename, 
        e.deptno "사원부서번호", 
        d.deptno "부서부서번호", 
        d.dname, d.loc 
from emp e
inner join dept d 
on e.deptno = d.deptno;

/*************************************************************************
left outer join 
    - 조인조건에 만족하지 않는 왼쪽 테이블의 행도 출력
    - 부서번호를 가지지 않은 사원도 출력 (부서를 배정받지 못한 사원도 출력)
**************************************************************************/

select e.* , d.*
from emp e 
left outer join dept d
on e.deptno = d.deptno;

/*************************************************************************
rigth outer join 
    - 조인조건에 만족하지 않는 오른쪽 테이블의 행도 출력
    - 사원이 소속되어있지 않은 부서정보도 출력
**************************************************************************/

select *
from emp e
right outer join dept d
on e.deptno = d.deptno;

/*************************************************************************
full outer join 
    - 조인조건에 만족하지 않는 왼쪽,오른쪽 테이블의 행도 출력
    - 부서번호를 가지지 않은 사원 및 사원이 소속되어있지 않은 부서정보도 출력
**************************************************************************/

select *
from emp e
full outer join dept d
on e.deptno = d.deptno;

-- on절 (조인조건)
select empno,ename,e.deptno,dname,loc
from emp e
join dept d
on e.deptno = d.deptno and e.deptno = 10
where e.ename != 'KIM'; -- join 이후에 where실행

--temp(dept_code) , tdept(dept_code)
select * from temp;
select * from tdept;

select emp_id, emp_name, e.dept_code, dept_name, area
from temp e join tdept d
on e.dept_code = d.dept_code;

--student(deptno1), department(deptno)
select *  from student;
select * from department;

select studno,name,s.deptno1,dname 
from student s join 
department d 
on s.deptno1 = d.deptno;

--student(deptno1,deptno2), department(deptno)
select  studno, name, s.deptno1, d1.dname "주전공",
        s.deptno2, d2.dname "부전공"
from (student s
join department d1
on s.deptno1 = d1.deptno)
join department d2
on s.deptno2 = d2.deptno;

--emp(sal) + salgrade (losal,hisal)

select empno, ename, sal, g.losal, g.hisal, g.grade "급여등급" 
from emp e 
join salgrade g
on e.sal >= g.losal and e.sal < g.hisal;

--emp(sal,deptno) + salgrade (losal,hisal) + dept(deptno) : 3개 테이블 조인

select empno, ename, sal, g.losal, g.hisal, g.grade "급여등급" ,e.deptno,dname,loc
from emp e
join salgrade g
on e.sal >= g.losal and e.sal < g.hisal
join dept d
on e.deptno = d.deptno ;

--3개 테이블 조인
--student(profno,deptno1) + professor(profno) + department(deptno)
/*
join 순서
    1. student 와 professor 조인
    2. student 와 professor 조인결과 set(테이블) 과 professor테이블 조인
*/
select studno, s.name "학생이름", p.name "교수이름", d.dname "주전공" , d2.dname "부전공"
from student s
join professor  p
on s.profno = p.profno
join department d
on s.deptno1 = d.deptno
join department d2
on s.deptno2 = d2.deptno;

--self join                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
/* 
사원과 매니저 이름 출력
inner join (매니저가 존재하는 사원)
*/

select  e.empno "사원번호" ,e.ename "사원이름",e.mgr "사원담당매니저번호",
        m.empno "매니저사원번호",m.ename "매니저이름"
from emp e
inner join emp m
on e.mgr = m.empno;

/* 
사원과 매니저 이름 출력
left outer join (매니저가 존재하는 않는 사원도 출력)
*/

select  e.empno "사원번호" ,e.ename "사원이름",e.mgr "사원담당매니저번호",
        m.empno "매니저사원번호",m.ename "매니저이름"
from emp e
left outer join emp m
on e.mgr = m.empno;

/* 
사원과 매니저 이름 출력
right outer join (관리하는 사원이 없는 매니저 출력)
*/

select  e.empno "사원번호" ,e.ename "사원이름",e.mgr "사원담당매니저번호",
        m.empno "매니저사원번호",m.ename "매니저이름"
from emp e
right outer join emp m
on e.mgr = m.empno;

/***********************************
on 조인조건에서 filtering 하는 경우와 
where 구문에서 filtering 하는 경우
outer join시에 차이가 발생
***********************************/

--inner join
select * 
from emp e 
inner join dept d
on e.deptno = d.deptno and e.sal >1000;

select * 
from emp e 
inner join dept d
on e.deptno = d.deptno
where e.sal > 1000;

--outer join
select * 
from emp e 
left outer join dept d
on e.deptno = d.deptno and e.sal >1000;

select * 
from emp e 
left outer join dept d
on e.deptno = d.deptno
where e.sal > 1000;






