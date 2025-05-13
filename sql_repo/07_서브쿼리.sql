-- 서브쿼리
/*
    <SUBQUERY>
    하나의 SQL 문 안에 포함된 또 다른 SQL 문을 뜻한다. 
    메인 쿼리(기존 쿼리)를 보조하는 역할을 하는 쿼리문이다.
*/
-- 노옹철 사원과 같은 부서원들을 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
);

----------------------------------------------------------
/*
    <서브 쿼리 구분>
    서브 쿼리는 서브 쿼리를 수행한 결과값의 행과 열의 개수에 따라서 분류할 수 있다.
    
    1) 단일행 서브 쿼리    : 서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때
    2) 다중행 서브 쿼리    : 서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
    3) 다중열 서브 쿼리    : 서브 쿼리의 조회 결과 값이 한 행이지만 칼럼이 여러개 일때
    4) 다중행,열 서브 쿼리 : 서브 쿼리의 조회 결과 값이 여러행, 여러열 일 때
    
    * 서브 쿼리의 유형에 따라서 서브 쿼리 앞에 붙는 연산자가 달라진다.
        
    <단일행 서브 쿼리>
    서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때 (단일행, 단일열)
    비교 연산자(단일행 연산자) 사용 가능 (=, !=, <>, ^=, >, <, >=, <=, ...)
*/

-- 1) 전 직원의 평균 급여보다 급여를 적게 받는 직원들의 이름, 직급 코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
);

-- 2) 최저 급여를 받는 직원의 사번, 이름, 직급 코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (
    SELECT MIN(SALARY)
    FROM EMPLOYEE
);

-- 3) 노옹철 사원의 급여보다 더 많은 급여받는 사원들의 사번, 사원명, 부서명, 직급 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (
    SELECT SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
);

-- 4) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
    SELECT MAX(SUM(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
);

-- 5) 전지연 사원이 속해있는 부서원들 조회 (단, 전지연 사원은 제외)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '전지연'
) AND EMP_NAME != '전지연';

/*
    <다중행 서브 쿼리>
    서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
    
    IN / NOT IN (서브 쿼리) : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면 혹은 없다면 TRUE를 리턴한다.
    ANY : 여러 개의 값들 중에서 한 개라도 만족하면 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다. 
        ANY(100, 200, 300)
        SALARY = ANY(...)  : IN과 같은 결과
        SALARY != ANY(...) : NOT IN과 같은 결과
        SALARY > ANY(...)  : 최소값 보다 크면 TRUE
        SALARY < ANY(...)  : 최대값 보다 작으면 TRUE
        
    ALL : 여러 개의 값들 모두와 비교하여 만족해야 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다.
        ALL(100, 200, 300)
        SALARY > ALL(...)  : 최대값 보다 크면 TRUE
        SALARY < ALL(...)  : 최소값 보다 작으면 TRUE
*/

-- 1) 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = ANY(--IN과 비슷하게 사용
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
ORDER BY DEPT_CODE;

SELECT *
FROM EMPLOYEE A --메인쿼리에서 별칭을 이미 달아주어
WHERE SALARY =  ANY (
    SELECT MAX(SALARY)
    FROM EMPLOYEE B
    WHERE B.DEPT_CODE = A.DEPT_CODE -- 서브쿼리에서 별칭을 알수잇다
);

/*
    <다중열 서브 쿼리> : 조회 결과 값은 한 행이지만 나열된 칼럼 수가 여러 개일 때
*/
-- 1) 하이유 사원과 같은 부서 코드, 같은 직급코드에 해당하는 사원들 조회
SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
    SELECT DEPT_CODE, JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '하이유'
);

/*
    <다중행 다중열 서브 쿼리> : 서브 쿼리의 조회 결과값이 여러 행, 여러 열일 경우
*/
-- 다중행 다중열 서브 쿼리를 사용해서 
-- 각 직급별로 최소 급여를 받는 사원의 사번, 이름, 직급 코드, 급여 조회
SELECT *
FROM EMPLOYEE
WHERE(JOB_CODE, SALARY) IN (
                            SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE
                            );
        
-- 각 부서별 최소 급여를 받는 사원의 사번, 이름, 직급 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE(DEPT_CODE, SALARY) IN (
                            SELECT DEPT_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE
                            );

/*
    <인라인 뷰> 
    FROM 절에 서브 쿼리를 제시하고, 서브 쿼리를 수행한 결과를 테이블 대신 사용한다.
*/
-- 1) 인라인 뷰를 활용한 TOP-N 분석
-- 전 직원 중 급여가 가장 높은 상위 5명의 순위, 이름, 급여 조회
SELECT ABC.*, ROWNUM
FROM (
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC
) ABC -- 테이블 역할로 테이블 별칭
WHERE ROWNUM <= 5;

/*
    ROWNUM을 그냥쓰면 순번이 매겨진 후 정렬되기 때문에 
    서브쿼리로 만들어두고 그 후에 메인쿼리에서 ROWNUM 적용하고 WHERE절에 조건식
*/ 

-- 2) 부서별 평균 급여가 높은 3개의 부서의 부서 코드, 평균 급여 조회
SELECT DEPT_CODE, AVG_SAL, ROWNUM --별칭을 지었으면 그대로 별칭사용해야함
FROM(
    SELECT DEPT_CODE, TO_CHAR(ROUND(AVG(SALARY)),'99,999,999') AS AVG_SAL
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY AVG(SALARY) DESC
)
WHERE ROWNUM <= 3;

-- 2-1) WITH를 이용한 방법 : WITH의 결과가 메인쿼리에 테이블처럼 담긴다.
WITH ABC AS(
    SELECT EMP_NAME, DEPT_CODE
    FROM EMPLOYEE
)
SELECT *
FROM ABC;

/*
    <RANK 함수> [문법]
    RANK() OVER(정렬 기준) / DENSE_RANK() OVER(정렬 기준)
    
    RANK() OVER(정렬 기준)      : 동일한 순위 이후의 등수를 동일한 인원수만큼 건너뛰고 순위를 계산한다.
                                (EX. 공동 1위가 2명이면 다음 순위는 3위)
    DENSE_RANK() OVER(정렬 기준): 동일한 순위 이후의 등수를 무조건 1씩 증가한다.
                                (EX. 공동 1위가 2명이면 다음 순위는 2위)
*/
-- 사원별 급여가 높은 순서대로 순위를 매겨서 순위, 사원명, 급여 조회
-- 공동 19위 2명 뒤에 순위는 21위
WITH ABC AS (
    SELECT RANK() OVER (ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
    FROM EMPLOYEE
)
SELECT * FROM ABC
WHERE 순위 BETWEEN 1 AND 5;

-- 6위에서 10위 구하기
SELECT *
FROM(
    SELECT 이름, 급여, ROWNUM RN
    FROM (
        SELECT EMP_NAME 이름, SALARY 급여
        FROM EMPLOYEE
        ORDER BY SALARY DESC
    )
)
WHERE RN BETWEEN 6 AND 10;




























