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


























