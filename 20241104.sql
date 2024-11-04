-- Active: 1730272681654@@127.0.0.1@1521@freepdb1@ACE
-- 부서: t_dept
-- 직원: t_emp

CREATE TABLE t_dept
(deptno NUMBER(2),
dname VARCHAR2(30),
loc VARCHAR2(10));

CREATE TABLE t_emp
(empno NUMBER(4),
ename VARCHAR2(30),
hp VARCHAR2(11),
sal NUMBER,
deptno NUMBER(2));

ALTER TABLE t_dept
ADD CONSTRAINT t_dept_pk PRIMARY KEY(deptno);
ALTER TABLE t_dept
MODIFY (dname NOT NULL);
ALTER TABLE t_emp
ADD CONSTRAINT t_emp_pk PRIMARY KEY(empno);
ALTER TABLE t_emp
MODIFY (ename NOT NULL);
ALTER TABLE t_emp
ADD CONSTRAINT t_emp_ename_nn CHECK(ename IS NOT NULL);
ALTER TABLE t_emp
ADD CONSTRAINT t_emp_hp_uk UNIQUE(hp);
ALTER TABLE t_emp
ADD CONSTRAINT t_emp_sal_chk CHECK (sal >= 100);
ALTER TABLE t_emp
ADD CONSTRAINT t_emp_deptno_fk FOREIGN KEY(deptno) REFERENCES t_dept(deptno);

SELECT * FROM user_constraints WHERE table_name IN ('T_DEPT', 'T_EMP') ORDER BY table_name, constraint_name;
ALTER TABLE t_emp DROP CONSTRAINT T_EMP_ENAME_NN;


ALTER TABLE t_emp
ADD (
    jumin1 VARCHAR2(6),
    jumin2 VARCHAR2(7)
);

ALTER TABLE t_emp
ADD CONSTRAINT t_emp_jumin1_nn CHECK(jumin1 IS NOT NULL);
ALTER TABLE t_emp
MODIFY (jumin2 CONSTRAINT t_emp_jumin2_nn NOT NULL);

-- composite index
ALTER TABLE t_emp
ADD CONSTRAINT t_emp_jumin_uk UNIQUE(jumin1, jumin2);

DROP TABLE t_emp;
DROP TABLE t_dept;

SELECT * FROM emp e, dept d WHERE e.deptno /*(+)*/ = d.deptno (+);
SELECT * FROM emp e FULL JOIN dept d ON e.deptno = d.deptno;

-- employees, job_grades, departments
-- 사원명, 사수명, 급여, 등급, 부서명
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_GRADES;

SELECT e.last_name last_name, NVL2(e2.last_name, e2.last_name, '-') manager_last_name, e.salary salary, g.grade_level grade_level, NVL2(d.department_name, d.department_name, '-') department_name FROM EMPLOYEES e
LEFT JOIN EMPLOYEES e2 ON e.manager_id = e2.employee_id
LEFT JOIN DEPARTMENTS d ON e.department_id = d.department_id
LEFT JOIN JOB_GRADES g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

