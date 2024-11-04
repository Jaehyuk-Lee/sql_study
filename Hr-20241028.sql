select * from professor;
select * from department;
select * from student;
select * from salgrade;

select * from tab;

desc professor;
desc department;
desc student;

select deptno, dname, college, loc
from department;

select name, position, sal from professor;

select name, deptno, grade, studno from student;

SELECT DISTINCT deptno, grade FROM student;

SELECT DISTINCT deptno FROM professor;

SELECT dname "department name", deptno "부서 번호#"
FROM department;

SELECT studno as 학번, name "학생의 이름", grade 학년
from student;

SELECT studno || ' ' || name "Student"
From student;

SELECT name, weight, weight * 2.2 AS weight_pound
FROM student;

DESC department;
SELECT name, position, sal, deptno FROM professor;
SELECT studno, name, userid FROM student;
SELECT DISTINCT position FROM professor;
SELECT profno "교수 No", name 이름, position 직급, deptno "학과 번호" FROM professor;
SELECT ename || ',' || job AS "Employee and Title" FROM emp;
SELECT profno, name, position, sal, sal*1.33 "New Salary" FROM professor;

CREATE TABLE ex_type (c char(10), v varchar2(10));

DESC ex_type;

INSERT INTO ex_type VALUES ('sql', 'sql');

SELECT * FROM ex_type;
SELECT * FROM ex_type
WHERE v = 'sql';
SELECT * FROM ex_type
WHERE c = 'sql';
SELECT * FROM ex_type
WHERE c = v; -- 타입이 달라서 안됨
-- 값이 같아도 타입이 다르면 = 연산자에서 FALSE가 나오기 때문에 JOIN할 때 유의해야 함

SELECT sysdate FROM dual;

SELECT rownum, rowid, profno, name, position, sal
FROM professor;

CREATE TABLE ex_time (
id  NUMBER(2),
basictime   TIMESTAMP,
standardtime TIMESTAMP WITH TIME ZONE,
localtime TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO ex_time VALUES(1, sysdate, sysdate, sysdate);

SET LINESIZE 100
SELECT * FROM ex_time;

SELECT 20 * 30 FROM dual;

SELECT SYSDATE - 1 YESTERDAY, SYSDATE TODAY, SYSDATE + 1 TOMORROW FROM DUAL;

SELECT name, userid, INITCAP(userid)
FROM student
WHERE name = '김영균';

SELECT userid, LOWER(userid), UPPER(userid)
FROM student
WHERE studno = 20101;

EXPLAIN plan FOR 
SELECT empno, ename, sal
FROM emp
WHERE ename = UPPER('Scott');
SELECT *
  FROM TABLE(dbms_xplan.display);

EXPLAIN plan FOR 
SELECT empno, ename, sal
FROM emp
WHERE INITCAP(ename) = 'Scott';
SELECT *
  FROM TABLE(dbms_xplan.display);

SELECT *
FROM emp
WHERE job = UPPER('manager');

-- dbane 칼럼의 데이터가 한글이라서 length와 lengthb 함수의 결과가 다르다
-- UTF-8에서 한글은 3byte
SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM department;

SELECT CONCAT(CONCAT(name, '의 직책은 '), position) "교수의 직책"
FROM professor;

SELECT name, idnum, SUBSTR(idnum, 1, 6) birth, SUBSTR(idnum, 3, 2) birth_month, SUBSTR(idnum, 5, 2) birth_date
FROM student
WHERE grade = '1'
AND SUBSTR(idnum, 7, 1) = '1';


-- 1. 
SELECT DISTINCT job
FROM emp;

-- 2.
SELECT ename "Name", sal*12 "Annual Salary"
FROM emp;

-- 3.
SELECT ename || ': 1 Month salary = ' || sal monthly
FROM emp;

-- 4. 사원 테이블에서 사원 번호, 이름, 급여 그리고 25% 증가된 급여를 모두 출력하세요.
--열 레이블은 New Salary입니다.
SELECT empno, ename, sal, sal * 1.25 "New Salary"
FROM emp;


-- 5. 4에 추가하여 새로운 급여(New Salary)에서 예전의 급여(SAL)를 빼는 열을 추가하세요.
-- 열 레이블은 Increase입니다.
SELECT empno, ename, sal, sal * 1.25 "New Salary", sal * 1.25 - sal "Increase"
FROM emp;

-- 6. 사원 테이블에서 2월에 입사한 사원을 출력해 보세요.
SELECT *
FROM emp
WHERE SUBSTR(hiredate, 4, 2) = '02';

-- 7. 첫번째 문자는 대문자로 그리고 나머지는
-- 모두 소문자로 나타나는 사원의 이름과 이름 길이를 출력하는 질의를 작성하세요.
-- 각각의 열에 Name, Length라는 레이블을 부여하세요.
SELECT INITCAP(ename) "Name", LENGTH(ename) "Length"
FROM emp;


SELECT * FROM emp;