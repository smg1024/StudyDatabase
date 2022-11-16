select * from emp order by ename desc;

-- 연습문제 1번
select empno num, ename name, sal salary from emp;

-- 연습문제 2번
select empno, ename, sal, job from emp order by ename asc;

-- 연습문제 3번
select * from emp where hiredate like '___05%';
-- 날짜 형식은 YY/MM/dd

-- 연습문제 4번
select * from emp where ename like'%A%' or sal>=3000;

-- 연습문제 5번
select * from emp where job='SALESMAN' or job='MANAGER';
select * from emp where job in ('SALESMAN', 'MANAGER');

-- 연습문제 6번
select * from emp where sal>=3000 and nvl(comm, 0)=0;

-- 연습문제 7번
select * from emp where sal between 2000 and 4000 or nvl(comm, 0)>0 order by sal desc;

-- 연습문제 8번
select * from tab;

-- 연습문제 9번
SELECT empno, ename, job, hiredate, sal, deptno from emp
WHERE deptno in (10, 20)
order by job asc, sal desc;


-- 리터럴
-- "a" || "B"
-- printf 개념과 비슷하다
select '내 이름은 ' || ename || '입니다.' as name from emp;
select ename || ': 1 YEAR SALARY = ' || sal as salary from emp where sal>=5000;


-- DISTINCT : 중복행 제거
-- 특정 필드의 값 중에 중복되는 값을 하나로 표현한다
select distinct job from emp;


-- 내장함수 - 숫자

-- ABS(n) -> 절대
select abs(-90) from dual;

-- CEIL(n) -> 올림
select ceil(10.1), ceil(-12.1) from dual;

-- FLOOR(n) -> 내림
select floor(10.9), floor(-12.9) from dual;

-- MOD(m,n) -> m을 n으로 나눈 나머지
select mod(11,4) from dual;

-- ROUND(m,n) -> m을 소수점 n번째 자리에서 반올림
select round(25.3829,1), round(25.3829,-1) from dual;

-- TRUNC(m,n) -> m을 소수점 n번째 자리에서 반내림
select trunc(7.558,2), trunc(5234.26,-2) from dual;

-- MOD() -> 나머지 값을 돌려줌
select sal, mod(sal,30) from emp where deptno=10;


-- 내장함수 - 문자열

-- CONCAT(c1,c2) -> 문자열 연결하기
select empno, concat(ename, '님') as ename from emp;

-- INITCAP() -> 각 단어의 첫번째 문자를 대문자로, 나머지는 소문자로 바꿔준다
select initcap('orA cle tesT') from dual;

-- LOWER() -> 모든 영문자를 소문자로
select ename, job, lower(ename), lower(job) from emp;

-- UPPER() -> 모든 영문자를 대문자로
select upper('oracle function test') from dual;

-- LPAD(c1, n, c2) -> 왼쪽에 남는 자리를 특정 문자로 채워줌, 반환되는 문자열의 크기 n, c1으로 먼저 채우고 나머지를 c2로 채운다
-- RPAD() -> 오른쪽에 남는 자리를 특정 문자로 채워줌
select lpad(ename, 6, '*'), rpad(ename, 6, '%') from emp;

--  SUBSTR(c, n, m) -> 문자열에서 일부 문자 얻어오기, 시작위치 n, 개수 m
select substr('hong gildong', 3, 5) from dual;
select substr('hong gildong', -5, 3) from dual;

-- LENGTH() : 문자 수 구하기
select ename, length(ename) from emp;


-- [문제] 이름을 글자길이의 50%만 출력하고 나머지는 '*'로 표시하라
select length(ename)/2 from emp;
select ename, RPAD(SUBSTR(ename, 1, CEIL(LENGTH(ename)/2)), LENGTH(ename), '*') name1,
RPAD(SUBSTR(ename, 1, FLOOR(LENGTH(ename)/2)), LENGTH(ename), '*') name2 from emp;
select rpad(substr(ename, 1, length(ename)/2), length(ename), '*') coveredname from emp;


-- REPLACE(char, str1, str2) -> 특정 문자를 다른 문자로 변경하기, char의 문자 중 str1을 str2로 변경한다
select ename, replace(ename, 'A','에이') from emp;

-- INSTR(str, char, [m, n]) -> 문자열이 포함되어있는지 확인하고 해당 위치를 리턴하기
-- str의 문자 중 char의 위치(왼쪽부터), m번째 문자부터 탐색, n번째 해당위치를 리턴, 못 찾으면 0 리턴
select ename, instr(ename, 'A') from emp;
select ename, instr(ename, 'A', 2) from emp;	-- 2번째 문자열부터 'A' 탐색
select ename, instr(ename, 'T', 2, 2) from emp;	-- 2번째 문자열부터 'A' 탐색하고 두번째 'A'에 해당하는 위치


-- [문제] 이메일을 이용하여 아이디와 도메인을 분리하라
select 'smg1024@naver.com' email,
substr('smg1024@naver.com', 1, instr('smg1024@naver.com', '@')-1) username,
substr('smg1024@naver.com', length('smg1024@naver.com')-instr('smg1024@naver.com', '@')) domain
from dual;


-- TRIM(char FROM str) -> 양쪽 사이드의 특정 문자 제거
-- LTRIM(str, char), RTRIM(str, char) -> 좌,우 사이드의 특정 문자 제거
select sal, trim(0 from sal) from emp; -- 양쪽에 있는 '0' 제거
select ename, ltrim(ename, 'S'), rtrim(ename, 'S') from emp;

 
-- General Function
-- DECODE(value, if1, then1, if2, then2,...) -> 데이터들의 값을 다른 값으로 바꾸기
-- value값이 if1일 경우 then1으로, if2일 경우 then2로,...
-- [문제] 10:기획부, 20:총괄, 30:인사부
select ename, deptno, decode(deptno, 10, '기획부', 20, '총괄부', 30, '인사부') 부서명 from emp;


