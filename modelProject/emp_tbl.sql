/* New Table */
CREATE TABLE dept_tbl (
	dept VARCHAR2(20) NOT NULL, /* 부서명 */
	deptno NUMBER(5) NOT NULL, /* 부서번호 */
	numberofppl NUMBER(3) /* 부서인원 */
);

ALTER TABLE dept_tbl
	ADD
		CONSTRAINT PK_dept_tbl
		PRIMARY KEY (
			dept
		);

/* Employee List */
CREATE TABLE emp_tbl (
	empno NUMBER(5) NOT NULL, /* 사번 */
	ename VARCHAR2(20) NOT NULL, /* 이름 */
	dept VARCHAR2(20), /* 부서명 */
	pos VARCHAR2(15), /* 직급 */
	gender VARCHAR2(10) NOT NULL, /* 성별 */
	startwork DATE DEFAULT SYSDATE, /* 입사일 */
	endwork DATE, /* 퇴사일 */
	phone VARCHAR2(15) /* 전화번호 */
);

ALTER TABLE emp_tbl
	ADD
		CONSTRAINT PK_emp_tbl
		PRIMARY KEY (
			empno
		);

/* New Table2 */
CREATE TABLE pos_tbl (
	pos VARCHAR2(15) NOT NULL /* 직급 */
);

ALTER TABLE pos_tbl
	ADD
		CONSTRAINT PK_pos_tbl
		PRIMARY KEY (
			pos
		);

ALTER TABLE emp_tbl
	ADD
		CONSTRAINT FK_dept_tbl_TO_emp_tbl
		FOREIGN KEY (
			dept
		)
		REFERENCES dept_tbl (
			dept
		);

ALTER TABLE emp_tbl
	ADD
		CONSTRAINT FK_pos_tbl_TO_emp_tbl
		FOREIGN KEY (
			pos
		)
		REFERENCES pos_tbl (
			pos
		);