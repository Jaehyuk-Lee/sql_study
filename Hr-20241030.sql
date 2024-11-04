SELECT name, userid, LENGTHB(name), LENGTHB(userid),
    NULLIF(LENGTHB(name)/3*2, LENGTHB(userid)) nullif_result
FROM professor;

SELECT name, comm, sal, COALESCE(comm, sal, 0) CO_RESULT
FROM professor;

SELECT name, deptno,
    DECODE(deptno, 101, '컴퓨터공학과', 102, '멀티미디어학과',
        201, '전자공학과', '기계공학과') DNAME
FROM professor;

SELECT name, DECODE(deptno, 101, 'Computer Science', 'ETC')
FROM student;

SELECT name, deptno, sal,
    CASE WHEN DEPTNO = 101 THEN sal * 0.1
         WHEN DEPTNO = 102 THEN sal * 0.2
         WHEN DEPTNO = 103 THEN sal * 0.3
         ELSE 0
    END bonus
FROM professor;

SELECT name, SUBSTR(idnum, 3, 2) MONTH, 
    CASE WHEN SUBSTR(idnum, 3, 2) IN('01', '02', '03') THEN '1/4'
         WHEN SUBSTR(idnum, 3, 2) IN('04', '05', '06') THEN '2/4' 
         WHEN SUBSTR(idnum, 3, 2) IN('07', '08', '09') THEN '3/4' 
         WHEN SUBSTR(idnum, 3, 2) IN('10', '11', '12') THEN '4/4'
    END Quarter
FROM student;

SELECT COUNT(comm)
FROM professor
WHERE deptno = 101;

SELECT COUNT(job)
FROM emp;

SELECT COUNT(DISTINCT job)
FROM emp;

SELECT AVG(weight), SUM(weight)
FROM student;

SELECT MAX(height), MIN(height)
FROM student;

SELECT STDDEV(sal), VARIANCE(sal)
FROM professor;

SELECT MAX(sal) "Maximum", MIN(SAL) "Minimum", ROUND(SUM(sal)) "Sum", ROUND(AVG(sal)) "Average"
FROM emp;

SELECT AVG(sal)
FROM professor
GROUP BY deptno;

SELECT AVG(sal), position
FROM professor
GROUP BY position;

-- COUNT(*)은 NULL을 포함
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno;

SELECT AVG(sal), deptno, position
FROM professor
GROUP BY deptno, position;

SELECT deptno, grade, COUNT(*), ROUND(AVG(weight))
FROM student
GROUP BY deptno, grade;

SELECT deptno, position, count(*)
FROM professor
GROUP BY ROLLUP(deptno, position);

SELECT deptno, grade, COUNT(*),
    GROUPING(deptno) grp_dno,
    GROUPING(grade) grp_grade
FROM student
GROUP BY ROLLUP(deptno, grade);

SELECT deptno, grade, NULL birthdate, COUNT(*)
FROM student
GROUP BY deptno, grade
UNION ALL
SELECT deptno, NULL, TO_CHAR(birthdate, 'YYYY'), COUNT(*)
FROM student
GROUP BY deptno, TO_CHAR(birthdate, 'YYYY');

SELECT deptno, grade, TO_CHAR(birthdate, 'YYYY') birthdate, COUNT(*)
FROM student
GROUP BY GROUPING SETS((deptno, grade), (deptno, TO_CHAR(birthdate, 'YYYY')));

SELECT grade, COUNT(*), ROUND(AVG(height)) avg_height, ROUND(AVG(weight)) avg_weight
FROM student
GROUP BY grade
HAVING COUNT(*) > 4
ORDER BY avg_height DESC;

SELECT deptno, ROUND(AVG(sal))
FROM emp
WHERE sal >= 1000
GROUP BY deptno
HAVING AVG(sal) >= 2700;

SELECT MAX(AVG(weight)) max_weight
FROM student
GROUP BY deptno;

SELECT MAX(COUNT(studno)) max_cnt, MIN(COUNT(studno)) min_cnt
FROM student
WHERE userid IS NOT NULL
GROUP BY deptno;

-- JOIN 시작

SELECT s.studno, s.name, s.idnum, s.deptno, d1.dname, d2.dname, d3.dname
FROM student s, department d1, department d2, department d3
WHERE s.deptno = d1.deptno
AND d1.college = d2.deptno
AND d2.college = d3.deptno
ORDER BY d1.deptno, s.grade, s.name;

SELECT e.empno, e.ename, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS';

SELECT p.profno, p.name, p.sal, d.dname, d.loc
FROM professor p, department d
WHERE p.deptno = d.deptno
AND p.name = '이만식';

SELECT s.studno, s.name, s.deptno, d.loc, p.position, p.name
FROM student s, professor p, department d
WHERE s.deptno = d.deptno
AND s.profno = p.profno
AND s.profno IS NOT NULL;

SELECT s.studno, s.name, s.deptno, d.loc, p.position, p.name
FROM student s, professor p, department d
WHERE s.deptno = d.deptno
AND s.profno = p.profno
AND s.name IN ('전인하', '지은경', '김진경');

SELECT studno, name, s.deptno, d.deptno, dname
FROM student s CROSS JOIN department d;

SELECT s.studno, s.name, s.deptno, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno;

SELECT s.studno, s.name, deptno, d.dname, d.loc
FROM student s NATURAL JOIN department d;

SELECT s.studno, s.name, deptno, d.dname, d.loc
FROM student s JOIN department d
    USING (deptno);

SELECT s.studno, s.name, s.deptno, d.dname, p.name
FROM student s
INNER JOIN department d
ON s.deptno = d.deptno
INNER JOIN professor p
ON s.profno = p.profno;

SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade s
WHERE p.sal BETWEEN s.losal AND s.hisal;

SELECT p.profno, p.name, p.sal, s.grade
FROM professor p INNER JOIN salgrade s
ON p.sal BETWEEN s.losal AND s.hisal;

SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno = p.profno (+);

SELECT s.name, s.grade, p.name, p.position
FROM student s FULL JOIN professor p
ON s.profno = p.profno;

SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno = p.profno (+)
UNION
SELECT s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno (+) = p.profno;

SELECT s.studno, s.name, s.deptno, d.dname
FROM student s
LEFT JOIN department d
ON s.deptno = d.deptno;

SELECT e1.ename 사원명, e1.empno 사원번호, e2.ename 매니저이름, e2.empno 매니저번호
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno (+);

SELECT p.name, p.position, d.dname, d.loc
FROM professor p, department d
WHERE position = (SELECT position
    FROM professor
    WHERE name = '전은지')
AND p.deptno = d.deptno
ORDER BY name DESC;

-- 3.
SELECT mgr, SUM(sal)
FROM emp
WHERE mgr < 7788
GROUP BY ROLLUP (mgr);

-- 4.
SELECT mgr, job, SUM(sal)
FROM emp
WHERE mgr < 7788
GROUP BY ROLLUP (mgr, job);

-- 5.
SELECT mgr, job, SUM(sal)
FROM emp
WHERE mgr < 7788
GROUP BY CUBE (mgr, job);

