SELECT * FROM tab;

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM position;

SELECT * FROM USER_CONSTRAINTS
WHERE table_name IN (UPPER('employee'), UPPER('department'), UPPER('position'));


-- JOIN ~ ON ~
-- emp테이블의 사원명, 급여, dept테이블의 부서명을 선택하라

-- Equijoin, Innerjoin -> 필드의 값이 같은 데이터를 조인해준다. 조인 대상이 없으면 데이터를 제외한다
SELECT ename, sal, emp.deptno, dname FROM emp, dept WHERE emp.deptno=dept.deptno;
SELECT e.ename, e.sal, d.deptno, d.dname FROM emp e, dept d WHERE e.deptno=d.deptno;

SELECT ename, sal, dname FROM emp e JOIN dept d ON e.deptno=d.deptno;

-- [문제] emp와 dept테이블에서 업무가 MANAGER인 사원의 이름, 업무, 부서명, 근무지를 출력하라
SELECT e.ename name, e.job, d.dname dept, d.loc
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE e.job IN 'MANAGER';

SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno=d.deptno  AND e.deptno NOT IN 20;

SELECT e.ename, e.job, e.sal, e.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE e.deptno NOT IN 20		-- WHERE 대신 AND 사용 가능
ORDER BY e.ename;


--===============================================================================

-- 각 테이블에 쓰일 시퀀스 생성
CREATE SEQUENCE emp_seq
START WITH 1000
INCREMENT BY 1;

CREATE SEQUENCE pos_seq
START WITH 1
INCREMENT BY 1;
DROP SEQUENCE pos_seq;
CREATE SEQUENCE dept_seq
START WITH 1
INCREMENT BY 1;

-- 부서정보 추가
INSERT INTO department(dept_code, dept_name, dept_loc)
VALUES (dept_seq.nextval, 'HR', '203');
INSERT INTO department(dept_code, dept_name)
VALUES (dept_seq.nextval, 'PLAN');
SELECT * FROM department;

-- 직급정보 추가
INSERT INTO position (pos_code, pos_name)
VALUES (pos_seq.nextval, 'CEO');
INSERT INTO position (pos_code, pos_name, pos_desc)
VALUES (pos_seq.nextval, 'STAFF', 'career within 1 year');
SELECT * FROM position;

-- 사원등록
INSERT INTO employee (empno, username, password, dept_code, pos_code) 
VALUES (emp_seq.nextval, 'MARK', '1234', 1, 1);
INSERT INTO employee (empno, username, password, tel, gender, startwork, dept_code, pos_code)
VALUES (emp_seq.nextval, 'RACHEL', '1234', '010-1234-1234', 'F', SYSDATE, 2, 2);

-- 테이블 3개 조인하기
-- 사원번호, 사원명, 직급, 직급설명, 부서명, 부서위치
SELECT
	e.empno num, e.username name,
	p.pos_name pos, p.pos_desc description,
	d.dept_name dept, d.dept_loc location
FROM employee e
	JOIN department d ON e.dept_code=d.dept_code
	JOIN position p ON e.pos_code=p.pos_code;

-- employee테이블의 사원명, 연락처, 입사일
-- department테이블의 부서코드, 부서명, 부서위치
-- position테이블의 직급코드, 직급명을
-- 사원명, 연락처, 부서명, 부서위치, 직급명, 입사일, 부서코드, 직급코드 순서로 선택하고
-- 사원명을 오름차순으로 정렬하라
SELECT 
	e.username 이름, e.tel 연락처,
	d.dept_name 부서명, d.dept_loc 부서위치, p.pos_name 직급명,
	e.startwork 입사일, d.dept_code 부서코드, p.pos_code 직급코드
FROM employee e
	JOIN department d ON e.dept_code=d.dept_code
	JOIN position p ON e.pos_code=p.pos_code;

--==============================================================================

-- [문제] SALESMAN의 사원번호, 이름, 급여, 부서명, 근무지를 출력하라
SELECT
	e.empno, e.ename, e.sal, d.dname, d.loc
FROM emp e 
	JOIN dept d ON e.deptno=d.deptno
	WHERE e.job IN 'SALESMAN';

-- 서브쿼리를 이용한 조인
SELECT
	e.empno, e.ename, e.sal, d.dname, d.loc
FROM (SELECT empno, ename, sal, deptno FROM emp WHERE job IN 'SALESMAN') e
	JOIN dept d ON e.deptno=d.deptno;

SELECT e.empno,e.ename, e.sal, d.dname, d.loc
from EMP e join DEPT d 
on e.DEPTNO =d.DEPTNO and e.JOB = 'SALESMAN';

--==============================================================================

-- Non-Equijoin : 조인 조건이 정확히 일치하지 않는 경우 ex) 등급, 학점
SELECT
	e.ename, e.sal, s.grade
FROM emp e
	JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;
