/* Author Table */
CREATE TABLE author_tbl (
	author_code NUMBER(5) NOT NULL, /* Code */
	author VARCHAR(30) NOT NULL, /* Name */
	author_email VARCHAR(50), /* Email */
	debut VARCHAR(100), /* Debut Book */
	debut_year DATE, /* Debut Year */
	reg_date DATE DEFAULT SYSDATE
 /* Register Date */
);

ALTER TABLE author_tbl
	ADD
		CONSTRAINT PK_author_tbl
		PRIMARY KEY (
			author_code
		);

/* Book Table */
CREATE TABLE book_tbl (
	isbn NUMBER(13) NOT NULL, /* ISBN */
	title VARCHAR2(100) NOT NULL, /* Title */
	price NUMBER(10,2) NOT NULL, /* Price */
	genre VARCHAR2(20), /* Genre */
	pub_date DATE, /* Published Date */
	pages NUMBER(4), /* Total Pages */
	pub_code2 NUMBER(5), /* Publisher Code2 */
	author_code2 NUMBER(5), /* Code */
	reg_date DATE DEFAULT SYSDATE /* Register Date */
);

ALTER TABLE book_tbl
	ADD
		CONSTRAINT PK_book_tbl
		PRIMARY KEY (
			isbn
		);

/* Publisher Table */
CREATE TABLE pub_tbl (
	pub_code NUMBER(5) NOT NULL, /* Publisher Code */
	pub_tel VARCHAR2(15), /* Publisher Tel. */
	pub_email VARCHAR2(50), /* Publisher Email */
	pub_rep VARCHAR2(30), /* Representative of Publisher */
	publisher VARCHAR2(30) NOT NULL, /* Name */
	reg_date DATE DEFAULT SYSDATE /* Register Date */
);

ALTER TABLE pub_tbl
	ADD
		CONSTRAINT PK_pub_tbl
		PRIMARY KEY (
			pub_code
		);

ALTER TABLE book_tbl
	ADD
		CONSTRAINT FK_pub_tbl_TO_book_tbl
		FOREIGN KEY (
			pub_code2
		)
		REFERENCES pub_tbl (
			pub_code
		);

ALTER TABLE book_tbl
	ADD
		CONSTRAINT FK_author_tbl_TO_book_tbl
		FOREIGN KEY (
			author_code2
		)
		REFERENCES author_tbl (
			author_code
		);