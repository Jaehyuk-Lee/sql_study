select * from student;
select * from department;

CREATE TABLE subject
(subno NUMBER(5)
    CONSTRAINT subject_no_pk PRIMARY KEY
    DEFERRABLE INITIALLY DEFERRED
    USING INDEX TABLESPACE indx,
subname VARCHAR2(20)
    CONSTRAINT subject_name_nn NOT NULL,
term VARCHAR2(6)
    CONSTRAINT subject_term_ck CHECK (term in ('1', '2')),
type VARCHAR2(6));

DESC subject;

ALTER TABLE student
ADD CONSTRAINT stud_no_pk PRIMARY KEY(studno);

CREATE TABLE sugang
(studno NUMBER(5)
    CONSTRAINT sugang_studno_fk REFERENCES student(studno),
subno NUMBER(5)
    CONSTRAINT sugang_subno_fk REFERENCES subject(subno),
regdate DATE,
result NUMBER(3),
    CONSTRAINT sugang_pk PRIMARY KEY(studno, subno));

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('SUBJECT', 'SUGANG');

ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum);

ALTER TABLE student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL);

ALTER TABLE department ADD CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno);

ALTER TABLE student ADD CONSTRAINT stud_deptno_fk
FOREIGN KEY(deptno) REFERENCES department(deptno);

ALTER TABLE professor ADD CONSTRAINTS prof_pk PRIMARY KEY(profno);
ALTER TABLE professor MODIFY (name NOT NULL);
ALTER TABLE professor ADD CONSTRAINTS prof_fk
FOREIGN KEY(deptno) REFERENCES department(deptno);

ALTER TABLE department MODIFY (dname NOT NULL);

-- 즉시 제약조건
INSERT INTO subject VALUES(1, 'SQL', '1', '필수');

INSERT INTO subject VALUES(2, '', '3', '필수');

INSERT INTO subject VALUES(3, 'Java', '3', '선택');

SELECT * FROM subject;

-- 지연 제약조건
INSERT INTO subject VALUES(4, '데이터베이스', '1', '필수');
INSERT INTO subject VALUES(4, '데이터모델링', '2', '선택');

SELECT * FROM subject;
COMMIT;
SELECT * FROM subject;
-- 커밋 전까지는 둘 다 들어갔다가 커밋하면 둘 다 롤백됨.

-- 제약조건 활성화/비활성화
ALTER TABLE sugang DISABLE CONSTRAINT sugang_Pk;

SELECT constraint_name, status
FROM user_constraints
WHERE table_name IN ('SUGANG', 'SUBJECT');

ALTER TABLE sugang ENABLE CONSTRAINT sugang_Pk;

SELECT table_name, constraint_name, constraint_type, status
FROM user_constraints
WHERE table_name IN ('STUDENT', 'PROFESSOR', 'DEPARTMENT')
ORDER BY table_name;

CREATE UNIQUE INDEX idx_dept_name
ON department(dname);

DROP INDEX idx_dept_name;

CREATE INDEX idex_stud_dno_grade
ON student(deptno, grade);

CREATE INDEX fidx_stud_no_name ON student(deptno DESC, name);

CREATE INDEX uppercase_idx ON emp (UPPER(ename));
SELECT * FROM emp WHERE UPPER(ename) = 'KING';

SELECT deptno, dname
FROM department d
WHERE dname = '정보미디어학부';

DROP INDEX idx_dept_name;

CREATE INDEX idx_stud_birthdate
ON student(birthdate);

SELECT name, birthdate
FROM student
WHERE birthdate = '79/04/02';

EXPLAIN plan FOR
SELECT name, birthdate
FROM student
WHERE birthdate > '79/04/02';
SELECT * FROM TABLE(dbms_xplan.display);

EXPLAIN plan FOR
SELECT name, birthdate
FROM student
WHERE birthdate_char > '79/04/02';
SELECT * FROM TABLE(dbms_xplan.display);






DESC student;

SELECT name, birthdate
FROM student
WHERE birthdate = '79/04/02';

SELECT name, birthdate
FROM student
WHERE birthdate = TO_DATE('79/04/02', 'YY/MM/DD');

SELECT name, birthdate
FROM student
WHERE TO_CHAR(birthdate, 'YY/MM/DD') = '79/04/02';



DESC test;
SELECT * FROM test;