-- Date Functions
-- sysdate -> 시스템 현재 날짜/시간
select sysdate from dual;

-- TO_CHAR() -> 날짜를 문자로 변환
select sysdate, to_char(sysdate, 'MON') from dual;
select to_char(sysdate, 'yyyy-mm') from dual;
select to_char(sysdate, 'hh24:mi') from dual;
select hiredate, to_char(hiredate, 'yyyy-mm-dd hh:mi') from emp;
select DBTIMEZONE, SESSIONTIMEZONE FROM DUAL;
ALTER DATABASE SET TIME_ZONE = '+09:00';


-- LAST_DAY() -> 그 달의 마지막 날
select sysdate, last_day(sysdate) from dual;
select ename, hiredate, last_day(hiredate) from emp;

-- ADD_MONTHS() -> 월을 더하기
select add_months(sysdate, 30) from dual;
-- [문제] 각 사원의 입사 15개월 후
select ename, hiredate, add_months(hiredate, 15) from emp;
select add_months('2020/10/10', 13) from dual;
select add_months('20/10/10', 13) from dual;
select to_char(add_months(to_date('2020/10','yyyy/mm'), 13), 'yyyy-mm-dd') from dual;
select to_char(add_months('2020/10/10', 13), 'yyyy-mm-dd') from dual;
select to_date('05122020', 'mmddyyyy') from dual;

-- MONTHS_BETWEEN(d1, d2) -> d1과 d2사이의 개월 수 구하기
select trunc(months_between(to_date('2021-05-10', 'yyyy-mm-dd'), sysdate)) from dual;
select abs(ceil(months_between(to_date('2021/05/10', 'yyyy/mm/dd'), sysdate))) from dual;

-- [문제] emp테이블 근속 개월 수를 계산하라
select ename name, job, trunc(months_between(sysdate, hiredate)) consecutive_months from emp;

-- ROUND(d,[F]) -> F에 지정된 단위로 날짜를 반올림 **day는 요일로 반올림 한다(시작은 일요일)
select round(sysdate, 'year') from dual;
select round(sysdate, 'month') from dual;
select round(sysdate, 'day') from dual;

-- 날짜의 산술연산
-- 날짜-날짜 = 숫자, 날짜+-숫자 = 날짜 (단위: day)
-- [문제] 오늘을 기준으로 100일 후 날짜는?
select sysdate-100 from dual;
-- [문제] 입사한지 몇일 되었을까?
select hiredate, floor(sysdate-hiredate) from emp;


-- 그룹 함수 -> 여러 행 또는 테이블에 적용돼서 하나의 결과값을 리턴하는 함수
-- COUNT() -> 개수
select count(ename) 사원수 from emp;
select count(empno) 사원수 from emp;
select count(nvl(comm,0)) 사원수 from emp;
-- select count(ename), sal from emp;	-- ERROR
select count(ename) from emp where job='MANAGER';

-- MAX(), MIN() -> 해당 컬럼의 값 중에 최대,최소값을 구한다
select max(sal), min(sal) from emp where job in ('MANAGER', 'SALESMAN');

-- AVG() -> 평균

-- SUM() -> 합

-- STDDEV() -> 표준편차
select stddev(sal) from emp;

-- GROUP BY
-- 부서별 급여의 합계와 평균
select deptno, sum(sal) sum, round(avg(sal),2) AVERAGE from emp group by deptno order by deptno;

select job, count(empno), avg(sal), max(sal), min(sal) from emp group by job order by count(empno);

-- [문제] 급여가 $1500 이상인 사원 중 업무별 사원 수, 급여합계, 금여 최대값을 구하라
select job, count(empno), sum(sal), max(sal) from emp where sal>=1500 group by job order by job;

-- [문제] 업무별 사원수를 구하라, 사원수가 3명 이상인 업무를 선택하라
select job, count(empno) from emp group by job having count(empno)>=3;

-- [문제] 전체 월급이 5000을 초과하는 각 업무에 대해서 업무와 급여합계를 구하라
-- 단 판매원(SALESMAN)은 제외하고 급여합계로 내림차순 정렬하라
select job, sum(sal) from emp
where job not in ('SALESMAN')
group by job having sum(sal)>5000
order by sum(sal) desc;

-- ROLLUP() -> 그룹 함수의 처리를 결과 전체에 대해 적용한다
select job, max(sal), sum(sal), round(avg(sal),2) from emp 
group by rollup(job);

-- [문제] 부서를 1차 분류하고 부서내 담당업무를 2차 분류하여 사원수, 급여의 합계와 평균을 구하라
select deptno, job, count(empno), sum(sal), round(avg(sal),2) from emp 
group by rollup(deptno, job) order by deptno, job;


-- [문제1] 사원번호, 사원명, 담당업무, 입사일, 급여, 보너스, 지급액(급여+보너스)을 출력하라.
select empno num, ename name, job, to_char(hiredate, 'yyyy/mm/dd') hiredate, sal salary, nvl(comm,0) bonus, sal+nvl(comm,0) net from emp;

-- [문제2] 사원명, 담당업무, 급여, 보너스를 선택하되
-- 급여가 $2500~4000 사이이거나 담당업무가 SALESMAN인 사원을 급여의 내림차순으로 정렬하여 레코드를 선택하라
select ename name, job, sal salary, nvl(comm,0) bonus from emp
where sal>=2500 and sal<=4000 or job like 'SALESMAN'
order by sal desc;



select * from dba_users;
select * from emp;
select * from dual;
