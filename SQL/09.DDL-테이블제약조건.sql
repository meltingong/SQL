--테이블제약조건(constraint)
/*
1. not null
2. unique
3. primary key(unique + not null)
4. foreign key(다른테이블의 primary key컬럼에 데이터만 저장가능)
5. check(컬럼의 값을 제한)
*/
/***********************************
1. not null(컬럼수준에서만 정의 가능)
************************************/
drop table sawon1;
create table sawon1(
    no number(4),
    name varchar2(50) not null,
    hiredate date constraint sawon1_hiredate_nn not null
);

select * from user_constraints where table_name = 'SAWON1';
desc sawon1;
insert into sawon1 values(1,'홍길동',sysdate);
insert into sawon1 values(2,null,sysdate);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON1"."NAME")
insert into sawon1 values(3,'홍길남',null);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON1"."HIREDATE")
insert into sawon1(no,name) values(4,'홍길북');
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON1"."HIREDATE")

/*****************************************
2. unique(중복값 허용 안함, null은 허용)
*****************************************/
--컬럼수준(컬럼을 정의 할 때 선언)
drop table sawon2;
create table sawon2 (
    no number(4) primary key,
    id varchar2(10) unique not null,
    name varchar2(50),
    email varchar2(50) constraint sawon2_email_uq unique
);

insert into sawon2 values(1,'guard','이순신','aaa@gmain.com');
--1 행 이(가) 삽입되었습니다.

insert into sawon2 values(2,'guard','삼순신','bbb@gmain.com');
--ORA-00001: unique constraint (SCOTT.SYS_C007147) violated

insert into sawon2 values(3,'melon','사순신','aaa@gmain.com');
--ORA-00001: unique constraint (SCOTT.SAWON2_EMAIL_UQ) violated

insert into sawon2 values(4,null,'오순신','ccc@gmain.com');
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON2"."ID")

insert into sawon2 values(5,'apple','육순신',null);
--1 행 이(가) 삽입되었습니다.

insert into sawon2 values(6,'berry','칠순신',null);
--1 행 이(가) 삽입되었습니다.



--테이블수준(컬럼을 정의 한 후에 테이블레벨에 선언)
drop table sawon3;
create table sawon3 (
    no number(4) primary key,
    id varchar2(10) not null,
    name varchar2(50),
    email varchar2(50),
    unique(id),
    constraint sawon3_email_uq unique(email)
);

/**************************************
3. primary key (unique + not null)
        - 테이블당 한개의 pk만 설정
***************************************/
--컬럼레벨
drop table sawon4;
create table sawon4(
    no number(4) primary key,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null
);

drop table sawon5;
create table sawon5(
    no number(4) constraint sawon5_no_pk primary key,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null
);
insert into sawon5 values(1,'일소라',200000.9);
insert into sawon5 values(2,'이소라',450000.9);
insert into sawon5 values(3,'삼소라',340000.9);

insert into sawon5 values(3,'세소라',330000.9);
--ORA-00001: unique constraint (SCOTT.SAWON5_NO_PK) violated

insert into sawon5 values(null,'널소라',330000.9);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON5"."NO")

--테이블레벨
drop table sawon6;
create table sawon6(
    no number(4) ,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null,
    primary key(no)
);

drop table sawon7;
create table sawon7(
    no number(4) ,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null,
    constraint sawon7_no_pk primary key(no)
);

/**************테이블 생성 이후에 primary key 추가하거나 제거******************/

drop table sawon8;
create table sawon8(
    no number(4) ,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null
);
--primary key 추가
alter table sawon8 add constraint sawon8_no_pk primary key(no);
--primary key 제거
alter table sawon8 drop constraint sawon8_no_pk;

/*************************************
primary key 복합키인 경우
    - 컬럼 여러개가 primary key인 경우
**************************************/
drop table student_locker;
create table student_locker(
    ban number(2),
    locker_no number(2),
    name varchar2(20),
    constraint student_locker_pk primary key(ban,locker_no)
);

insert into student_locker values(1,1,'KIM');
insert into student_locker values(1,2,'LIM');
insert into student_locker values(1,3,'MIM');

insert into student_locker values(2,1,'QIM');
insert into student_locker values(2,2,'WIM');
insert into student_locker values(2,3,'EIM');

insert into student_locker values(3,1,'RIM');
insert into student_locker values(3,2,'TIM');
insert into student_locker values(3,3,'YIM');

-- 중복데이터 안들어감
insert into student_locker values(3,3,'YIM');
insert into student_locker values(3,null,'YIM');
insert into student_locker values(null,1,'YIM');
insert into student_locker values(null,null,'YIM');

