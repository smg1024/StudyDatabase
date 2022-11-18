select * from emp;

-- 테이블 관리
-- emp 테이블에 문자 15자리를 저장할 수 있는 tel칼럼를 추가하라
-- not null : 반드시 데이터가 있어야 함
-- null : 데이터가 없어도 칼럼가 생성됨
-- 칼럼명 데이터타입

-- ADD -> 칼럼 추가
-- emp 테이블에 문자 15자리를 저장할 수 있는 tel칼럼를 추가하라
-- not null : 반드시 데이터가 있어야 함
-- null -> 데이터가 없어도 칼럼가 생성됨
alter table emp add (tel varchar2(15));

-- MODIFY -> 칼럼 수정
alter table emp modify (ename varchar2(20));	-- 이제 한글 4글자까지 입력 가능하다
insert into emp(empno, ename) values(1234, '세종대왕');
-- 기존 데이터가 새로 수정한 조건에 만족하지 않으면 수정하지 않는다
alter table emp modify (job varchar2(5)); -- ERROR : 5글자보다 많은 job이 존재함

-- DROP -> 칼럼 삭제
alter table emp drop column mgr;

--======================================================================

-- 테이블 생성
-- 필드명, 테이터타입(자리수), NULL허용여부, 중복여부
-- EX) 회원정보테이블 : member
-- 번호 : no, number(5), not null, primary key(같은 값이 있으면 안됨)
-- 이름 : username, varchar2(20), not null
-- 연락처 : phone, varchar2(15), not null
-- 이메일 : email, varchar2(50), null
-- 주소 : addr, varchar2(300), null
-- 등록일 : regdate, date, not null, sysdate
create table member(
	no number(5) primary key,
	username varchar2(20) not null,
	phone varchar2(15) not null,
	email varchar2(50),
	addr varchar2(300),
	regdate date default sysdate		-- 값을 설정하지 않으면 자동으로 sysdate로 생성
);

-- SEQUENCE -> 자동으로 규칙적인 테이터를 생성해주는 객체
-- 한번 생성된 정보는 다시 생성하지 않음
create sequence mem_seq
	start with 1
	increment by 1;

-- [문제] 5부터 3씩 증가하는 시퀀스 생서하라
create sequence test_seq
	start with 5
	increment by 3;

-- USER_SEQUENCES 테이블 조회해서 시퀀스 확인하기
select * from USER_SEQUENCES;

-- SEQUENCE.NEXTVAL -> 새로운 시퀀스 번호 생성
-- SEQUENCE.CURRVAL -> 마지막으로 사용한 시퀀스 번호 리턴
select test_seq.nextval from dual;	-- 첫 시행에서 5를 리턴, 이후 다시 5를 생성하지 않음
select test_seq.currval from dual;	-- 마지막으로 생성했던 시퀀스를 리턴
select test_seq.nextval, test_seq.currval from dual;	-- 아래와 결과가 같다
select test_seq.currval, test_seq.nextval from dual;	-- 같은 쿼리문에 있으면 currval은 마지막 사용값 리턴

-- member 테이블에 레코드 추가하기
insert into member(no, username, phone)
values(mem_seq.nextval, 'POBY', '010-9701-5637');
insert into member(no, username, phone)
values(mem_seq.nextval, 'ALEX', '010-1234-1234');

-- addr 칼럼 삭제하기
alter table member drop column addr;

-- DROP -> 시퀀스 삭제
drop sequence test_seq;

-- 테이블 지우기
drop table member;
drop table emp2;
drop table emp3;
drop table emp4;
drop table emp5;

show recyclebin;

select * from tab;


select * from member;

select empno, ename, tel, job from emp;