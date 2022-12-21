--sys
/*
<<sys계정>>
*/
--계정생성
--XE 21c 버젼에서 계정이름 기존방법대로생성
create user usera identified by usera;
create user userb identified by userb;

--권한부여
grant connect,resource to usera;
grant connect,resource to userb;

/*
usera,userb에 scott계정이 소유하고 있는 emp,dept 
테이블 접근권한 부여(select,update,delete,insert)
*/

grant all on scott.emp to usera;
grant all on scott.dept to usera;

grant all on scott.emp to userb;
grant all on scott.dept to userb;