select * from student_locker where ban = 1 and locker_no =1;
select * from student_locker where ban = 1 and locker_no =2;

select * from student_locker where ban = 1;
select * from student_locker where locker_no = 1;

/*******************************************************************************
4. foreign key(외래키)
    parent table(dept) : 부모(parent)테이블 , 참조되는 테이블
    child  table(emp)  : 자식(child) 테이블, 참조하는 테이블(foreign key column)
    
    - null 허용
    - 중복허용
********************************************************************************/
/****case1 컬럼레벨****/
--parent table(pk)
drop table dept2;
create table dept2(
    deptno number(4) primary key,
    dname varchar(30) not null,
    loc varchar(100)
);

insert into dept2 values(10,'인사','서울');
insert into dept2 values(20,'생산','울산');
insert into dept2 values(30,'영업','대구');
insert into dept2 values(40,'홍보','청주');


--child table(fk)
drop table emp2;
create table emp2(
    empno number(4) primary key,
    ename varchar(50),
    sal number(10),
    deptno number(4) constraint emp2_deptno_fk references dept2(deptno)
);

insert into emp2 values(1111,'KIM',3000,10);
insert into emp2 values(2222,'LIM',4500,10);
insert into emp2 values(3333,'MIM',6700,10);

insert into emp2 values(4444,'NIM',2300,20);
insert into emp2 values(5555,'OIM',1200,20);

insert into emp2 values(6666,'GIM',8800,30);
insert into emp2 values(7777,'ZIM',9900,30);

insert into emp2 values(8888,'RIM',1000,null);
insert into emp2 values(9999,'SIM',2000,null);

--ORA-02291: integrity constraint (SCOTT.EMP2_DEPTNO_FK) violated - parent key not found
insert into emp2 values(1010,'XXX',9000,90);

--ORA-02291: integrity constraint (SCOTT.EMP2_DEPTNO_FK) violated - parent key not found
update emp2 set deptno = 90 where empno = 1111;

--1 행 이(가) 업데이트되었습니다.
update emp2 set deptno = 40 where empno = 1111;

select * from emp2;
select *
    from emp2 e
    join dept2 d
    on e.deptno = d.deptno;

/*******case2 테이블 레벨 *********/
--parent table
drop table dept3;
create table dept3(
    deptno number(4) primary key,
    dname varchar(30) not null,
    loc varchar(100)
);

insert into dept3 values(10,'인사','서울');
insert into dept3 values(20,'생산','울산');
insert into dept3 values(30,'영업','대구');
insert into dept3 values(40,'홍보','청주');

select * from dept3;
--참조되지 않는 부서 40은 삭제 가능
delete dept3 where deptno = 40;

--참조되고 있는 부서 30은 삭제 불가능
--ORA-02292: integrity constraint (SCOTT.EMP3_DEPTNO_FK) violated - child record found
delete dept3 where deptno = 30;

--참조되고 있는 부서 30은 수정 불가능
ORA-02292: integrity constraint (SCOTT.EMP3_DEPTNO_FK) violated - child record found
update dept3 set deptno = 90 where deptno = 30;


--child table(fk)
drop table emp3;
create table emp3(
    empno number(4) primary key,
    ename varchar(50),
    sal number(10),
    deptno number(4),
    constraint emp3_deptno_fk foreign key(deptno) references dept3(deptno)
);

insert into emp3 values(1111,'KIM',3000,10);
insert into emp3 values(2222,'LIM',4500,10);
insert into emp3 values(3333,'MIM',6700,10);

insert into emp3 values(4444,'NIM',2300,20);
insert into emp3 values(5555,'OIM',1200,20);

insert into emp3 values(6666,'GIM',8800,30);
insert into emp3 values(7777,'ZIM',9900,30);

insert into emp3 values(8888,'RIM',1000,null);
insert into emp3 values(9999,'SIM',2000,null);
/**********************************************************************************************************************
FOREIGN KEY OPTION
  1. NO ACTION	       : 부모 테이블(dept)의 행을 참조하는 자식 테이블(emp)의 행이존재하면 부보테이블행을 삭제불가능하다.
  2. ON DELETE CASCADE : 부모 테이블(dept)의 행이 삭제되면 자식 테이블(emp)의 관련 행도 삭제된다. 
  3. ON DELETE SET NULL: 부모 테이블(dept)의 행이 삭제되면 자식 테이블(emp)의 관련 행의 속성(deptno)값을 NULL로 변경한다.
**********************************************************************************************************************/
--1. foreign key option(on delete cascade)
--parent table
drop table dept4;
create table dept4(
    deptno number(4) primary key,
    dname varchar(30) not null,
    loc varchar(100)
);

