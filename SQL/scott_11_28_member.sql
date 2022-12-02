INSERT INTO member_tbl(username, password, name, tel)
VALUES ('smg1024', 'dork!024', 'Sangmin Kim', '010-1234-5678');

INSERT INTO member_tbl(username, password, name, tel)
VALUES ('poby', '981024', 'Poby', '010-9876-5432');

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO board_tbl(postno, subject, content, username, ipAddr)
VALUES (board_seq.nextval,?,?,?,?);

DROP SEQUENCE board_seq;

SELECT postno, subject, username, hitcount, to_char(regdate, 'mm-dd HH:MI')
FROM board_tbl ORDER BY postno DESC;

UPDATE board_tbl SET subject=?, content=? WHERE postno=?;

DELETE FROM board_tbl WHERE postno=?;

SELECT username, name FROM member_tbl WHERE username=? AND password=?;

SELECT * FROM user_sequences;
SELECT * FROM member_tbl;
SELECT * FROM board_tbl;
SELECT * FROM user_constraints WHERE table_name='BOARD_TBL';