SELECT * FROM salgrade;
-- [문제] 10번과 20번 부서의 사원 중 사원명, 담당업무, 급여, 부서명, 부서위치, 호봉을 선택하라
SELECT 
	e.ename name, e.job, e.sal,
	d.dname dept, d.loc location,
	s.grade
FROM emp e
	JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
	JOIN dept d ON e.deptno=d.deptno
WHERE e.deptno IN (10, 20);

---------------------------------------------
-- [과제]
-- 작가테이블에 작가 최소 3명 등록
-- 출판사테이블에 출판사 최소 3곳 등록
-- 책테이블에 책을 최소 6권 등록
-- 조건 :
-- 1. 테이블 2개로 조인문제 만들어 풀기
-- 2. 테이블 3개로 조인문제 만들어 풀기
-----------------------------------------------

--================================================================================

-- Self Join -> 자체적으로 테이블을 조인, 동일한 테이블에 별칭을 다르게 붙여서 2개를 만든다
SELECT 
	e1.empno, e1.ename, e1.job, e1.mgr,
	e2.empno, e2.ename, e2.job
FROM emp e1
	FULL JOIN emp e2 ON e1.mgr=e2.empno;

-- [문제] emp테이블에서 "누구의 관리자는 누구이다"는 내용을 출력하라
-- LITERAL 문자열 사용
SELECT 
	e1.ename || '의 관리자는 ' || e2.ename || '이다.' manager
FROM emp e1
	JOIN emp e2 ON e1.mgr=e2.empno;

-- [문제] e사원명, e급여, d부서명, m관리자명, e입사일, s호봉을 선택하라
SELECT 
	e.ename name, e.sal,
	d.dname dept, m.ename manager, e.hiredate, s.grade
FROM emp e
	JOIN dept d ON e.deptno=d.deptno
	JOIN emp m ON e.mgr=m.empno 
	JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

--================================================================================

-- Outer Join -> 조인했을때 한 쪽 칼럼에 해당하는 데이커가 존재하지 않을때, 다른 쪽 테이블에 NULL로 표시
-- LEFT/RIGHT OUTER JOIN -> 두 테이블 중 오른/왼쪽에 NULL데이터가 발생할때, NULL의 기준이되는 테이블을 가리키자
-- FULL OUTER JOIN -> 양쪽 테이블에 모두 OUTER JOIN을 적용한다
SELECT
	e.ename, e.job, e.sal, d.dname 
FROM emp e
	RIGHT OUTER JOIN dept d ON e.deptno=d.deptno;

SELECT 
	e.ename, e.job, e.sal, d.dname 
FROM emp e, dept d
WHERE e.deptno(+)=d.deptno;

SELECT 
	e.ename, e.empno, e.job, e.deptno
FROM emp e
	FULL OUTER JOIN dept d ON e.deptno=d.deptno;

--INSERT INTO emp(empno, ename, job, sal) 
--VALUES (2222, 'MAX', 'JANITOR', '800');
--DELETE FROM emp WHERE empno=2222;

--================================================================================

-- [종합문제]
-- [문제1] emp테이블에서 모든 사원에 대한 e이름, e부서번호, d부서명을 출력하는 문장을 작성하세요. (부서번호순으로 오름차순 정렬하라.)
SELECT
	e.ename name, e.deptno, d.dname
FROM emp e
	JOIN dept d ON e.deptno=d.deptno;

-- [문제2] emp테이블에서 dNEW YORK에서 근무하고 있는 e사원에 대하여 e이름, e업무, e급여, d부서명을 출력하는 SELECT문을 작성하세요.
SELECT 
	e.ename, e.job, e.sal, d.dname
FROM emp e
	JOIN dept d ON e.deptno=d.deptno
	WHERE d.loc IN 'NEW YORK';

-- [문제3] emp테이블에서 e보너스를 받는 사원에 대하여 e이름, d부서명, d위치를 출력하는 SELECT문을 작성하세요.
SELECT 
	e.ename, d.dname, d.loc
FROM emp e
	JOIN dept d ON e.deptno=d.deptno 
	WHERE e.comm>0;

-- [문제4] emp테이블에서 e이름 중 L자가 있는 사원에 대해 e이름, e업무, d부서명, d위치를 출력하는 문장을 작성하세요.
SELECT 	
	e.ename, e.job, d.dname, d.loc
FROM emp e
	JOIN dept d ON e.deptno=d.deptno
	WHERE e.ename LIKE '%L%';

-- [문제5] 관리자가 없는 King을 포함하여 모든 사원을 출력
SELECT 
	e.ename employee, e.empno, m.ename, e.mgr
FROM emp e
	LEFT JOIN emp m ON e.mgr=m.empno;



SELECT * FROM dept;
SELECT * FROM salgrade;
SELECT * FROM tab;
SELECT * FROM emp;
SELECT * FROM user_sequences;
SELECT * FROM employee;