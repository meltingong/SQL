--usera
--scott이 가지고 있는 emp,dept select
select * from scott.emp;
select * from scott.dept;

/*
usera
<<transection>>
*/
select sal from scott.emp where ename = 'KING';

--Transaction 시작(DML --> insert,delete,update)
update scott.emp set sal = 6000 
where ename = 'KING';
select sal from scott.emp where ename = 'KING';
--Transaction 종료
commit;
select sal from scott.emp where ename = 'KING';

select * from scott.dept;
--Transaction 시작(DML --> insert,delete,update)
insert into scott.dept values(60,'기획팀','제주');
insert into scott.dept values(70,'영업팀','청주');
--Transaction 종료
commit;

--Transaction 시작(DML --> insert,delete,update)
delete from scott.emp;
rollback;
select * from scott.emp;



