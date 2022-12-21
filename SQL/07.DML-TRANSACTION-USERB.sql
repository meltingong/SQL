--userb
select * from scott.emp;
select * from scott.dept;
select sal from scott.emp where ename = 'KING';

select * from scott.dept;

select * from scott.emp;
--Transaction시 emp 모든 행에 lock이 걸려있으므로 wait

update scott.emp set sal = sal*1.1 where job = 'SALESMAN';
select * from scott.emp;

commit;



















