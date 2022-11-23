-- PL/SQL을 이용한 프로시져 만들기
-- 선택한 데이터가 1개일때 처리하는 프로시져
-- 사원번호, 이름, 급여를 선택하는 프로시져 만들기
CREATE OR REPLACE PROCEDURE emp_info(p_empno IN emp.empno%TYPE)
IS 
	-- 변수 선언
	s_empno emp.empno%TYPE;
	s_ename emp.ename%TYPE;
	s_sal emp.sal%TYPE;
BEGIN 
	-- 실행문
	SELECT empno, ename, sal INTO s_empno, s_ename, s_sal 
	FROM emp WHERE empno=p_empno;
	-- 출력문
	dbms_output.put_line('Employee Number -> '||s_empno);
	dbms_output.put_line('Employee Name -> '||s_ename);
	dbms_output.put_line('Employee Salary -> '||s_sal);
END;

BEGIN
	dbms_output.put_line('Hello, PL/SQL');
END;


-- 프로시져 확인하기
SELECT * FROM user_source;

-- 실행결과를 출력하기 : set
SET serveroutput ON;	-- DBeaver에서는 Output콘솔창을 띄우면 된다. 사실상 불필요
CALL emp_info(7788);

--------------------------------------------------------------------------

-- 사원번호를 입력받아 사원번호, 사원명, 담당업무, 입사일, 급여를 선택하여 출력하는 프로시져 만들기
CREATE OR REPLACE PROCEDURE emp_list(i_empno IN emp.empno%TYPE)
IS 
	-- 변수 선언 : %rowtype 테이블 내의 모든 필드의 변수와 데이터형을 한번에 선언
	r_emp emp%rowtype;
BEGIN
	SELECT empno, ename, job, hiredate, sal
	INTO r_emp.empno, r_emp.ename, r_emp.job, r_emp.hiredate, r_emp.sal
	FROM emp WHERE empno=i_empno;
	dbms_output.put_line(r_emp.empno || ', ' || r_emp.ename || ', ' || r_emp.job || ', ' || r_emp.hiredate || ', ' || r_emp.sal);
END;

SELECT * FROM user_source;

CALL emp_list(7839);

-- 사원 등록하는 프로시져 만들기
-- 사원번호, 이름, 부서번호를 입력받아 사원 등록하기
CREATE OR REPLACE PROCEDURE emp_insert(i_empno emp.empno%TYPE, i_ename emp.ename%TYPE, i_deptno emp.deptno%TYPE)
IS 
BEGIN 
	INSERT INTO emp(empno, ename, deptno) VALUES (i_empno, i_ename, i_deptno);
	dbms_output.put_line(i_ename || '사원이 등록되었습니다.');
END;

CALL emp_insert(5656, 'ZZZZ', 40);
DELETE FROM emp WHERE empno=5656;