SELECT * FROM test
WHERE num_ = '2';

SELECT * FROM test
WHERE num_ = TO_NUMBER('2');

SELECT * FROM test
WHERE TO_CHAR(num_) = '2';






SELECT name, birthdate
FROM student
WHERE TO_DATE(birthdate, 'YY/MM/DD') = TO_DATE('79/04/02', 'YY/MM/DD');




SELECT name, birthdate
FROM student
WHERE birthdate BETWEEN TO_DATE('79/04/02 00:00:00', 'YY/MM/DD HH24:MI:SS') 
                    AND TO_DATE('79/04/03 00:00:00', 'YY/MM/DD HH24:MI:SS');


SELECT TRUNC(TO_DATE('79/04/02', 'YY/MM/DD'), 'day') FROM dual;

DROP INDEX idx_stud_birthdate;

ALTER INDEX stud_no_pk REBUILD;

CREATE VIEW v_stud_dept101 AS
    SELECT studno, name, deptno
    FROM student
    WHERE deptno = 101;

CREATE VIEW v_stud_dept102
AS SELECT s.studno, s.name, s.grade, d.dname
    FROM student s, department d
    WHERE s.deptno = d.deptno AND s.deptno = 102;

CREATE VIEW v_prof_avg_sal
AS SELECT deptno, sum(sal) sum_sal, avg(sal) avg_sal
    FROM professor
    GROUP BY deptno;

-- 인라인 뷰
SELECT dname, avg_height, avg_weight
FROM (SELECT deptno, AVG(height) avg_height, avg(weight) avg_weight
    FROM student
    GROUP BY deptno) s, department d
WHERE s.deptno = d.deptno;

SELECT view_name, text
FROM user_views;

CREATE OR REPLACE VIEW v_stud_dept101 AS
    SELECT studno, name, deptno, grade
    FROM student
    WHERE deptno = 101;

SELECT * FROM v_stud_dept101;

DROP VIEW v_stud_dept101;

SELECT s.grade, name, height, ROUND(v_s.AVG_HEIGHT)
FROM (SELECT grade, AVG(height) AVG_HEIGHT
    FROM student 
    GROUP BY grade) v_s, student s
WHERE v_s.grade = s.grade
AND s.height > v_s.AVG_HEIGHT
ORDER BY grade, height DESC;

SELECT * FROM user_tab_privs_made;
SELECT * FROM user_tab_privs_recd;

SELECT * FROM user_col_privs_made;
SELECT * FROM user_col_privs_recd;

-- 1.
create tablespace sesac
datafile '/opt/oracle/oradata/FREE/sesac.dbf' size 100m;

-- ALTER SESSION SET "_ORACLE_SCRIPT"=true; 잊지 말기

-- 2.
create user sesac identified by sesac123
default TABLESPACE sesac
temporary TABLESPACE temp;

-- 3.
CREATE TABLE employees
(EMPLOYEE_ID NUMBER(7),
LAST_NAME VARCHAR2(25),
FIRST_NAME VARCHAR2(25),
DEPTNO NUMBER(2),
PHONE_NUMBER VARCHAR2(20));

-- 4.
INSERT INTO employees
VALUES(1, 'Biri', 'Ben', 10, '123-4566');
INSERT INTO employees
VALUES(2, 'Dancs', 'Betty', 20, '123-7890');
INSERT INTO employees
VALUES(3, 'Newman', 'Chad', 20, '123-8888');
INSERT INTO employees
VALUES(3, 'New', 'haha', 20, '123-8888');

-- 5.
ALTER TABLE employees
ADD CONSTRAINT emp_id_pk PRIMARY KEY(employee_id);

-- 기본키 제약 조건을 추가할 수 없는 이유: 기본키로 지정하려는 employee_id 칼럼에 이미 값이 중복된 두 열이 존재함.
-- 해결 방법: employee_id 칼럼에 3 값을 갖는 열 중 LAST_NAME이 'New'인 열의 employee_id 값을 4로 변경하여 중복 제거

UPDATE employees
SET EMPLOYEE_ID = 4
WHERE LAST_NAME = 'New';

-- 위 쿼리를 실행한 후 위에 적어놓은 제약조건 추가 쿼리를 실행하면 정상적으로 제약조건이 추가됨.

-- 6.
DROP TABLE employees;