SELECT * FROM emp;

-- 제약조건
-- CONSTRAINT
SELECT * FROM tab;

-- 현제 계정에 설정된 제약조건 확인하기
SELECT * FROM user_constraints;

-- ename을 not null 제약조건 걸기
ALTER TABLE emp MODIFY(ename CONSTRAINT emp_nn_ename NOT NULL);

-- UNIQUE() -> 데이터의 유일성 보장 (중복 불허)
ALTER TABLE emp
ADD CONSTRAINT emp_uniq_deptno UNIQUE(deptno);	-- ERROR : deptno는 이미 중복되는 값이 존재함
-- 기존의 데이터를 포용하는 제약조건으로 설정해야한다
SELECT * FROM dept;
ALTER TABLE dept
ADD CONSTRAINT dept_uniq_deptno UNIQUE(deptno);

INSERT INTO dept(deptno, dname, loc) VALUES (40, 'PLANNING', 'WASHINGTON');	-- ERROR : dept_uniq_deptno
INSERT INTO dept(deptno, dname, loc) VALUES (50, 'PLANNING', 'WASHINGTON');

-- 제약조건 삭제하기
ALTER TABLE dept
DROP CONSTRAINT dept_uniq_deptno;

-- PRIMARY KEY() 설정하기
ALTER TABLE dept
ADD CONSTRAINT dept_pk_deptno PRIMARY KEY(deptno);

-- book_tbl 고유번호, pub_tbl의 출판사코드, author_tbl의 작가코드를 primary key 또는 unique로 설정
ALTER TABLE book_tbl ADD CONSTRAINT book_pk_isbn PRIMARY KEY(isbn);
ALTER TABLE pub_tbl ADD CONSTRAINT pub_pk_pubcode PRIMARY KEY(pub_code);
ALTER TABLE author_tbl ADD CONSTRAINT author_pk_authorcode PRIMARY KEY(author_code);

-- CHECK() -> 데이터값 범위 제한
-- emp테이블의 sal값을 800~6000 사이로 정하라
ALTER TABLE emp ADD CONSTRAINT emp_ck_sal CHECK(sal>=800 AND sal<=6000);
-- emp테이블의 comm값을 0, 300, 500, 1400, 1800, 2200으로만 설정하라
UPDATE emp SET comm=0 WHERE comm IS NULL;
ALTER TABLE emp ADD CONSTRAINT emp_ck_comm CHECK(comm IN (0, 300, 500, 1400, 1800, 2200));

-- DEFAULT -> 필드 기본값 지정하기, 데이터를 입력하지 않았을 때 기본값을 입력한다
ALTER TABLE emp MODIFY(hiredate DATE DEFAULT SYSDATE);

-- FOREIGN KEY() -> 다른 테이블의 PRIMARY KEY를 참조하는 필드
-- FOFEIGN KEY와 PRIMARY KEY는 데이터형이 일치해야하고, 외래키에 의해 참조되고 있는 기본키는 삭제할 수 없다
-- ON DELETE CASCADE를 이용하면 기본키를 삭제할때, 해당 기본키를 참조하고있는 외래키 레코드도 같이 삭제한다
ALTER TABLE emp ADD CONSTRAINT emp_fk_deptno
FOREIGN KEY(deptno) REFERENCES dept(deptno) 

ALTER TABLE emp DROP CONSTRAINT emp_fk_deptno;

ALTER TABLE emp ADD CONSTRAINT emp_fk_deptno
FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE CASCADE;
-- DELETE_RULE = NO ACTION : 참조되는 데이터가 있을때 기본키 삭제 불가
-- DELETE_RULE = CASCADE : 기본키 삭제 시 참조되는 데이터까지 삭제





SELECT * FROM author_tbl;
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM user_constraints;