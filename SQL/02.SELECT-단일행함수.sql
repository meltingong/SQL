--단일행함수
--문자함수
select upper('kim'), lower('KIM'), initcap('tom') from dual;
select empno,ename,upper(ename),lower(ename),initcap(ename) from emp;
select empno,concat(empno,'님의 직급은') from emp;
select empno,concat(concat(empno,'님의 직급은 '),job) from emp;
select empno,concat(concat(concat(empno,'님의 직급은 '),job),' 입니다') from emp;
select empno,ename||'님의 직급은'||job||'입니다' from emp;
--substr(index,size)
--index 1,2,3,4,5

select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',6) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',6,1) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',6,2) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',6,3) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',6,4) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',-6) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',-6,1) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',-6,2) from dual;
select 'ABCDEFGHIJK', substr('ABCDEFGHIJK',-6,3) from dual;

select empno,ename,job,substr(job,6),substr(job,6,3) from emp;
select emp_id, substr(emp_id,1,4) "입사연도" from temp;

--length
select empno,ename,length(ename),job,length(job) from emp;
select empno,ename,length(ename) from emp where length(ename) >= 5 order by 3;

--instr
select 'ABADAFG',
        instr('ABADAFG','A'),
        instr('ABADAFG','A',1,1),
        instr('ABADAFG','A',1,2),
        instr('ABADAFG','A',1,3),
        instr('ABADAFG','A',1,4),
        instr('ABADAFG','A',2,1),
        instr('ABADAFG','A',2,2),
        instr('ABADAFG','A',2,3)
from dual;

select 'gurad@naver.com',
        instr('gurad@naver.com','@'),
        substr('gurad@naver.com',1,instr('gurad@naver.com','@')-1)
        from dual;

--lpad,rpad
select empno,ename,
        lpad(ename,8,'-'),
        rpad(ename,8,'-'),
        sal,
        lpad(sal,6,'*'),
        rpad(sal,6,'*'),
        lpad(sal,5,' '),
        lpad(lpad(sal,5,' '),6,'$'),
        lpad(sal,length(sal)+1,'$')
from emp;

--trim

select 'ssupersmans', trim(leading 's' from 'ssupersmans') from dual;
select 'ssupersmans', trim(trailing 's' from 'ssupersmans') from dual;
select 'ssupersmans', trim(both 's' from 'ssupersmans') from dual;
select '  guard  ',
        trim(leading ' ' from '  guard  '),
        trim(trailing ' ' from '  guard  '),
        trim(both ' ' from '  guard  ')
from dual;

select empno,ename,job,
        trim(leading 'S' from job),
        trim(trailing 'N' from job),
        trim(both 'M' from job)
from emp;

--replace
select empno,ename,job,replace(job,'MAN','PERSON') from emp;

/*
자동정렬
ctrl + f7

alt + '
*/

--round(반올림)
select 45.6789,
        round(45.6789),
        round(45.6789,0),
        round(45.6789,1),
        round(45.6789,2),
        round(45.6789,3),
        round(45.6789,-1)
from dual;

--trunc(버림)
select 45.6789,
        trunc(45.6789,0),
        trunc(45.6789,1),
        trunc(45.6789,2),
        trunc(45.6789,3),
        trunc(45.6789,-1)
from dual;

--ceil,floor

select 15.3,ceil(15.3), floor (15.3) from dual;
select 15.3,ceil(-15.3), floor (-15.3) from dual;

--조편성

select 1,2,3,4,5,6,7,8,9,10 from dual;
select  ceil(1/3),ceil(2/3),ceil(3/3),
        ceil(4/3),ceil(5/3),ceil(6/3),
        ceil(7/3),ceil(8/3),ceil(9/3),
        ceil(10/3) 
from dual;

--날짜함수

select sysdate from dual;
select systimestamp from dual;

--날짜+숫자 --> 날짜
--날짜-날짜 --> 숫자 (일수)

select sysdate + 7 "7일 후" from dual;
select sysdate - 7 "7일 전" from dual;

select sysdate - to_date('2000/01/02') "살아온 날" from dual;

select studno,name,birthday,
        trunc(sysdate - birthday) "살아온 날", 
        trunc((sysdate-birthday)/7) "살아온 주수" from student;


select studno,name,birthday,
        sysdate+3 "3일 후 날짜",
        trunc(months_between(sysdate,birthday)) "생후개월",
        add_months(birthday,6) "태어난후 6개월 날짜",
        next_day(birthday,'화') "태어난 후 화요일 날짜"
from student;

select studno,name,birthday,
    trunc(months_between(sysdate,to_date('1995/12/10'))) "살아온 달",
    add_months(sysdate,6) "6개월 후",
    last_day(sysdate) "이번달의 마지막날" ,
    last_day(birthday) "생일달의 마지막날" ,
    next_day(sysdate,'화') "첫번째 화요일" 
from student;


--extract function(날짜로부터 ---> 년,월,일,시,분,초)
select sysdate,
    extract(year from sysdate) "년(숫자)",
    extract(month from sysdate) "월(숫자)",
    extract(day from sysdate) "일(숫자)"
