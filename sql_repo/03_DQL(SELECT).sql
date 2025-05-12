--DQL (SELECT)
/*
    <SELECT 절> [문법]
    SELECT  컬럼1, 컬럼2,...
    FROM 테이블;
    
    - 데이터를 조회할 때 사용
    - SELECT 통해서 조회된 결과를 RESULT SET(결과집합) 이라고 한다.
    - 조회하려는 컬럼은 반드시 FROM절에 기술한 테이블에 존재해야 함. 
*/

-- EMPLOYEE 테이블에서 사번, 이름, 월급 조회
/*
SELECT 사번, 이름, 월급
FROM EMPLOYEE;
*/

-- EMPLOYEE 테이블에서 모든 컬럼 조회
SELECT * FROM EMPLOYEE;

/*
    <산술연산>
*/
-- EMPLOYEE 테이블에서 이름, 연봉 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 이름, 월급, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 이름, 월급, 보너스, 연봉(+보너스) 조회
SELECT EMP_NAME, SALARY, BONUS, (SALARY + SALARY*BONUS) * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘-입사일) 조회
-- DATE 타입간 연산 가능
-- SYSDATE는 현재 날짜(시스템상 날짜)
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

/*
    <컬럼명에 별칭 지정>
    SELECT 컬럼명, AS 별칭, 컬럼명,...
    
    - AS 생략가능
    - 별칭에 띄어쓰기/특수문자 포함시 쌍따옴표 작성 가능 
    - 컬럼명을 깔끔하게 표기하기위해 별칭 사용
*/
-- EMPLOYEE 테이블에서 사원명, 월급 조회
SELECT 
    EMP_NAME AS 사원명, 
    SALARY AS 급여,
    (SALARY + SALARY*BONUS)*12 "보너스 포함 연봉"
FROM EMPLOYEE;

/*
    <리터럴(값)>
    SELECT절에 리터럴을 사용해, 테이블에 존재하는 데이터처럼 조회 가능
    모든 행에 반복적으로 출력됨.
*/
-- EMPLOYEE 테이블에서 사번, 사원명, 월급 조회
                                 /*리터럴값 자체가 컬럼처럼 조회가능*/
SELECT EMP_ID, EMP_NAME, SALARY, '원 입니다.' 
FROM EMPLOYEE;

/*
    <DISTINCT>
    - 중복 값 제거
    - SELECT 절에 한번만 작성
    - 컬럼이 여러개면, 모두 동일해야 중복으로 판단.
*/
-- EMPLOYEE 테이블에서 직급코드 조회 (중복X)
SELECT DISTINCT JOB_CODE 
FROM EMPLOYEE;

/*
    <연결 연산자>
    - 여러 값(컬럼,리터럴)을 하나의 컬럼인것 처럼 연결 < || >
*/
-- EMPLOYEE 테이블에서 사번, 사원명, 급여 조회 [하나로 연결해 출력]
SELECT EMP_ID || EMP_NAME || '의 월급은 ' || SALARY || '입니다.'
FROM EMPLOYEE;

-------------------------------------------------------------------------------

/*
    <WHERE 절> [문법]
    SELECT ~
    FROM ~
    WHERE 조건식;
    
    - 조건식을 만족하는 행에 대해서만 조회할 때 사용
    - 조건식에는 다양한 연산자 사용 가능
    
    <비교 연산자>
    <, >, <=, >=
    =
    !=, ^=, <> → 같지않다
*/
-- EMPLOYEE 테이블에서 사번, 사원명, 부서코드 조회 (부서코드가 D9이 아닌 사람들)
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';

-- EMPLOYEE 테이블에서 부서코드가 D9과 일치하는 사원들의 모든 컬럼
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 직원들의 직원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;


--------------------------------- 실습문제 ---------------------------------


-- 1. EMPLOYEE 테이블에서 재직 중(ENT_YN 컬럼 값이 'N')인 직원들의 사번, 이름, 입사일 조회 
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 2. EMPLOYEE 테이블에서 연봉이 5000이상인 직원의 직원명, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, SALARY * 12 AS 연봉, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;


--------------------------------- 실습문제 끝 ---------------------------------

/*
    <논리 연산자>
    여러 개의 조건을 엮을 때 사용한다.
    AND (~면서, 그리고)
    OR (~거나, 또는)
*/
-- EMPLOYEE 테이블에서 부서 코드가 D6이면서 급여가 300만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;

-- EMPLOYEE 테이블에서 급여가 400만원 이상, 직급코드가 J2인 사람의 모든 컬럼 조회
SELECT * FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY <= 6000000 AND SALARY >= 3500000;

/*
    <BETWEEN AND> [문법]
    WHERE 비교대상컬럼 BETWEEN 하한값 AND 상한값
        
    - WHERE 절에서 사용되는 구문으로 범위에 대한 조건을 제시할 때 사용.
    - 비교대상컬럼 값이 하한값 이상, 상한값 이하인 경우 TRUE를 리턴한다.
    
    <NOT> : 부정
    - 컬럼명 앞 
    - BETWEEN 앞
*/
-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하가 아닌 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서 입사일 '90/01/01' ~ '01/01/01'인 사원의 모든 컬럼 조회
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

