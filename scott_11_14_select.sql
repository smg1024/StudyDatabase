-- 커서가 있는 줄의 쿼리문이 실행됨
-- 테이블 목록을 확인
select * from tab;

select * from emp;

-- 필드명 : 영어, 한글(x)
SELECT
ename 사원명, sal, sal*0.1 bonus
FROM emp;

-- 테이블 구조 확인
--desc emp;

-- where절 : 조건에 맞는 레코드 선택하기
--          from절 다음에 where절이 있다
SELECT * FROM emp WHERE deptno = 10;
SELECT ename 이름, sal 급여, deptno "부서 코드" FROM emp where job='MANAGER';

-- emp테이블의 사원 중 급여가 2000이상, 부서코드 30번인 사원을 선택하라.
SELECT empno 사번, ename 이름
FROM emp
WHERE sal>=2000 AND deptno=30;

-- emp테이블의 사원 중 담당 업무가 manager이거나 salesman인 사원 중 급여가 2000~4000 인 사원을 선택하라.
select empno 사번, ename 이름
from emp
where (job='MANAGER' OR job='SALESMAN') AND sal>=2000 AND sal<=4000;

-- between 연산자
-- 조건절: 필드명 between a and b
--        필드명의 값이 a와 b사이이면
-- 급여가 2000~4000 사이인 사원을 선택
select ename, job, sal from emp
where sal between 2000 and 4000;

-- 급여가 2000~4000 사이가 아닌 사원을 선택
select ename, job, sal from emp
where sal not between 2000 and 4000;

-- in 연산자: or
-- 급여가 1250, 1500, 1300인 사원을 선택하라
select empno, ename, sal from emp
where sal=1250 or sal=1500 or sal=1300;

select empno, ename, sal from emp
where sal in (1250, 1300, 1500);

select empno, ename, sal, deptno from emp
where sal not in (1250, 1300, 1500);

-- like 연산자
-- 검색 String값에 대해서 일부가 일치하는 데이터 선택
-- 사원명이 A로 시작하는 사원 선택
select empno, ename, sal, comm from emp
where ename like 'A%';

-- 사원명이 S로 끝나는 사원 선택
select empno, ename, sal, comm from emp
where ename like '%S';

-- 사원명에 S가 포함되어있으면 선택하라
select empno, ename, sal, comm from emp
where ename like '%S%';

-- 사원명에 A 그 다음 D가 포함되어있으면 선택하라
select empno, ename, sal, comm from emp
where lower(ename) like '%a%d%';

-- 사원명 중에 두번째 문자가 L인 사원을 선택하라
-- like에서 _은 문자열 1개를 의미한다
select empno, ename, sal, comm from emp
where ename like '_L%';

select empno, ename, sal, comm from emp
where ename not like '_L%';

-- is null, is not null
select ename, sal, comm, comm+sal from emp;
select ename, sal, comm from emp where comm = null; -- null은 일반 연산자 적용 안됨
select ename, sal, comm from emp where comm is null;
select ename, sal, comm from emp where comm is not null order by 1;

-- 사원번호, 사원명, 담당업무, 급여, 보너스, 지급액을 선택하라.
-- nvl() : null value  값이 null 원하는 데이터 변환하여 처리한다
select empno, ename, job, sal, nvl(comm, 0) comm, sal+nvl(comm,0) payment from emp; 

-- 보너스를 받는 사원의 사원명, 급여, 보너스를 선택하라.
select ename, sal, comm bonus from emp where nvl(comm,0)>0;

-- order by : 정렬하기 (오름차순:asc, 내림차순:desc)
-- 급여가 높은 순으로 정렬하라
select ename, sal from emp order by sal asc;
select ename, sal from emp order by sal desc;

-- 업무별 급여순으로 정렬하라
select ename, job, sal from emp order by job asc, sal asc;

-- [문제] 81년도에 입사한 사원을 부서별 급여순으로 정렬하라
select * from emp where hiredate like '81%' order by deptno asc, sal asc;

select * from dba_users;





select * from emp;