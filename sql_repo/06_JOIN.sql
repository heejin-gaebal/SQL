
/*
    <JOIN> 양 옆 테이블을 합치기
    두 개의 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문이다.
    
    1. 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
       연결시키는 칼럼의 값이 일치하는 행들만 조인되서 조회한다.
       일치하는 값이 없는 행은 조회 X
        
    1) 오라클 전용 구문 [문법]
        SELECT 칼럼, 칼럼, ...
        FROM 테이블1, 테이블2
        WHERE 테이블1.칼럼명 = 테이블2.칼럼명;
        
        - FROM 절에 조회하고자 하는 테이블들을 콤마(,)로 구분하여 나열한다.
        - WHERE 절에 매칭 시킬 칼럼명에 대한 조건을 제시한다.
    
    2) ANSI 표준 구문 [문법] <표준을 위주로 공부>
        SELECT 칼럼, 칼럼, ...
        FROM 테이블1
        [INNER] JOIN 테이블2 ON (테이블1.칼럼명 = 테이블2.칼럼명);
        
        - FROM 절에 기준이 되는 테이블을 기술한다.
        - JOIN 절에 같이 조회하고자 하는 테이블을 기술 후 매칭 시킬 칼럼에 대한 조건을 기술한다.
        - 연결에 사용하려는 칼럼명이 같은 경우 ON 구문 대신에 USING(칼럼명) 구문을 사용한다.
*/
-- 각 사원들의 사번, 사원명, 부서 코드, 부서명을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT * FROM DEPARTMENT;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E -- 별칭
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;
-- 조인을 진행할 때 조인조건이 NULL인 값은 안나옴 | 일치하는 요소가 없어서 사라진 것.

-- 각 사원들의 사번, 사원명, 직급 코드, 직급명을 조회
-- 어느 테이블의 JOB_CODE인지 모르므로 테이블별칭을 붙어줘야함
SELECT EMP_ID, EMP_NAME, JOB_NAME, J.JOB_CODE 
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_NAME, JOB_CODE 
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE); -- 컬럼명이 똑같을때 USING [SELECT절에 테이블별칭X]

SELECT EMP_ID, EMP_NAME, JOB_NAME, JOB_CODE 
FROM EMPLOYEE E
NATURAL JOIN JOB; -- 컬럼명이 똑같을때 NATURAL JOIN [SELECT절에 테이블별칭X]

-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의 사번, 사원명, 직급명, 급여를 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '대리'; -- JOB_NAME 컬럼은 한쪽 테이블만 있으므로 별칭 생략

/*
    2. 다중 JOIN : 여러 개의 테이블 조인하는 경우에 사용한다.
*/
-- EMPLOYEE, DEPARTMENT, LOCATION 테이블을 다중 JOIN 하여 사번, 사원명, 부서명, 지역명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID    -- EMPLOYEE와 DEPARTMENT 조인
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE;-- LOCATION과 DEPARTMENT 조인

/*
    3. 외부 조인 (OUTER JOIN)
       테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능하다.
       단, 반드시 기준이되는 테이블(컬럼)을 지정해야 한다. (LEFT/RIGHT/(+))
*/
-- 사원명, 부서코드, 부서명 조회
SELECT E.EMP_NAME, E.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

SELECT E.EMP_NAME, E.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E
RIGHT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

SELECT E.EMP_NAME, E.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E
FULL OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

/*
    4. 카테시안곱(CARTESIAN PRODUCT) / 교차 조인(CROSS JOIN)
        조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색된다.
        테이블의 행들이 모두 곱해진 행들의 조합이 출력 -> 과부화의 위험
        모든 경우의 수의 행들이 나온다
*/
SELECT *
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D;


/*
    5. 비등가 조인(NON EQUAL JOIN)
        조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
        지정한 칼럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식이다.
        ( = 이외에 비교 연산자 >, <, >=, <=, BETWEEN AND, IN, NOT IN 등을 사용한다.)
        ANSI 구문으로는 JOIN ON 구문으로만 사용이 가능하다. (USING 사용 불가)
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL
ORDER BY SALARY DESC;

SELECT EMP_NAME, SALARY, SAL_LEVEL,
CASE SAL_LEVEL 
    WHEN 'S1' THEN '특급'
    WHEN 'S4' THEN '고급'
    WHEN 'S5' THEN '중급'
    WHEN 'S6' THEN '초급'
    END 등급
FROM EMPLOYEE E
JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL
ORDER BY SALARY DESC;

/*
    6. 자체 조인(SELF JOIN)
        같은 테이블을 다시 한번 조인하는 경우에 사용한다.
*/
-- EMPLOYEE 테이블을 SELF JOIN 하여 사번, 사원명, 부서 코드, 사수 사번, 사수 이름 조회
SELECT A.EMP_ID, A.EMP_NAME, A.DEPT_CODE, B.EMP_ID"사수 사번" , B.EMP_NAME "사수 이름"
FROM EMPLOYEE A
JOIN EMPLOYEE B ON A.MANAGER_ID = B.EMP_ID;

















