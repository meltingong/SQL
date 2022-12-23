--view

--단순view (base table 1개)

create or replace view dept_view
as
select deptno, dname, loc from dept
where deptno = 10;


select * from dept_view;


--inline view

select * from (select deptno,dname,loc 
                from dept where deptno = 10                
                );

create or replace view dept_view
as
select deptno "부서번호", dname "부서이름"
from dept;

--ORA-00904: "DNAME": invalid identifier
select deptno,dname from dept_view; 

select 부서번호,부서이름 from dept_view;

--ORA-00904: "LOC": invalid identifier
select 부서번호,부서이름,loc from dept_view;

desc dept_view;

create or replace view emp_account_view
as
select empno,ename,sal,hiredate from emp where deptno = 10;

desc emp_account_view;
select * from emp_account_view;

--계정의 view객체정보(sys.user_views)
select * from user_views;
desc user_views;

--복합view(table 여러개)

create or replace view emp_dept_view
as
select e.empno,e.ename,d.deptno,e.job,d.dname,d.loc
from emp e join dept d
on e.deptno = d.deptno;

desc emp_dept_view;
select * from emp_dept_view;

-- view 삭제

drop view emp_dept_view;

-- sequence

drop sequence test_seq1;
create sequence test_seq1;

drop sequence test_seq2;
create sequence test_seq2 
    start with 10
    maxvalue 900000
    increment by 10
    nocycle
    NOCACHE
;

--sequence 값 생성

select test_seq1.nextval "발생시퀀스의 값" from dual;
select test_seq1.currval "현재시퀀스 객체의 값" from dual;


select
    test_seq1.nextval "발생시퀀스값1",
    test_seq1.nextval "발생시퀀스값2" 
from dual; -- ? 이렇게는 안씀

select  test_seq1.nextval "발생시퀀스값",
        test_seq1.currval "현재시퀀스값" 
from dual;

select  test_seq1.currval "현재시퀀스값",
        test_seq1.nextval "발생시퀀스값" 
from dual;

/*
시퀀스 생성 이후에 nextval을 한번도 호출하지 않은 경우 currval을 사용하지 못함
*/

--ORA-08002: sequence TEST_SEQ2.CURRVAL is not yet defined in this session
select test_seq2.currval from dual;

select test_seq2.nextval from dual;
select test_seq2.currval from dual;

drop table freeboard;
create table freeboard(
    b_no number(10) primary key,
    b_title varchar2(512),
    b_content varchar2(2048),
    b_wday date default sysdate,
    b_read_count number(10) default 0
);

drop sequence freeboard_b_no_seq;
create sequence freeboard_b_no_seq;

insert into freeboard(b_no,b_title,b_content)
            values(freeboard_b_no_seq.nextval, 
                    '제목'||freeboard_b_no_seq.currval,
                    '내용'||freeboard_b_no_seq.currval);
            
select * from freeboard;
            
drop table jumun;

create table jumun(
    j_code varchar2(20) primary key,
    j_title varchar2(100),
    j_price number(10),
    j_date date default sysdate
);
                      
drop sequence jumun_code_seq;
create sequence jumun_code_seq;

insert into jumun(j_code,j_title,j_price) 
            values(to_char(sysdate,'YYYY-MM-DD-')||lpad(to_char(jumun_code_seq.nextval),4,'0'),'아이패드 외 3종...',890000);

select * from jumun;

commit;

--index
drop index emp_name_index;
create index emp_name_index on emp(ename);




















