SELECT * FROM tab;
SELECT * FROM emp;

-- 단일 행 서브쿼리
-- 서브쿼리는 ()안에 기술한다
-- 서브쿼리가 먼저 실행되고 메인쿼리가 실행된다

-- scott 같은 부서 사원은?
SELECT deptno FROM emp WHERE ename='SCOTT';
SELECT * FROM emp WHERE deptno=20;

-- 두개의 쿼리를 하나로 만들기
SELECT empno, ename, sal FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SCOTT');

-- 평균급여 이상을 받는 사원은?
SELECT AVG(sal) FROM emp;
SELECT * FROM emp WHERE sal>2977.1153;

SELECT empno, ename, job, sal FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp);

-- 사번7369와 같은 업무를 하는 사원은?
SELECT empno, ename, job FROM emp
WHERE job = (SELECT job FROM emp WHERE empno=7369);

-- SCOTT보다 급여가 높은 사원은?
SELECT empno, ename, job FROM emp
WHERE sal>(SELECT sal FROM emp WHERE ename='SCOTT');

-- [문제1] 사원테이블에서 사원명, 입사일, 담당업무, 부서코드를 선택하되 
-- 'ADAMS'와 같은 업무를 사원이거나 'SCOTT'과 같은 부서인 사원을 선택하라
SELECT ename, hiredate, job, deptno FROM emp 
WHERE job = (SELECT job FROM emp WHERE ename='ADAMS')
OR deptno = (SELECT deptno FROM emp WHERE ename='SCOTT');

-- [문제2] 사원테이블에서 사원번호가 7521인 사원과 업무가 같고
-- 급여가 7934인 사원보다 많은 사원의 사번, 이름, 업무, 입사일자, 급여를 출력하세요
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE job = (SELECT job FROM emp WHERE empno=7521)
and sal > (SELECT sal FROM emp WHERE empno=7934);

-- 서브쿼리에서 그룹함수 사용하기
-- [문제] 담당업무가 'SALESMAN'인 사원의 평균급여보다 작게 받는 사원을 선택하라
SELECT empno, ename, job, sal FROM emp 
WHERE sal < (SELECT AVG(sal) FROM emp WHERE job='SALESMAN');

-- HAVING절에 서브쿼리 사용하기
SELECT deptno, MIN(sal) FROM emp group by deptno
HAVING MIN(sal) > (SELECT MIN(sal) FROM emp WHERE deptno=20);

-- [문제] 사원테이블의 사원의 급여가 10번부서의 평균급여보다 많이 받는 업무를 하는 업무와 평균급여를 선택하라
SELECT job, AVG(sal) FROM emp
--WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno=10) group by job;
group by job HAVING AVG(sal) > (SELECT AVG(sal) FROM emp WHERE deptno=10);

--=====================================================================

-- 다중 행(Multi-row) 서브쿼리
SELECT empno, ename, sal FROM emp
WHERE sal > (SELECT sal FROM emp WHERE deptno=10); --ERROR:서브쿼리가 하나 이상의 값을 출력

-- [문제] 부서별 최고 급여와 같은 급여를 받는 사원을 선택하라
SELECT empno, ename, job, sal, deptno FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp group by deptno);

-- [문제] 업무별로 최대 급여를 받는 사원의 사번, 이름, 업무, 금여를 출력하라
SELECT empno, ename, job, sal FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp group by job);

-- ANY -> 하나의 조건만 만족해도 선택
SELECT sal FROM emp WHERE job = 'SALESMAN';

-- 업무가 'SALESMAN'인 사원의 최소급여보다
-- 많으면서 부서번호가 20번이 아닌 사원의 이름과 급여, 부서코드를 출력하라.
SELECT ename, job, sal, deptno FROM emp
WHERE sal > ANY (SELECT sal FROM emp WHERE job='SALESMAN')
and deptno != 20;

-- [문제] 사원테이블의 사원중 KING속한 부서의 사원보다 늦게 입사한 사원의 
-- 사원명, 업무, 급여, 입사일을 선택하라.
SELECT ename, job, sal, hiredate FROM emp
WHERE hiredate > ANY (SELECT hiredate FROM emp 
WHERE deptno = (SELECT deptno FROM emp WHERE ename='KING'));

-- ALL -> 모든 조건을 만족해야 선택
SELECT sal FROM emp WHERE job='SALESMAN';

-- 업무가 'SALESMAN'인 사원의 최대급여보다
-- 많으면서 부서번호가 20번이 아닌 사원의 이름과 급여를 출력하라.
SELECT ename, sal FROM emp
WHERE deptno != 20
AND sal > ALL (SELECT sal FROM emp WHERE job='SALESMAN');

-- EXISTS -> 서브쿼리(논리식)이 최소 1개이상의 행을 출력하면 출력, 없다면 출력X
SELECT empno, ename, job, sal FROM emp e
WHERE EXISTS (SELECT * FROM emp WHERE e.empno = mgr);

--==================================================================

-- 다중 열(Multi-column) 서브쿼리
-- 서브쿼리에서 선택한 레코드가 칼럼이 2개 이상일때

-- Pairwise(쌍비교) 서브쿼리
SELECT ename, deptno, sal, comm FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE deptno = 30 AND comm is NOT NULL)
AND comm IN (SELECT comm FROM emp WHERE deptno = 30 AND comm is NOT NULL);

SELECT ename, deptno, sal, comm FROM emp
WHERE (sal, comm)
IN (SELECT sal, comm FROM emp WHERE deptno = 30 AND comm IS NOT NULL);

-- [문제] 업무별로 최소 급여를 받는 사원의 사번, 이름, 업무, 부서번호를 출력하세요.
-- 단, 업무별로 정렬하세요.
SELECT empno, ename, job, deptno, sal FROM emp e
WHERE (sal, job) IN (SELECT MIN(sal), job FROM emp GROUP BY job)
ORDER BY job;

-- Nonpairwise(비쌍비교) 서브쿼리
-- 서브쿼리가 여러 조건별로 사용되어서 결과값을 메인쿼리로 넘겨준다
SELECT empno, sal, deptno FROM emp e
WHERE sal IN (SELECT sal FROM emp WHERE deptno = 30 AND comm is NOT NULL)
AND deptno IN (SELECT deptno FROM emp WHERE deptno = 30 AND comm is NOT NULL);

--===================================================================

-- (INLINE VIEW) FROM절 상의 서브쿼리
-- 테이블 전체를 불러오기보다 한번 솎아낸 테이블을 불러오고 싶을때 사용
SELECT e.ename, e.sal
FROM (SELECT empno, ename, job, sal FROM emp WHERE deptno IN (10, 20)) e;

--===================================================================

-- 집합쿼리
-- UNION -> 합집합
SELECT deptno FROM emp
UNION 
SELECT deptno FROM dept;

-- UNION ALL -> 공통원소 중복해서 포함한 합집합
SELECT deptno FROM emp
UNION ALL
SELECT deptno FROM dept;

-- INTERSECT -> 교집합
SELECT deptno FROM emp
INTERSECT
SELECT deptno FROM dept;

-- MINUS -> 차집합
SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;





SELECT * FROM emp;
