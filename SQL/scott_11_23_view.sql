— view 테이블 : 가상테이블
— view 생성 
— CREATE OR REPLACE : 뷰가 존재하지 않으면 새로 생성하고
—                     이미 뷰가 존재하면 새로 


CREATE OR REPLACE VIEW emp_view
AS SELECT empno, ename, job, sal FROM emp;

SELECT * FROM emp_view;

-- view를 이용한 데이터 추가
INSERT INTO emp_view(empno, ename, job, sal)
VALUES (5555, 'AAAA', 'OFFICE', 3500);

-- view를 이용한 데이터 수정
UPDATE emp_view SET job='ACCOUNT' WHERE empno=7369;

-- view를 이용한 데이터 삭제
DELETE FROM emp_view WHERE job='MANAGER';

-- view 삭제
DROP VIEW emp_view;

-- view에서 선택만 가능하도록 생성하기 read only
-- emp 테이블에서 사번, 사원명, 업무, 입사일, 급여를 이용하여 읽기 전용 view를 생성하라
CREATE OR REPLACE VIEW emp_view_read
AS SELECT empno, ename, job, hiredate, sal FROM emp
WITH READ ONLY;

SELECT * FROM emp_view_read;

INSERT INTO emp_view_read(empno, ename, job, hiredate, sal)
VALUES (3333, 'BBBB', 'PLANNING', sysdate, 4000);

-- 업무별 급여의 합계를 view를 이용하여 구하라
SELECT job, sum(sal) FROM emp_view GROUP BY job;
SELECT job, sum(sal) FROM emp GROUP BY job;

-- 사번, 사원명, 업무, 부서코드, 부서명을 이용하여 view 생성 JOIN 사용
CREATE VIEW emp_dept
AS SELECT e.empno, e.ename, e.job, e.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno=d.deptno;


-- with check option
CREATE VIEW emp_check
AS SELECT empno, ename, sal, deptno FROM emp
WHERE deptno=20 WITH CHECK OPTION;

INSERT INTO emp_check(empno, ename, sal, deptno)
VALUES (2222, 'CCCC', 4200, 20);

-- view 확인하기
SELECT * FROM user_views;

-- view 삭제하기
DROP VIEW emp_check;
DROP VIEW emp_view;
DROP VIEW emp_dept;
DROP VIEW emp_view_read;


select username from dba_users;


SELECT * FROM dba_tablespaces;




SELECT * FROM emp_check;
SELECT * FROM emp_dept;
SELECT * FROM tab;
SELECT * FROM emp;
SELECT * FROM user_constraints;