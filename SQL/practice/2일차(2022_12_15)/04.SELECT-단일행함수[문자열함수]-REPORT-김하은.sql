/*
1. Student 테이블에서 jumin 컬럼을 이용해서 1전공(deptno1 컬럼)이
   101번인 학생들의이름과 태어난월일,생일을 출력하시요
<< 결과1 >>
-----------------------------------
NAME 	 	Birthday 
----------------------------------
James Seo	   1023	
Billy Crystal	   0123	
Richard Dreyfus	   1129	
Danny Devito	   0819	

<< 결과2 >>
-----------------------------------------------
NAME 	 	Birthday   
-----------------------------------------------
James Seo	10월 23일
Billy Crystal	01월 23일
Richard Dreyfus	11월 29일
Danny Devito	08월 19일
*/

--결과1
select name,substr(birthday,6,2)||substr(birthday,9,2) "BIRTHDAY"  from student where deptno1 = '101';
select name,concat(substr(birthday,6,2),substr(birthday,9,2)) "BIRTHDAY" from student where deptno1 = '101';

--결과2
select name,substr(birthday,6,2)|| '월' || substr(birthday,9,2) || '일' "BIRTHDAY"  from student where deptno1 = '101';
select name, concat(concat(substr(birthday,6,2),'월'),
             concat(substr(birthday,9,2),'일')) "BIRTHDAY" 
from student where deptno1 = '101';

/*
2. Student 테이블을 참조해서  1전공이(deptno1 컬럼) 
   201번인 학생의이름과 전화번호와 지역번호를 출력하세요
   단 지역번호는 숫자만나오게하세요
--------------------------------------------------------
 NAME		  TEL	        AREA CODE
---------------------------------------------------------
Demi Moore	 02)6255-9875	02
Macaulay Culkin	 02)312-9838	02
Wesley Snipes	 053)736-4981	053
Steve Martin	 02)6175-3945	02
Sean Connery	 02)381-5440	02
Christian Slater 031)345-5677	031
*/

select name,tel,substr(tel,1,instr(tel,')')-1) "AREA" from student where deptno1 = '201';

/*
3. Student 테이블에서 학생들의 이름과
   주민등록번호를 아래와같이 출력하세요.
<<출력1>>
-----------------------------------------------------------------
 NAME		  JUMIN	            	REPLACE
-----------------------------------------------------------------
James Seo	 7510231901813	751023*******
Rene Russo	 7502241128467	750224*******
Sandra Bullock	 7506152123648	750615*******
Demi Moore	 7512251063421	751225*******
Danny Glover	 7503031639826	750303*******
Billy Crystal	 7601232186327	760123*******
Nicholas Cage	 7604122298371	760412*******
Micheal Keaton	 7609112118379	760911*******
Bill Murray	 7601202378641	760120*******
Macaulay Culkin	 7610122196482	761012*******
Richard Dreyfus	 7711291186223	771129*******
Tim Robbins	 7704021358674	770402*******
Wesley Snipes	 7709131276431	770913*******
Steve Martin	 7702261196365	770226*******
Daniel Day-Lewis 7712141254963	771214*******
Danny Devito	 7808192157498	780819*******
Sean Connery	 7801051776346	780105*******
Christian Slater 7808091786954	780809*******
Charlie Sheen	 7803241981987	780324*******
Anthony Hopkins	 7802232116784	780223*******

<<출력2>>
-----------------------------------------------------------------
 NAME		  JUMIN	           REPLACE
-----------------------------------------------------------------
James Seo	 7510231901813	751023-*******
Rene Russo	 7502241128467	750224-*******
Sandra Bullock	 7506152123648	750615-*******
Demi Moore	 7512251063421	751225-*******
Danny Glover	 7503031639826	750303-*******
Billy Crystal	 7601232186327	760123-*******
Nicholas Cage	 7604122298371	760412-*******
Micheal Keaton	 7609112118379	760911-*******
Bill Murray	 7601202378641	760120-*******
Macaulay Culkin	 7610122196482	761012-*******
Richard Dreyfus	 7711291186223	771129-*******
Tim Robbins	 7704021358674	770402-*******
Wesley Snipes	 7709131276431	770913-*******
Steve Martin	 7702261196365	770226-*******
Daniel Day-Lewis 7712141254963	771214-*******
Danny Devito	 7808192157498	780819-*******
Sean Connery	 7801051776346	780105-*******
Christian Slater 7808091786954	780809-*******
Charlie Sheen	 7803241981987	780324-*******
Anthony Hopkins	 7802232116784	780223-*******
*/

--출력1

select name,jumin,rpad(substr(jumin,1,6),13,'*') "replace" from student;

--출력2

select name,jumin,rpad(rpad(substr(jumin,1,6),7,'-'),14,'*') "replace" from student;


/*
4.Student 테이블에서  학생들의 이름과
  전화번호와 전화번호에서 지역번호와 국번을 제외한 나머지
  번호를 * 로 표시해서 출력하세요

-----------------------------------------------------------------
 NAME		  TEL	            	REPLACE
-----------------------------------------------------------------
James Seo	 055)381-2158	055)381-****
Rene Russo	 051)426-1700	051)426-****
Sandra Bullock	 053)266-8947	053)266-****
Demi Moore	 02)6255-9875	02)6255-****
Danny Glover	 031)740-6388	031)740-****
Billy Crystal	 055)333-6328	055)333-****
Nicholas Cage	 051)418-9627	051)418-****
Micheal Keaton	 051)724-9618	051)724-****
Bill Murray	 055)296-3784	055)296-****
Macaulay Culkin	 02)312-9838	02)312-****
Richard Dreyfus	 02)6788-4861	02)6788-****
Tim Robbins	 055)488-2998	055)488-****
Wesley Snipes	 053)736-4981	053)736-****
Steve Martin	 02)6175-3945	02)6175-****
Daniel Day-Lewis 051)785-6984	051)785-****
Danny Devito	 055)278-3649	055)278-****
Sean Connery	 02)381-5440	02)381-****
Christian Slater 031)345-5677	031)345-****
Charlie Sheen	 055)423-9870	055)423-****
Anthony Hopkins	 02)6122-2345	02)6122-****
*/

select name,tel,substr(tel,1,instr(tel,'-')-1) || '-' || replace(substr(tel,-4,4),substr(tel,-4,4),'****') "REPLACE" from student;
select name,tel,rpad(substr(tel,1,instr(tel,'-')-1)||'-',length(tel),'*') "REPLACE" from student;