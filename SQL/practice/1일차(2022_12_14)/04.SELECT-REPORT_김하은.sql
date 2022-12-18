select emp_name,salary/18,salary*2/18 from temp;
select emp_name,100000+salary,200000+salary from temp;
select emp_id "사번",emp_name "성명" from temp;
select emp_name || '(' || lev || ')' from temp;
--5) TEMP 테이블에서 HOBBY(취미) 가 NULL 이 아닌 사람의 성명을 읽어오는 SQL을 작성하시요.
select emp_name from temp where hobby is not null;
select emp_name || '''' || lev || '''' as emp_name from temp;
select '''' || emp_name || birth_date || '''' as emp_name from temp;
-- 7)TEMP 테이블을 이용해서 취미가 있는 사람 중 직급이 과장인 사람의 사번, 성명, 취미를 읽어오는 SQL을 작성 하시오.
select emp_id,emp_name,hobby from temp where hobby is not null and lev = '과장';