/*
    <LIKE> [문법]
    WHERE 비교대상칼럼 LIKE '특정 패턴';
            
    - 비교하려는 칼럼 값이 지정된 특정 패턴에 만족할 경우 TRUE를 리턴한다.
    - 특정 패턴에는 '%', '_'를 와일드카드로 사용할 수 있다.
    '%' : 0글자 이상
    ex) 비교대상칼럼 LIKE '문자%'  => 비교대상칼럼 값 중에 '문자'로 시작하는 모든 행을 조회한다.
        비교대상칼럼 LIKE '%문자'  => 비교대상칼럼 값 중에 '문자'로 끝나는 모든 행을 조회한다.
        비교대상칼럼 LIKE '%문자%' => 비교대상칼럼 값 중에 '문자'가 포함되어 있는 모든 행을 조회한다.
        
    '_' : 1글자
    ex) 비교대상칼럼 LIKE '_문자'  => 비교대상칼럼 값 중에 '문자'앞에 무조건 한 글자가 오는 모든 행을 조회한다.
        비교대상칼럼 LIKE '__문자' => 비교대상칼럼 값 중에 '문자'앞에 무조건 두 글자가 오는 모든 행을 조회한다.
*/
-- EMPLOYEE 테이블에서 성이 전 씨인 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 이름 중에 '하'가 포함된 사원의 사원명, 주민번호, 부서 코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--EMPLOYEE 테이블에서 이메일 중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번 사원명, 이메일 조회
-- ex) sun_di@kh.or.kr, yoo_js@kh.or.kr, ...
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 

-- EMPLOYEE 테이블에서 김씨 성이 아닌 직원 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%'


--------------------------------- 실습문제 ---------------------------------

-- 1. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 2. DEPARTMENT 테이블에서 해외영업부에 대한 모든 컬럼 조회
SELECT * FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외%';

--------------------------------- 실습문제 끝 ---------------------------------


/*
    <IS NULL / IS NOT NULL> [문법]
    WHERE 비교대상칼럼 IS [NOT] NULL;
            
    칼럼 값에 NULL이 있을 경우 NULL 값 비교에 사용된다.
    IS NULL : 비교대상칼럼 값이 NULL인 경우 TRUE를 리턴한다.
    IS NOT NULL : 비교대상칼럼 값이 NULL이 아닌 경우 TRUE 리턴한다.  
*/ 
-- EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE BONUS IS NULL;

--EMPLOYEE 테이블에서 관리자(사수)가 없는 사원 이름, 부서 코드 조회 
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- EMPLOYEE 테이블에서 부서 배치를 받진 않았지만 보너스는 받는 사원의 사원명, 부서 코드, 보너스 조회
SELECT EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
    <IN> [문법]
    WHERE 비교대상칼럼 IN('값', '값', '값', ..., '값');
    - 값 목록 중에 일치하는 값이 있을 때 TRUE 리턴한다.
*/
-- EMPLOYEE 테이블에서 D5 부서원들과 D6 부서원들, D8 부서원들의 사원명, 부서 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D8');

/*
    <연산자 우선순위>
    0. ()
    1. 산술 연산자
    2. 연결 연산자
    3. 비교 연산자
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. 논리 연산자 - NOT
    7. 논리 연산자 - AND
    8. 논리 연산자 - OR
*/
-- EMPLOYEE 테이블에서 직급 코드가 J2 또는 J7 직급인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT * FROM EMPLOYEE
WHERE JOB_CODE IN ('J2','J7') AND SALARY >= 2000000;

/*
    <ORDER BY> [문법]
    SELECT 칼럼, 칼럼, ..., 칼럼
    FROM 테이블명
    WHERE 조건식                  OR  OR               [ 대괄호 안 선택사항 ]
    ORDER BY 정렬시키고자 하는 칼럼명|별칭|칼럼 순번 [ASC|DESC] [NULLS FIRST | NULLS LAST];
          
    - SELECT 문에서 가장 마지막에 기입하는 구문으로 실행 또한 가장 마지막에 진행된다.
    - ASC : 오름차순으로 정렬한다. (ASC 또는 DESC 생략 시 기본값)
    - DESC : 내림차순으로 정렬한다.
    - NULLS FIRST : 정렬하고자 하는 칼럼 값에 NULL이 있는 경우 해당 데이터 값을 맨 앞으로 정렬한다.
    - NULLS LAST : 정렬하고자 하는 칼럼 값에 NULL이 있는 경우 해당 데이터 값을 맨 뒤로 정렬한다.
*/
-- EMPLOYEE 테이블에서 BONUS로 오름차순 정렬
SELECT EMP_NAME, BONUS AS BO
FROM EMPLOYEE
ORDER BY BO DESC NULLS LAST;
-- 컬럼명자리에 별칭이 오기도 한다.
-- NULLS FIRST/LAST : NULL값을 제일 앞/뒤에 위치.

-- EMPLOYEE 테이블에서 BONUS로 내림차순 정렬(단, BONUS 값이 일치할 경우 그때는 SALARY 가지고 오름차순정렬)
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC;

-- EMPLOYEE 테이블에서 연봉별 내림차순으로 정렬된 사원의 사원명, 연봉 조회
SELECT EMP_NAME, SALARY*12 AS 연봉
FROM EMPLOYEE
ORDER BY 연봉 DESC;




