SELECT e.empno, e.ename, e.sal, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'CHICAGO';

SELECT s.studno, s.name, s.grade, d.dname, d.loc
FROM student s, department d
WHERE grade = (SELECT grade
    FROM student
    WHERE userid = 'jun123')
AND s.deptno = d.deptno
ORDER BY d.dname;

SELECT name, deptno, weight
FROM student
WHERE weight < (SELECT AVG(weight)
    FROM student
    WHERE deptno = 101)
ORDER BY deptno;

SELECT name, grade, height
FROM student
WHERE grade = (SELECT grade
    FROM student
    WHERE studno = 20101)
AND height > (SELECT height
    FROM student
    WHERE studno = 20101);

SELECT name, grade, deptno
FROM student
WHERE deptno IN (SELECT deptno
    FROM department
    WHERE college = 100);

SELECT studno, name, height
FROM student
WHERE height > ANY (SELECT height
    FROM student
    WHERE grade = '4');
-- > 일 때는 height에 MIN씌운 것과 같음
-- < 일 때는 MAX
-- ANY 대신 ALL을 쓰면 height에 MIN이 아니고 반대로 MAX 씌운 것과 같음
SELECT studno, name, height
FROM student
WHERE height > ALL (SELECT height
    FROM student
    WHERE grade = '4');

-- EXISTS: 서브쿼리 결과가 존재하면 메인 결과 전체 출력
SELECT profno, name, sal, comm, SAL+NVL(comm, 0)
FROM professor
WHERE EXISTS (SELECT profno
    FROM professor
    WHERE comm IS NOT NULL);

SELECT 1 userid_exist
FROM dual
WHERE NOT EXISTS (SELECT userid
    FROM student
    WHERE userid = 'goodstudent');

-- PAIRWISE
SELECT name, grade, weight
FROM student
WHERE (grade, weight) IN (SELECT grade, MIN(weight)
    FROM student
    GROUP BY grade);
-- grade와 weight가 둘 다 SELECT 결과값과 일치해야 함. 순서도 중요.
-- 순서쌍이 통으로 맞아야된다는 느낌

-- UNPAIRWISE
SELECT name, grade, weight
FROM student
WHERE grade IN (SELECT grade
    FROM student
    GROUP BY grade)
AND weight IN (SELECT MIN(weight)
    FROM student
    GROUP BY grade);
-- grade가 서브쿼리 결과 중에 하나만 맞고, weight가 서브쿼리 결과 중에 하나만 맞으면 된다.

SELECT s.deptno, d.dname, COUNT(s.studno)
FROM student s, department d
WHERE s.deptno = d.deptno
GROUP BY s.deptno, d.dname
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
    FROM student
    GROUP BY deptno);

-- 서브쿼리 바깥의 테이블을 참조할 수 있으나 성능상 안좋음
SELECT name, deptno
FROM student s1
WHERE height > (SELECT AVG(height)
    FROM student s2
    WHERE s2.deptno = s1.deptno);

SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, sal
    FROM emp
    WHERE comm IS NOT NULL);

SELECT empno, ename, 
    (SELECT d.dname
    FROM dept d
    WHERE d.deptno = e.deptno) department_name
FROM emp e;

INSERT INTO student
VALUES(10111, '홍길동2', 'hong', '1', '9707281342313', SYSDATE, '041)630-1234',
    170, 70, 101, 9903);

SELECT * FROM student WHERE studno = 10111;

INSERT INTO department(deptno, dname)
VALUES (300, '생명공학부');

SELECT * FROM department WHERE deptno = 300;

INSERT INTO department
VALUES(301, '환경보건학과', '', '');

SELECT * FROM department WHERE deptno = 301;

INSERT INTO professor(profno, name, position, hiredate, deptno)
VALUES (9920, '최윤식', '조교수', TO_DATE('2006/01/01', 'YYYY/MM/DD'), 102);

SELECT * FROM professor WHERE profno = 9920;

INSERT INTO professor
VALUES (9910, '백미선', 'white', '전임강사', 200, SYSDATE, 10, 101);

SELECT * FROM professor WHERE profno = 9910;

CREATE TABLE T_STUDENT
AS SELECT * FROM STUDENT
WHERE 1 = 0;

INSERT INTO T_STUDENT
SELECT * FROM STUDENT;

SELECT * FROM T_STUDENT;

CREATE TABLE height_info (
    studno number(5),
    name varchar2(10),
    height number(5, 2)
);
CREATE TABLE weight_info (
    studno number(5),
    name varchar2(10),
    weight number(5, 2)
);

