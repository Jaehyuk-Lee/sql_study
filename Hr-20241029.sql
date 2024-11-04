SELECT studno, name, deptno
FROM student
WHERE grade = '1';

SELECT studno, name, grade, deptno, weight
FROM student
WHERE weight <= 70;

SELECT name, position, sal, deptno
FROM professor
WHERE sal >= 430;

SELECT name "교수의 이름", position 직급, sal 급여, deptno "학과No."
FROM professor
WHERE name = '김도훈';

SELECT studno, name, weight, deptno, grade
FROM student
WHERE grade = '1'
AND weight >= 70;

SELECT studno, name, weight, deptno
FROM student
WHERE grade = '1'
OR weight >= 70;

SELECT studno, name, weight, deptno
FROM student
WHERE NOT deptno = 101;

SELECT studno, name, weight
FROM student
WHERE weight BETWEEN 50 AND 70;

SELECT name, birthdate
FROM student
WHERE birthdate between '81/01/01' and '83/12/31'
AND name = '임유진';

SELECT name, sal, deptno
FROM professor
WHERE deptno = 101
AND sal >= 420
AND position = '교수';

SELECT ename, sal, deptno
FROM emp
WHERE sal BETWEEN 1300 AND 4500;

SELECT name, grade, deptno
FROM student
WHERE deptno IN(102, 201);

SELECT name, grade, deptno
FROM student
WHERE name LIKE '김%'
AND grade = '2';

SELECT studno, name, grade, deptno, profno
FROM student
WHERE name LIKE '%진'
AND deptno = 101;
-- AND profno IS NULL;

SELECT name, grade, deptno
FROM student
WHERE name LIKE '김_영';

SELECT name, deptno
FROM professor
WHERE deptno NOT IN(101, 202)
AND name LIKE '권__';

INSERT INTO student (studno, name)
VALUES (33333, '황보_정호');

SELECT name, deptno
FROM student
WHERE name LIKE '황보\_%' escape '\';

SELECT name position, comm
FROM professor
WHERE comm IS NOT NULL;

SELECT studno, deptno, profno
FROM student
WHERE profno IS NULL
AND deptno = 201;

SELECT name, grade, deptno
FROM student
WHERE deptno = 102
AND (grade = '1'
OR grade = '4');

SELECT empno, ename, sal, comm
FROM emp
WHERE ename LIKE '%A%'
AND comm IS NULL;

CREATE TABLE stud_heavy
AS SELECT *
FROM student
WHERE weight >= 70 AND grade = '1';

CREATE TABLE stud_101
AS SELECT *
FROM student
WHERE deptno = 101 AND grade = '1';

SELECT studno, name
FROM stud_heavy
UNION
SELECT studno, name
FROM stud_101;

SELECT name, userid, 0 sal
FROM student
UNION
SELECT name, userid, sal
FROM professor;

SELECT name, position
FROM professor
MINUS
SELECT name, position
FROM professor
WHERE position = '전임강사';

SELECT name, position
FROM professor
WHERE position != '전임강사';

SELECT name, grade, tel
FROM student
ORDER BY name;

SELECT empno, ename
FROM emp
ORDER BY sal DESC;

SELECT ename, job, deptno, sal
FROM emp
ORDER BY deptno, sal DESC;

SELECT ename, deptno
FROM emp
WHERE deptno IN(10, 30)
ORDER BY ename;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '1982-01-01' AND '1982-12-31';

SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL
ORDER BY sal DESC, comm DESC;

SELECT ename, sal, comm
FROM emp
WHERE comm >= sal * 0.2
AND deptno = 30
ORDER BY ename;

SELECT INITCAP(ename) "Name", LENGTH(ename) "Length"
FROM emp
WHERE SUBSTR(ename, 1, 1) IN ('J', 'A', 'M')
ORDER BY ename;

SELECT position, LPAD(position, 10, '*') lpad_position, userid, RPAD(userid, 12, '+') rpad_userid
FROM professor;

SELECT LTRIM('xyxXxyLAST WORD', 'xy') FROM dual;
SELECT RTRIM('TURNERyxXxxxxxxxyyyy', 'xy') FROM dual;

SELECT TRUNC(-123.123, 0), FLOOR(-123.123) FROM dual;

SELECT name, sal, sal/22, ROUND(sal/22), ROUND(sal/22, 2), ROUND(sal/22, -1)
FROM professor
WHERE deptno = 101;

SELECT ROUND(123.5), ROUND(124.5) FROM dual;

SELECT name, sal, sal/22, ROUND(sal/22), TRUNC(sal/22), ROUND(sal/22, 2)
FROM professor
WHERE deptno = 101;

