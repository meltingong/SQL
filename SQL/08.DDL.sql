--DDL(Data Definition Language)

create table dept(
    deptno number(2),
    dname varchar2(50),
    loc varchar2(50)
);
--ORA-00955: name is already used by an existing object

create table dept2(
    deptno number(2),
    dname varchar2(50),
    loc varchar2(50)
);
--권한이 없으면 테이블 만들 수 없음

create table dept3(
    deptno number(2),
    dname varchar2(50),
    loc varchar2(50)
);

insert into dept2 values (10,'개발팀','서울');
insert into dept3 values (10,'기획팀','부산');

--default
create table def_table(
    num number(2) default null,
    writer varchar(50) default null,
    write_day date -- default null 생략되어있음
);

select * from def_table;
insert into def_table(num,writer,write_day) values (1,'강수지',sysdate);
insert into def_table(num) values (2);
insert into def_table(writer) values ('김수지');

create table def_table2(
    num number(2) ,
    writer varchar(50),
    write_day date 
);

create table def_table3(
    num number(2) default 0,
    writer varchar(50) default 'guest',
    write_day date default sysdate
);

select * from def_table3;
insert into def_table3(num,writer,write_day) values(1,'김수한',to_date('2000/01/05','YYYY/MM/DD'));

insert into def_table3(num) values(2);
insert into def_table3(num,writer) values(3,'김수우');
insert into def_table3(num,writer) values(4,'김수미');
insert into def_table3(num,writer) values(5,'김수아');
insert into def_table3(num,writer) values(6,'김수비');
insert into def_table3(num,writer,write_day) values(null,null,null);
insert into def_table3(num,writer,write_day) values(7,'김경우',sysdate-1);
--table drop
drop table def_board;
create table def_board(
    no number(5) primary key,
    title varchar2(100),
    content varchar2(1024),
    write_day date default sysdate,
    read_count number(5) default 0,
    is_secret varchar2(1) default 'F',
    write_user varchar2(30) default 'guest'
);

insert into def_board(no,title,content) values(1,'오늘은 목요일','왜 금요일이 아닌가');
insert into def_board(no,title,content) values(2,'오늘은 금요일','거짓말이다');
insert into def_board(no,title,content) values(3,'오늘은 토요일','이것 또한 거짓말이다');
insert into def_board(no,title,content,write_day,read_count,is_secret,write_user) 
    values(4,'오늘은 일요일','거짓말 3연타',sysdate,1,'T','guard');

--column data type
drop table data_type;
create table data_type(
    no number(4,0) primary key,
    name varchar(20),
    gender char(1) default 'M',
    height number(5,2),
    weight number(4,1)
);

insert into data_type values(1234,'김경호','M',185.32,75.3);

--지정된 소수점이하 자리수는 반올림 후 삽입
insert into data_type values(1234.8989,'김경호','M',185.32898989,75.38989);

--지정된 소수점이상 자리수는 삽입안됨
--ORA-01438: value larger than specified precision allowed for this column
insert into data_type values(12345,'김경호','M',1854,755);
--[varchar2]ORA-12899: value too large for column "SCOTT"."DATA_TYPE"."NAME" (actual: 21, maximum: 20)
insert into data_type values(2344,'배고파아아아아','F',178.32,75.6);
--[char]ORA-12899: value too large for column "SCOTT"."DATA_TYPE"."GENDER" (actual: 6, maximum: 1)
insert into data_type values(5678,'배고파','FEMALE',178.32,75.6);

--date, timestamp
drop table data_time;
create table date_time(
    day1 date,
    day2 timestamp(6),
    day3 timestamp(9)
);
desc date_time;
select  to_char(day1,'YYYY/MM/DD HH24:MI:SS'),
        to_char(day2,'YYY/MM/DD HH24:MI:SS.FF6'),
        to_char(day3,'YYY/MM/DD HH24:MI:SS.FF9')
from date_time;

insert into date_time values(sysdate,systimestamp,systimestamp);
insert into date_time values(   to_date('2002/05/12 05:35:45','YYYY/MM/DD HH:MI:SS'),
                                to_timestamp('2020/05/05 02:34:59.123456','YYYY/MM/DD HH24:MI:SS.FF6'),
                                to_timestamp('2020/05/05 02:34:59.123456789','YYYY/MM/DD HH24:MI:SS.FF9'));

commit;

--서브쿼리를 이용한 테이블 생성(CTAS : Create Table as Select)

create table depta
as
select deptno,dname,loc from dept;

select * from depta;


create table deptb
as
select deptno,dname from dept;

select * from deptb;

create table deptc(no,name)
as
select deptno,dname from dept;

select * from deptc;
--table만 생성

create table deptd
as
select * from dept where 1=2;

select * from deptd;

--다른 테이블로부터 데이터 입력(ITAS : Insert Table as Select)
drop table empa;

create table empa
as
select * from emp where 1=2;

insert into empa
select * from emp;










