
-- OUT PARAMETER -> 프로시져에서 처리결과를 외부로 내보낸다
-- [문제] 사원번호를 입력받아 사원명과 급여를 내보내는 프로시저를 작성하라
CREATE OR REPLACE PROCEDURE emp_find(
	i_empno IN emp.empno%TYPE,
	o_ename OUT emp.ename%TYPE,
	o_sal OUT emp.sal%TYPE)
IS
BEGIN 
	SELECT ename, sal INTO o_ename, o_sal FROM emp WHERE empno=i_empno;
END;

-- 변수 선언하기
-- 사원명을 받을 변수
VARIABLE f_sal NUMBER;
-- 급여를 받을 변수
VARIABLE f_ename VARCHAR2(10);

--@set f_sal = NUMBER;
--DECLARE f_ename VARCHAR2(10);

CALL emp_find(7788, :f_ename, :f_sal);

SELECT * FROM department;
SELECT * FROM POSITION;

-------------------------------------------------------------------------------------
-- 프로시져 생성하기

CREATE OR REPLACE PROCEDURE employee_insert(
	i_username IN employee.username%TYPE,
	i_password IN employee.password%TYPE,
	i_tel IN employee.tel%TYPE,
	i_dept_code IN employee.dept_code%TYPE,
	i_pos_code IN employee.pos_code%TYPE,
	o_result OUT NUMBER)	-- insert문 처리결과 내보내기
IS 
BEGIN 
	o_result := 1;	-- o_result변수에 1대입
	INSERT INTO employee(empno, username, password, tel, dept_code, pos_code)
	VALUES (emp_seq.nextval, i_username, i_password, i_tel, i_dept_code, i_pos_code);
	-- 예외처리
	EXCEPTION
		WHEN OTHERS THEN
			o_result := 0;	-- 예외발생 시 데이터추가 실패
END;

DROP PROCEDURE employee_insert;

VARIABLE res NUMBER;

CALL employee_insert('JOHN', '1234', '010-8888-9999', 1, 2, :res);

-------------------------------------------------------------------------------------

-- 모든 데이터 선택 (사번, 이름, 연락처, 성별, 입사일)
SELECT empno, username, tel, startwork FROM employee;

CREATE OR REPLACE PROCEDURE employee_select_all(o_result OUT sys_refcursor)
IS 
BEGIN 
	OPEN o_result FOR 
	SELECT empno, username, tel, gender, startwork FROM employee ORDER BY empno;
END;

-----------------------------------------------------------------------------------------

-- 이름을 입력받아 해당사원을 선택하는 프로시저 만들기
CREATE OR REPLACE PROCEDURE employee_search(
	name_search IN employee.username%TYPE,
	r_employee OUT sys_refcursor)
IS 
BEGIN 
	OPEN r_employee FOR 
	SELECT empno, username, tel, startwork, dept_name, pos_name
	FROM employee
		JOIN department ON employee.dept_code=department.dept_code
		JOIN position ON employee.pos_code=position.pos_code
		WHERE username LIKE '%'||name_search||'%';	-- A가 이름에 포함된 사원들
END;

--------------------------------------------------------------------------------------------

-- 사원번호에 해당하는 사원의 비밀번호, 연락처, 퇴사일 수정하는 프로시저 만들기

CREATE OR REPLACE PROCEDURE employee_edit(
	i_empno IN employee.empno%TYPE,
	i_password IN employee.password%TYPE,
	i_tel IN employee.tel%TYPE,
	i_endwork IN VARCHAR2,	-- yyyymmdd 형식으로 받기
	r_data OUT NUMBER)
IS 
BEGIN 
	r_data:=1;
	UPDATE employee SET
		password=i_password, 
		tel=i_tel, 
		endwork=to_date(i_endwork, 'yyyymmdd')
	WHERE empno=i_empno;
	EXCEPTION
		WHEN OTHERS THEN
			r_data:=0;
END;

--------------------------------------------------------------------------------------------

-- 사원번호를 입력받아 해당 사원 삭제하는 프로시저 만들기

CREATE OR REPLACE PROCEDURE employee_del(
	i_empno IN NUMBER,
	o_result OUT NUMBER)
IS 
BEGIN 
	o_result:=1;
	DELETE FROM employee
	WHERE empno=i_empno;
	EXCEPTION
		WHEN OTHERS THEN
			o_result:=0;
END;

INSERT INTO employee(empno, username, password, DEPT_CODE, POS_CODE)
VALUES (9999, 'POBY', '1234', 1, 2);
DELETE FROM employee WHERE username='김상민';


SELECT * FROM employee;
SELECT * FROM user_source;