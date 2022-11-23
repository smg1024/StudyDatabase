-- [과제]
-- 작가테이블에 작가 최소 3명 등록
-- 출판사테이블에 출판사 최소 3곳 등록
-- 책테이블에 책을 최소 6권 등록
-- 조건 :
-- 1. 테이블 2개로 조인문제 만들어 풀기
-- 2. 테이블 3개로 조인문제 만들어 풀기

-- 작가 등록
INSERT INTO author_tbl
VALUES (auth_seq.nextval, 'Bernard Werber', '@werbernard', 'Les Fourmis', TO_DATE('1991','yyyy'), SYSDATE);
INSERT INTO author_tbl
VALUES (auth_seq.nextval, 'Haruki Murakami', 'vintageanchorpublicity@randomhouse.com', 'Hear the Wind Sing', TO_DATE('1979','yyyy'), SYSDATE);
INSERT INTO author_tbl
VALUES (auth_seq.nextval, 'Dan Brown', '@authordanbrown', 'Digital Fortress', TO_DATE('1998','yyyy'), SYSDATE);

-- 출판사 등록
INSERT INTO pub_tbl
VALUES (pub_seq.nextval, '1-800-733-3000', 'consumerservices@penguinrandomhouse.com', 'Markus Dohle', 'Penguin Random House', SYSDATE);
INSERT INTO pub_tbl
VALUES (pub_seq.nextval, '1-800-242-7737', 'hello@harpercollins.com', 'Brian Murray', 'HarperCollins', SYSDATE);
INSERT INTO pub_tbl
VALUES (pub_seq.nextval, '1-800-223-2336', 'SSPublicity@simonandschuster.com', 'Jonathan Karp', 'Simon & Schuster', SYSDATE);

-- 책 6권 등록
INSERT INTO book_tbl
VALUES (9780552141123, 'Les Fourmis', 14.14, 'novel', TO_DATE('1991/2/2', 'yyyy/mm/dd'), 306, 10, 2, SYSDATE);
INSERT INTO book_tbl
VALUES (9782286004231, 'Les Thanatonautes', 16.84, 'novel', TO_DATE('1994/1/1', 'yyyy/mm/dd'), 589, 10, 2, SYSDATE);
INSERT INTO book_tbl
VALUES (9784062035156, 'Norwegian Wood', 34.17, 'literary fiction', TO_DATE('1987/9/1', 'yyyy/mm/dd'), 494, 20, 1, SYSDATE);
INSERT INTO book_tbl
VALUES (9780099494096, 'Kafka on the Shore', 14.85, 'magical realism', TO_DATE('2002/9/12', 'yyyy/mm/dd'), 505, 20, 1, SYSDATE);
INSERT INTO book_tbl
VALUES (9780385504201, 'The Da Vinci Code', 15.47, 'detective fiction', TO_DATE('2003/4/1', 'yyyy/mm/dd'), 689, 30, 3, SYSDATE);
INSERT INTO book_tbl
VALUES (9780385537858, 'Inferno', 26.90, 'conspiracy fiction', TO_DATE('2013/5/14', 'yyyy/mm/dd'), 624, 30, 3, SYSDATE);


-- [문제1] 테이블 2개로 조인문제 만들어 풀기
SELECT
	b.title, a.author, b.genre, a.author_email, b.price Ω
FROM book_tbl b
	JOIN author_tbl a ON b.author_code=a.author_code;

-- [문제2] 테이블 3개로 조인문제 만들어 풀기
SELECT 
	b.title, b.genre, a.author, a.author_email, p.publisher, p.pub_email, b.price
FROM book_tbl b
	JOIN author_tbl a ON b.author_code=a.author_code
	JOIN pub_tbl p ON b.pub_code=p.pub_code;



SELECT * FROM book_tbl;
SELECT * FROM pub_tbl;
SELECT * FROM author_tbl;
SELECT * FROM user_sequences;
