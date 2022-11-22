SELECT * FROM emp;


-- 내장 함수

-- MERGE -> 레코드가 존재하면 UPDATE, 없으면 INSERT 실행
CREATE TABLE emp2	-- 테이블 복사
AS SELECT * FROM emp WHERE deptno=10;

MERGE INTO emp2 a
USING emp b ON (a.empno=b.empno)	-- 조건에 반드시 괄호()포함
WHEN MATCHED THEN
	UPDATE SET sal = sal+2000	-- target table의 칼럼
WHEN NOT MATCHED THEN 
	INSERT VALUES (b.empno, b.ename, b.job, b.mgr, b.hiredate, b.sal, b.comm, b.deptno);

-- CASE -> DECODE 함수와 비슷하다
-- 1. Simple CASE
SELECT empno, ename, deptno,
	CASE deptno 
		WHEN 10 THEN 'PLANNING'
		WHEN 20 THEN 'HR'
		WHEN 30 THEN 'HQ'
		ELSE 'ACCOUNTING'
	END AS "DEPTNAME"
FROM emp;

-- 2. Searched CASE
SELECT ename,
	CASE 	-- 여기에 칼럼명이 붙으면 칼럼명 LIKE 생략 가능
		WHEN ename LIKE 'AD%' THEN '10%'
		WHEN ename LIKE 'S%' THEN '20%'
		WHEN ename LIKE '%B%' THEN '30%'
		ELSE '40%'
	END AS R
FROM emp;

-- NULLIF(a, b) -> a와 b가 같으면 NULL, 다르면 a를 리턴
SELECT NULLIF (ename, 'SCOTT') FROM emp;
SELECT NULLIF (123, 456) FROM dual;

SELECT
	CASE 
		WHEN ename='ADAMS' THEN NULL
		ELSE ename
	END
FROM emp;

-- COALESCE(a, b, c,...) -> a가 NULL이 아니면 a를, NULL이면 COALESCE(b, c,...)를 리턴
-- NVL(a, b)와 비슷함
SELECT comm, COALESCE(comm, 0) from emp;
SELECT comm,
	CASE 
		WHEN comm is NOT NULL THEN 100
		ELSE COALESCE(comm, 50)
	END AS res
FROM emp;
	
	




SELECT * FROM emp2;