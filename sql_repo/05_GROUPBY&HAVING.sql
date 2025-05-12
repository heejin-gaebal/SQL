-- GROUP BY & HAVING
---------------------------------- GROUP BY ----------------------------------
/*
    <GROUP BY>
    그룹 기준을 제시할 수 있는 구문
    여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
*/
-- 전체 사원을 하나의 그룹으로 묶어서 급여 총합을 구한 결과 조회
SELECT SUM(SALARY)FROM EMPLOYEE;

-- 각 부서별 그룹으로 묶어서 부서별 급여 총합을 구한 결과 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 전체 사원수
SELECT COUNT(*)FROM EMPLOYEE;
-- 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 각 부서별 보너스를 받는 사원수
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
-- 각 직급별 급여 합계 조회
SELECT JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;
-- 부서별 사원수, 보너스를 받는 사원수, 급여의 합, 평균 급여, 최고 급여, 최저 급여를 조회
SELECT DEPT_CODE,
COUNT(DEPT_CODE)"부서별 사원수", COUNT(BONUS)"보너스를 받는 사원수", SUM(SALARY)"급여의 합", 
FLOOR(AVG(NVL(SALARY,0)))"평균 급여", MAX(SALARY)"최고 급여" ,MIN(SALARY)"최저 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC NULLS LAST;

-- 성별 별 사원수
SELECT SUBSTR(EMP_NO, 8,1), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8,1);

-- 그룹 기준 설정할 때, 칼럼 여러개 작성 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

---------------------------------- HAVING ----------------------------------
/*
    <HAVING>
    그룹에 대한 조건을 제시할 때 사용하는 구문(주로 그룹 함수의 결과를 가지고 비교 수행)
    
    * 실행 순서
    5: SELECT      조회하고자 하는 칼럼명 AS "별칭" | 계산식 | 함수식
    1: FROM        조회하고자 하는 테이블명
    2: WHERE       조건식
    3: GROUP BY    그룹 기준에 해당하는 칼럼명 | 계산식 | 함수식
    4: HAVING      그룹에 대한 조건식
    6: ORDER BY    정렬 기준에 해당하는 칼럼명 | 별칭 | 칼럼 순번
*/

-- 각 부서별 평균 급여 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 급여가 300만원 이상인 직원의 평균 급여 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;
-- 조건이 그룹에 대한 것

-- 직급별 총 급여의 합이 10000000 이상인 직급들만 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를 받는 사원이 없는 부서들만 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

/*
    <집계 함수> : 그룹별 산출한 결과 값의 중간 집계를 계산 해주는 함수
*/
-- 직급별 급여의 합계를 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 직급별 급여의 합계와 전체 직급의 총 급여  조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);

-- 부서 코드도 같고 직급 코드도 같은 사원들을 그룹 지어서 급여의 합계를 조회
-- GROUP BY엔 여러 컬럼이 올 수 있다.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE;

-- ROLLUP
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) -- GROUP BY 컬럼중 하나만 소계 낼때 ROLLUP
ORDER BY DEPT_CODE, JOB_CODE;
-- DEPT_CODE만 그룹화 | 마지막행 전체 합계 도출
-- 소계에 대해서는 JOB_CODE 그룹화 안함

-- CUBE
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)   -- GROUP BY 컬럼 전부 소계를 낼때 CUBE 사용
ORDER BY DEPT_CODE, JOB_CODE;
-- DEPT_CODE와 JOB_CODE 그룹화 | 마지막행 전체 합계 도출

/*
    <GROUPING>
    ROLLUP이나 CUBE에 의해 산출된 값이 
    해당 칼럼의 집합의 산출물이면 0을 반환, 아니면 1을 반환하는 함수
*/
-- ROLLUP
SELECT DEPT_CODE, JOB_CODE,  SUM(SALARY),
       GROUPING(DEPT_CODE),
       GROUPING(JOB_CODE)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE, JOB_CODE;

-- CUBE
SELECT DEPT_CODE, JOB_CODE,  SUM(SALARY),
       GROUPING(DEPT_CODE),
       GROUPING(JOB_CODE)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE, JOB_CODE;

----------------------------------------------------

/*
    <집합 연산자>
    여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자이다. 위/아래의 쿼리문을 합치기
    
    UNION       : 두 쿼리문을 수행한 결과값을 더한 후 중복되는 행은 제거한다.            (합집합)
    UNION ALL   : UNION과 동일하게 두 쿼리문을 수행한 결과값을 더하고 중복은 허용한다.    (합집합)
    INTERSECT   : 두 쿼리문을 수행한 결과값에 중복된 결과값만 추출한다.                 (교집합)
    MINUS       : 선행 쿼리의 결과값에서 후행 쿼리의 결과값을 뺀 나머지 결과값만 추출한다. (차집합)
*/

-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

MINUS
-- EMPLOYEE 테이블에서 급여가 300만원 초과인 사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;











