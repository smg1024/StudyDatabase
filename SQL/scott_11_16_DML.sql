-- [문제1] 사원번호, 사원명, 담당업무, 입사일, 급여, 보너스, 지급액(급여+보너스)을 출력하라.
select empno num, ename name, job, to_char(hiredate, 'yyyy/mm/dd') hiredate, sal salary, nvl(comm,0) bonus, sal+nvl(comm,0) net from emp;

-- [문제2] 사원명, 담당업무, 급여, 보너스를 선택하되
-- 급여가 $2500~4000 사이이거나 담당업무가 SALESMAN인 사원을 급여의 내림차순으로 정렬하여 레코드를 선택하라
select ename name, job, sal salary, nvl(comm,0) bonus from emp
where sal between 2500 and 4000 or job like 'SALESMAN'
order by sal desc;


-- CUBE() -> 1차 분류 또는 2차 분류에 대하여 통계를 구해주기
-- [문제]부서별 업무에 대한 사원수 급여의 합select deptno, job, count(empno) "사원 수", sum(sal) "급여의 합계" from emp
group by cube(deptno, job) order by deptno;

-- GROUPING() -> GROUP BY로 통계가 계산된 경우는 0
--			  -> ROLLUP이나 CUBE로 계산된 경우는 1을 반환
-- [문제] 부서별 업무에 대한 사원수, 급여합계, 최고급여
select deptno, job, grouping(deptno) D, grouping(job) J, count(empno) num, sum(sal) sum, max(sal) max from emp
group by cube(deptno, job) order by deptno;


-- 데이터 조작어 Data Manipulation Language
-- INSERT INTO -> 테이블 안에 데이터를 삽입하는 역할
-- VALUES -> 데이터 값
-- SELECT -> 선택
-- UPDATE -> 수정
-- DELETE -> 삭제

-- 사원 추가
-- 모든 필드의 값이 존재할 때 - 레코드 선택했을 때 표시되는 필드 순서와 일치해야한다
insert into emp values(2222, 'JANE', 'PLANNER', 7499, sysdate, 1000, 500, 40);

-- 일부의 데이터가 존재할 때
-- 사원번호(3333), 사원명(이순신), 급여(2000)
insert into emp(empno, sal, ename)
values(3333, 2000, 'DAVID');

-- [문제] dept 테이블에 부서코드 (deptno):50, 부서명(dname):PLANNER, 위치(loc):WASHINGTON
insert into dept
values(50, 'PLANNER', 'WASHINGTON');


-- CREATE -> 테이블 생성
-- 기존 테이블의 구조만 복사 가능
-- 기존 테이블의 모든 레코드 또는 일부 레코드를 이용하여 복사할 수 있다
-- emp테이블의 모든 필드와 모든 레코드 복사하기
create table emp2
as
select * from emp;

-- emp테이블의 일부 필드(사원번호, 사원명, 업무, 급여)와 레코드 복사하기
create table emp3
as
select empno, ename, job, sal from emp;

-- emp테이블의 일부 레코드(job=MANAGER, ANALYST)를 복사하기
create table emp4
as
select * from emp where job in('MANAGER', 'ANALYST');

-- emp테이블의 테이블구조만 복사하기 - 없는 데이터 조건을 붙이면 된다
create table emp5
as
select empno, ename, job, sal from emp where 1=2;

-- emp 모든 필드*레코드
-- emp5 레코드는 없고 필드는 empno, ename, job, sal이 있다
insert into emp5
select empno, ename, job, sal from emp;

-- UPDATE -> 테이블 내의 데이터를 1개 이상 수정하기
-- [문제] DAVID의 업무를 인사부로 수정
update emp set job='HR'
where ename='DAVID';

-- [문제] MANAGER 업무의 사원은 급여가 10% 인상된 데이터로 수정하라
update emp set sal=sal*1.1 where job='MANAGER';

-- [문제] 보너스를 받지 않는 사원의 보너스를 급여 10%로 수정하라
update emp set comm=sal*0.1 where nvl(comm,0)=0;

-- DELETE -> 레코드를 전체 또는 일부 삭제하기
-- [문제] comm이 $200 미만인 레코드를 삭제하라
delete from emp where comm<200;





select * from emp;
select * from emp5;
select * from emp4;
select * from emp3;
select * from emp2;
select * from dept;
select * from dba_users;
select * from dual;