insert into dept4 values(10,'인사','서울');
insert into dept4 values(20,'생산','울산');
insert into dept4 values(30,'영업','대구');
insert into dept4 values(40,'홍보','청주');


--child table(fk)
drop table emp4;
create table emp4(
    empno number(4) primary key,
    ename varchar(50),
    sal number(10),
    deptno number(4),
    constraint emp4_deptno_fk foreign key(deptno) references dept4(deptno) on delete cascade 
);

insert into emp4 values(1111,'KIM',3000,10);
insert into emp4 values(2222,'LIM',4500,10);
insert into emp4 values(3333,'MIM',6700,10);
insert into emp4 values(4444,'NIM',2300,20);
insert into emp4 values(5555,'OIM',1200,20);
insert into emp4 values(6666,'GIM',8800,30);
insert into emp4 values(7777,'ZIM',9900,30);
insert into emp4 values(8888,'RIM',1000,null);
insert into emp4 values(9999,'SIM',2000,null);
commit;

select * from dept4;
select * from emp4;

-- 부서 10번 삭제 시 소속된 사원도 삭제
delete dept4 where deptno = 10;
delete dept4 where deptno = 20;
delete dept4 where deptno = 30;

rollback; --insert 부터 delete 까지 하나의 transaction 이기때문에 rollback 하게되면 insert전으로 롤백됨 그래서 insert끝난 후에 commit해야함


--2. foreign key option(on delete set null)
--parent table
drop table dept5;
create table dept5(
    deptno number(4) primary key,
    dname varchar(30) not null,
    loc varchar(100)
);

insert into dept5 values(10,'인사','서울');
insert into dept5 values(20,'생산','울산');
insert into dept5 values(30,'영업','대구');
insert into dept5 values(40,'홍보','청주');


--child table(fk)
drop table emp5;
create table emp5(
    empno number(4) primary key,
    ename varchar(50),
    sal number(10),
    deptno number(4),
    constraint emp5_deptno_fk foreign key(deptno) references dept5(deptno) on delete set null 
);

insert into emp5 values(1111,'KIM',3000,10);
insert into emp5 values(2222,'LIM',4500,10);
insert into emp5 values(3333,'MIM',6700,10);
insert into emp5 values(4444,'NIM',2300,20);
insert into emp5 values(5555,'OIM',1200,20);
insert into emp5 values(6666,'GIM',8800,30);
insert into emp5 values(7777,'ZIM',9900,30);
insert into emp5 values(8888,'RIM',1000,null);
insert into emp5 values(9999,'SIM',2000,null);
commit;

select * from dept5;
select * from emp5;

-- 부서 10번 삭제 시 소속된 사원의 deptno를 null로 만듬
delete dept5 where deptno = 10;
delete dept5 where deptno = 20;
delete dept5 where deptno = 30;

rollback;

/**************테이블 생성 이후에 foreign key 추가 제거*********************/
drop table dept6;
create table dept6(
    deptno number(4),
    dname varchar2(50),
    loc  varchar2(50)
);


drop table emp6;
create table emp6(
    empno number(4),
    ename varchar2(50),
    sal number(10),
    deptno number(4)
);


--pk add(설정)
alter table dept6 add constraint dept6_deptno_pk primary key(deptno);
alter table emp6 add constraint emp6_empno_pk primary key(empno);

--fk add(설정)
alter table emp6 add constraint emp6_deptno_fk foreign key(deptno) references dept6(deptno);

--fk drop(삭제)
alter table emp6 drop constraint emp6_deptno_fk;

--pk drop(삭제)
alter table dept6 drop constraint dept6_deptno_pk;
alter table emp6 drop constraint emp6_empno_pk;

/********************************
5. check constraint
*********************************/
drop table emp7;
create table emp7(
    empno number(4) primary key,
    ename varchar2(50) not null,
    sal number(10) constraint emp7_sal_ck check(sal >= 500 and sal <= 5000),
    gender char(1) default 'f',
    constraint emp7_gender_ck check(gender = 'm' or gender = 'f')
);

select * from emp7;
insert into emp7 values(1,'KIM',800,'f');
insert into emp7 values(2,'GIM',3000,'m');

--ORA-02290: check constraint (SCOTT.EMP7_SAL_CK) violated
insert into emp7 values(3,'VIM',6000,'m');

--ORA-02290: check constraint (SCOTT.EMP7_GENDER_CK) violated
insert into emp7 values(4,'ZIM',5000,'a');

/*
drop : 테이블을 삭제하는 명령어(DDL) - 복구할 수 없음(한개의 transaction)
*/
create table emp8(
    empno number(4) primary key,
    ename varchar(50) not null,
    sal number(10),
    gender char(1) default 'f'
);

drop table emp8;
rollback; -- 안됨