SELECT name, hiredate, hiredate+30, hiredate+60
FROM professor
WHERE profno = 9908;

SELECT profno, hiredate, 
    MONTHS_BETWEEN(SYSDATE, hiredate) TENURE, 
    ADD_MONTHS(hiredate, 6) REVIEW
FROM professor
WHERE MONTHS_BETWEEN(SYSDATE, hiredate) < 360;

SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '일'), NEXT_DAY(SYSDATE, 1) -- 일요일부터 1
FROM dual;

SELECT TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') normal,
    TO_CHAR(ROUND(hiredate, 'dd'), 'YY/MM/DD') round_dd,
    TO_CHAR(ROUND(hiredate, 'mm'), 'YY/MM/DD') round_mm,
    TO_CHAR(ROUND(hiredate, 'yy'), 'YY/MM/DD') round_yy
FROM professor
WHERE deptno = 101;

SELECT studno
FROM student
WHERE studno = '010101';

EXPLAIN plan FOR
SELECT studno
FROM student
WHERE studno = '010101';
SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT studno, TO_CHAR(birthdate, 'YY-MM') birthdate
FROM student
WHERE name = '전인하';

-- NLS_LANGUAGE 바꾸기 (달력 출력 형식 변경용)
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT name, grade, 
    TO_CHAR(birthdate, 'Day Mon DD, YYYY') birthdate, -- 영어 세글자
    TO_CHAR(birthdate, 'Day Month DD, YYYY') birthdate2 -- 영어 전체
FROM student
WHERE deptno = 102;

-- 한국으로 되돌리기
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

SELECT TRUNC(SYSDATE-TO_DATE('1997-07-28', 'YYYY-MM-DD')) "Lived day", 
    TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1997-07-28', 'YYYY-MM-DD'))) "month"
FROM dual;

SELECT name, position, TO_CHAR(hiredate, 'Mon "the" DDTH "of" YYYY') "Hiredate"
FROM professor
WHERE deptno = 101;

SELECT name, sal, comm, TO_CHAR((sal+comm)*12, '9,999') annual_sal
FROM professor
WHERE comm IS NOT NULL;

SELECT TO_NUMBER('0123.1') num
FROM dual;

SELECT name, hiredate
FROM professor
WHERE hiredate = TO_DATE('6월 01, 01', 'MONTH DD, YY');

SELECT name, TO_CHAR(TO_DATE(SUBSTR(idnum, 1, 6), 'YYMMDD'), 'YY/MM/DD') birthdate
FROM student;

SELECT name, position, sal, comm, sal+comm,
    sal + NVL(comm, 0) s1, NVL(sal+comm, sal) s2
FROM professor
WHERE deptno = 201;

-- 사원 테이블에서 사번, 이름, 급여, 커미션, 급여+커미션
SELECT empno, ename, sal, comm, sal+NVL(comm, 0)
FROM emp;

SELECT name, position, sal, comm, NVL2(comm, sal+comm, sal) total
FROM professor
WHERE deptno = 102;

SELECT name, NVL(TO_CHAR(comm), 'no') comm
FROM professor;


/* 1. 급여가 $2,500 ~ $5,000이고 직무가 SALESMAN나 ANALYST가 아닌 사원의
사번, 이름, 직무, 급여를 직무,급여의 오름차순으로 정렬 하세요.(결과가 아래와 같이 나오도록)

EMPNO ENAME JOB SAL
-------- ---------- --------- ----------
7782 CLARK MANAGER 2450
7698 BLAKE MANAGER 2850
7566 JONES MANAGER 2975
7839 KING PRESIDENT 5000 */
SELECT empno, ename, job, sal
FROM emp
WHERE sal BETWEEN 2000 AND 5000
AND job NOT IN ('SALESMAN', 'ANALYST')
ORDER BY job, sal;

/* 2. 학생 테이블에서 이름이 '훈'으로 끝나고, 지도교수가 배정되지 않는
201번 학과 학생의 아이디, 이름, 학년, 학과 번호를 출력하여라.
(이름의 내림차순으로 정렬하세요.) */

SELECT studno, name, grade, deptno
FROM student
WHERE name LIKE '%훈'
AND profno IS NULL
AND deptno = 201
ORDER BY name DESC;

/* 3. 사원명, 입사일 그리고 입사한 요일을 출력하세요.
(요일 순으로 정렬하세요.)

ENAME HIREDATE DAY
-------------------- -------- ------------------------
SMITH 80/12/17 수요일
ALLEN 81/02/20 금요일
WARD 81/02/22 일요일 */

SELECT ename, hiredate, TO_CHAR(hiredate, 'DAY') day
FROM emp
ORDER BY NEXT_DAY(hiredate, 2) - hiredate DESC;

