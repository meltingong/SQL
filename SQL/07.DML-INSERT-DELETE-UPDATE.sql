/*
DML (Data Manipulation Language)
*/

desc dept;
select * from dept;
insert into dept(deptno,dname,loc) values(90,'인사과','서울');
insert into dept(loc,deptno,dname) values('제주',91,'개발');
insert into dept values(92,'홍보과','인천');

--null 값 입력
insert into dept(deptno,dname,loc) values(93,null,null);
insert into dept(deptno,dname) values(94,'생산1과');
insert into dept(deptno,dname,loc) values(95,'생산2과',null);
insert into dept(deptno) values(96);

/*
insert 시오류나는경우
*/
--primary key가 중복된 경우
insert into dept(deptno,dname,loc) values(96,'마케팅1과','LA');
--ORA-00001: unique constraint (SCOTT.PK_DEPT) violated

--primary key가 null인경우
insert into dept(deptno,dname,loc) values(null,'마케팅2과','NY');
insert into dept(dname,loc) values('마케팅2과','NY');
--ORA-01400: cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

--데이터가 큰 경우
insert into dept(deptno,dname,loc) values(1000,'총무과','CA');
--ORA-01438: value larger than specified precision allowed for this column
insert into dept(deptno,dname,loc) values(97,'미래비젼팀','공주'); --한글1글자 3byte / 영문은 1byte
--ORA-12899: value too large for column "SCOTT"."DEPT"."DNAME" (actual: 15, maximum: 14)

--타입이 일치하지않는 경우
insert  into dept(deptno,dname,loc) values ('구십팔','기획팀','광주');
--ORA-01722: invalid number
insert  into dept(deptno,dname,loc) values (98,5000,'광주');
--숫자가 문자화되어서 삽입된다.(오류x --> 정상적으로 행이 추가됨)
insert  into dept(deptno,dname,loc) values ('99','개발팀','광주');
--숫자가 문자화되어서 삽입된다.(오류x --> 정상적으로 행이 추가됨)
commit;
desc emp;
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    

*/
select * from emp;
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
            values (9000,'강감찬','MANAGER',7839,to_date('2022/12/12','YYYY/MM/DD'),2000,0,40);
            
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
            values (9001,'홍길동','MANAGER',null,sysdate,2000,null,40);

insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
            values (9002,'이순신',null,null,null,null,null,null);

insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
            values (9003,null,null,null,null,null,null,null);

insert into emp(empno) values (9004);

/*
insert 시 오류나는 경우
*/

insert into emp values(9005,'철수',null,null,null,null,null);
--00947. 00000 -  "not enough values"
insert into emp values(9006,'유리',null,null,null,null,null,33);
--ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
commit;

--UPDATE
select * from dept;
update dept set dname = '인사팀',loc = 'LA' where deptno = 90;
--1 행 이(가) 업데이트 되었습니다.

update dept set dname = '인사팀',loc = 'LA' where deptno = 33;
--0개 행 이(가) 업데이트되었습니다.

update dept set loc = '제주' where dname = '홍보과';

update dept set loc = 'SEOUL' where loc is null;
--4개 행 이(가) 업데이트되었습니다.

update dept set dname = '영업' where dname is null; 
update dept set dname = '영업팀' where dname = '영업'; 
--2개 행 이(가) 업데이트되었습니다.

--xx과 --> xx팀
update dept set dname = replace(dname,'과','팀') where dname like '%과';
--loc 서울 --> SEOUL
update dept set loc = 'SEOUL' where loc = '서울';
--dname 광주98팀
update dept set dname = loc||deptno||'팀' where deptno = 98;

update dept set deptno = 11 where deptno = 10;
--ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
commit;
select * from emp;

update emp set  ename = '최영' ,job = 'ANALYST',
                mgr = null, hiredate = to_date('2000/12/02','YYYY/MM/DD'),
                sal = 90000, comm = 1000,deptno =91
where empno = 9003;

update emp set hiredate = hiredate+7, sal = sal*1.1 where empno = 9000;
update emp set sal = 2000 where sal is null;
update emp set hiredate = sysdate where hiredate is null;
update emp set comm = 0 where hiredate is null;
update emp set mgr = 7839 where mgr is null and empno != 7839;
update emp set deptno = 40 where deptno is null;
update emp set job = 'SALESMAN' where job is null;

update emp set ename = user where empno = (select max(empno) from emp);
commit;

--delete
delete from dept where deptno = 90;
delete from dept where deptno = 91;
--ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found

delete from emp where deptno = 91;
delete from dept where deptno = 91;

delete dept where dname like '영업%';
delete dept where deptno > 40;
delete emp where empno > 9000;

commit;

delete emp;
delete dept;

rollback;