INSERT ALL
INTO height_info VALUES (studno, name, height)
INTO weight_info VALUES (studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade >= '2';

SELECT * FROM WEIGHT_INFO;
SELECT * FROM height_INFO;

DELETE FROM weight_info;
DELETE FROM height_info;

SELECT * FROM weight_info;
ROLLBACK;

INSERT ALL
WHEN height > 170 THEN
    INTO height_info VALUES (studno, name, height)
WHEN weight > 70 THEN
    INTO weight_info VALUES (studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade >= '2';

SELECT * FROM weight_info;
SELECT * FROM height_info;

DELETE FROM weight_info;
DELETE FROM height_info;

ROLLBACK;
COMMIT;

INSERT FIRST
WHEN height > 170 THEN
    INTO height_info VALUES (studno, name, height)
WHEN weight > 70 THEN
    INTO weight_info VALUES (studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade >= '2';

SELECT * FROM height_info;
SELECT * FROM weight_info;

SELECT * FROM professor WHERE profno = 9903;
UPDATE professor
SET position = '부교수'
WHERE profno = 9903;

UPDATE student
SET (grade, deptno) = (SELECT grade, deptno
    FROM student
    WHERE studno = 10103)
WHERE studno = 10201
ORDER BY studno;

SELECT * FROM student;
ROLLBACK;

UPDATE professor
SET sal = sal * 1.12
WHERE sal < 410
AND position = (SELECT position
    FROM professor
    WHERE name = '성연희');

SELECT * FROM professor
WHERE position = (SELECT position
    FROM professor
    WHERE name = '성연희');

DELETE
FROM student
WHERE studno = 20103;

SELECT *
FROM STUDENT
WHERE STUDNO = 20103;

DELETE FROM student;

SELECT * FROM student;

ROLLBACK;

DELETE FROM student
WHERE deptno = (SELECT deptno
    FROM department
    WHERE dname = '컴퓨터공학과');
    
SELECT *
FROM student;

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS';

DELETE
FROM emp
WHERE deptno = (SELECT deptno
    FROM dept
    WHERE loc = 'DALLAS');
    
ROLLBACK;

CREATE TABLE professor_temp AS
SELECT *
FROM professor
WHERE position = '교수';

SELECT * FROM professor_temp;

UPDATE professor_temp
SET position = '명예교수';

INSERT INTO professor_temp
VALUES (9999, '김도경', 'arom21', '전임강사', 200, SYSDATE, 10, 101);

MERGE INTO professor p
USING professor_temp f
on (p.profno = f.profno)
WHEN MATCHED THEN
UPDATE SET p.position = f.position
WHEN NOT MATCHED THEN
INSERT VALUES(f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno);

SELECT * FROM professor;

CREATE SEQUENCE s_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 100;

SELECT min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name = 'S_SEQ';

ALTER SEQUENCE s_seq MAXVALUE 20001;

INSERT INTO emp VALUES
(S_SEQ.NEXTVAL, 'CATHY1', 'SALESMAN', 7698, SYSDATE, 800, NULL, 20);

SELECT * FROM emp;

SELECT S_SEQ.CURRVAL FROM dual;

DROP SEQUENCE S_SEQ;

CREATE TABLE address
(id NUMBER(3),
name VARCHAR2(50),
addr VARCHAR2(100),
phone VARCHAR2(30),
email VARCHAR2(100));

INSERT INTO address
VALUES (1, '수원', '경기도 수원시 영통구 매탄동 어딘가', '031)292-3314', 'alex00728@naver.com');

SELECT * FROM address;

CREATE TABLE addr_second(id, name, addr, phone, e_mail) -- email -> e_mail 변경
AS SELECT * FROM address;

SELECT * FROM addr_second;

CREATE TABLE addr_fourth
AS SELECT id, name FROM address
WHERE 1=2; -- 데이터 빼고

SELECT * FROM addr_fourth;

CREATE TABLE professor2
AS SELECT * FROM professor;

SELECT * FROM professor2;

CREATE TABLE professor3
AS SELECT * FROM professor
WHERE 1=2;

SELECT * FROM professor3;

CREATE TABLE addr_third
AS SELECT id, name FROM address;

SELECT * FROM addr_third;

ALTER TABLE addr_third
ADD (birth DATE);

SELECT * FROM addr_third;

ALTER TABLE address
ADD (comments VARCHAR2(200) DEFAULT 'No comment');

SELECT * FROM address;

ALTER TABLE address
DROP (comments);

SELECT * FROM address;

ALTER TABLE ADDRESS
MODIFY (phone VARCHAR2(50));

RENAME addr_3rd
TO addr_third;

SELECT * FROM addr_third;

DESC dept;
DESC emp;

CREATE TABLE addr_temp
AS SELECT * FROM address;
DELETE FROM addr_temp;
ROLLBACK;
SELECT * FROM addr_temp;
TRUNCATE TABLE addr_temp;

DROP TABLE addr_temp;

COMMENT ON TABLE address
IS '고객 주소록을 관리하기 위한 테이블';

DESC address;

COMMENT ON COLUMN address.name
IS '고객 이름';

SELECT COMMENTS
FROM USER_TAB_COMMENTS
WHERE table_name = 'ADDRESS';

SELECT * FROM USER_COL_COMMENTS
WHERE table_name = 'ADDRESS';

COMMENT ON TABLE ADDRESS IS '';
COMMENT ON COLUMN ADDRESS.NAME IS '';

SELECT owner, table_name FROM all_tables;
SELECT owner, table_name FROM dba_tables; -- hr로 접근 불가능


-- 1.
DELETE FROM student
WHERE studno BETWEEN 20000 AND 25000;

-- 2.
CREATE TABLE student2 
AS SELECT studno, name, userid, grade, deptno FROM student;

-- 3-1.
CREATE SEQUENCE STUDNO_SEQ
START WITH 1
MAXVALUE 50000
INCREMENT BY 10;

-- 3-2.
INSERT INTO student2
VALUES (STUDNO_SEQ.NEXTVAL, '아무개', 'someone', 1, 101);

-- 4.
UPDATE professor
SET userid = 'black'
WHERE name = '백미선';

-- 5. 
SELECT deptno, ename, sal
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, MAX(sal)
    FROM emp
    GROUP BY deptno);

-- 6.
SELECT p.profno, p.name, p.hiredate, d.dname
FROM professor p, department d
WHERE p.deptno = d.deptno
AND (p.hiredate, d.deptno) IN (SELECT MIN(hiredate), deptno
    FROM professor
    GROUP BY deptno)
ORDER BY hiredate;

