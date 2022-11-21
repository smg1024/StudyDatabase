CREATE TABLE book_tbl(
	isbn NUMBER(13) PRIMARY KEY,
	title VARCHAR2(100) NOT NULL,
	price NUMBER(10,2) NOT NULL,
	genre VARCHAR2(20) NULL,
	pub_date DATE,
	pages NUMBER(4),
	author_code NUMBER(5) NOT NULL,
	pub_code NUMBER(5) NOT NULL,
	reg_date DATE DEFAULT SYSDATE
);

CREATE TABLE pub_tbl(
	pub_code NUMBER(5) PRIMARY KEY,
	pub_tel NUMBER(11),
	pub_email VARCHAR2(50),
	pub_rep VARCHAR2(30),
	publisher VARCHAR2(30) NOT NULL,
	reg_date DATE DEFAULT SYSDATE
);

CREATE TABLE author_tbl(
	author_code NUMBER(5) PRIMARY KEY,
	author VARCHAR2(30) NOT NULL,
	auth_email VARCHAR2(50),
	debut VARCHAR2(100),
	debut_year DATE,
	reg_date DATE DEFAULT SYSDATE
);

SELECT * FROM book_tbl;
SELECT * FROM pub_tbl;
SELECT * FROM author_tbl;



CREATE SEQUENCE pub_seq
	START WITH 1
	INCREMENT BY 1;
CREATE SEQUENCE auth_seq
	START WITH 10
	INCREMENT BY 10;

SELECT * FROM user_sequences;

--11.21.------------------------------------------------------------------------------------

-- book_tbl 고유번호, pub_tbl의 출판사코드, author_tbl의 작가코드를 primary key 또는 unique로 설정
ALTER TABLE book_tbl ADD CONSTRAINT book_pk_isbn PRIMARY KEY(isbn);
ALTER TABLE pub_tbl ADD CONSTRAINT pub_pk_pubcode PRIMARY KEY(pub_code);
ALTER TABLE author_tbl ADD CONSTRAINT author_pk_authorcode PRIMARY KEY(author_code);

-- book_tbl의 pub_code와 author_code가 pub_tbl의 출판사코드, author_tbl의 작가코드를 참조
ALTER TABLE book_tbl ADD CONSTRAINT book_fk_pubcode
FOREIGN KEY(pub_code) REFERENCES pub_tbl(pub_code);
ALTER TABLE book_tbl ADD CONSTRAINT book_fk_authorcode
FOREIGN KEY(author_code) REFERENCES author_tbl(author_code);

DROP TABLE book_tbl;
DROP TABLE pub_tbl;
DROP TABLE author_tbl;

SELECT * from tab;