from dual;

select empno,ename,hiredate,
        extract(year from hiredate),
        extract(month from hiredate),
        extract(day from hiredate)
    
from emp;

--systimestamp 
select  systimestamp ,
        extract(year from systimestamp ) 년,
        extract(month from systimestamp ) 월,
        extract(day from systimestamp ) 일,
        extract(hour from systimestamp ) "시",
        extract(minute from systimestamp ) "분",
        extract(second from systimestamp ) "초"
from dual;

--localtimestamp
select systimestamp,
       extract(year from localtimestamp) "년",
       extract(month from localtimestamp) "월",
       extract(day from localtimestamp) "일",
       extract(hour from localtimestamp) "시",
       extract(minute from localtimestamp) "분",
       extract(second from localtimestamp) "초"
from dual;

--변환함수
--묵시적(자동)
select * from emp where hiredate = '1981/11/17'; 
--select * from emp where hiredate = to_date('1981/11/17', 'YYYY/MM/DD');

select * from emp where empno = '7839';
select * from emp where empno >= '7839';
--select * from emp where empno = TO_NUMBER('7839');

--to_char() 날짜 --> 문자

select sysdate,
        to_char(sysdate,'YYYY-MM-DD'),
        to_char(sysdate,'YYYY/MM/DD'),
        to_char(sysdate,'YYYYMMDD'),
        to_char(sysdate,'YYYY MM DD'),
        to_char(sysdate,'YYYY/MM/DD HH:MI:SS'),
        to_char(sysdate,'YEAR-MONTH-DAY'),
        to_char(sysdate,'YEAR-MONTH-DY')
from dual;

select sysdate,
        to_char(sysdate,'YYYY'),
        to_char(sysdate,'MM'),
        to_char(sysdate,'DD'),
        to_char(sysdate,'HH'),
        to_char(sysdate,'MI'),
        to_char(sysdate,'SS'),
        to_char(sysdate,'YEAR'),
        to_char(sysdate,'DAY'),
        to_char(sysdate,'DY')
from dual;

select * from temp where to_char(birth_date,'MM') = '12';
select * from temp where to_char(birth_date,'DAY') = '금요일';
select * from temp where to_char(birth_date,'YY') >= '75';
select * from temp where extract(year from birth_date) = 1975;

--to_char() 숫자 --> 문자
select 1234567.8888, 
        to_char(1234567.8888,'9,999,999.99'),
        to_char(1234567.8888,'099,999,999.999999'),
        to_char(1234567.8888,'L9,999,999.99'),        
        to_char(1234567.8888,'$9,999,999.99')        
from dual;

select temp.*,to_char(salary,'L999,999,999,999.9') "연봉" from temp;

--to_number() 문자 --> 숫자
select * from emp where sal > to_number('1000');
select '1234' + 1, '0.3' + '0.32423' from dual;

--to_date() 문자 --> 날짜

select * from student 
    where birthday >= to_date('1977/01/01','YYYY/MM/DD') 
        and birthday <= to_date('1977-12-31','YYYY-MM-DD');


insert into emp values(9999,'김경호','MANAGER',7788,to_date('2022/03/04'),9000,900,30);
select * from emp;

--일반함수
--nvl,nvl2

select empno,ename,sal,comm, sal + comm 총급여 from emp;
select empno,ename,sal,comm, nvl(comm,0),sal+nvl(comm,0) 총급여 from emp;
select empno,ename,sal,comm, nvl2(comm,comm,0),nvl2(comm,sal+comm,sal) from emp;

--decode

select decode('LEE','KIM',1000,'LEE',2000,'PARK',3000,500) from dual;
select decode('KIM','KIM',1000,'LEE',2000,'PARK',3000,500) from dual;
select decode('PARK','KIM',1000,'LEE',2000,'PARK',3000,500) from dual;
select decode('KIM','KIM',1000,'LEE',2000,'PARK',3000,500) from dual;
select decode('SDF','KIM',1000,'LEE',2000,'PARK',3000,500) from dual;


select emp.*, 
        sal + decode(job, 'SALESMAN',3000,'CLERK',1000,'MANAGER',2000,'PRESIDENT',5000,0) "총급여1",
        decode(job, 'SALESMAN',sal+3000,'CLERK',sal+1000,'MANAGER',sal+2000,'PRESIDENT',sal+5000,sal+0) "총급여2",
        decode(job, 'SALESMAN',3000,'CLERK',1000,'MANAGER',2000,'PRESIDENT',5000,0) "직급별보너스"

from emp;


--case문
select empno,ename,sal,job,
       (
        case
            when job = 'ANALYST' then sal*1.1
            when job = 'CLERK' then sal*1.2
            when job = 'MANAGER' then sal*1.3
            when job = 'PRESIDENT' then sal*1.4
            when job = 'SALESMAN' then sal*1.5
            else sal
        end 
       ) 
       "직급별계산 급여"
from emp;











