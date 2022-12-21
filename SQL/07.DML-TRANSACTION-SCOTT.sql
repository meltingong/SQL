--scott
--DML TRANSACTION
/*
        <<transaction>>
            트랜젝션의 정의
                - 하나의 논리적인 기능 (업무)를 실행하기 위한 작업단위
                - 데이터베이스 상태를 변화시키는 1개 또는 여러개 DML(update,delete,insert)문으로 구성
*/

delete emp where empno >= 7000;
update dept set dname = '영업팀';
rollback;

delete emp where empno = 7839;
update dept set dname = '영업' where deptno = 30; 
commit;







