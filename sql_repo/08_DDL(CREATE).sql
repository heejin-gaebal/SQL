/*
    <DDL(Data Definition Language)>
    데이터 정의 언어로 오라클에서 제공하는 객체를 만들고(CREATE), 변경하고(ALTER), 삭제하는(DROP) 등
    실제 데이터 값이 아닌 데이터의 구조 자체를 정의하는 언어로 DB 관리자, 설계자가 주로 사용한다.

    * 오라클에서의 객체 : 테이블, 뷰, 시퀀스, 인덱스, 트리거, 프로시져, 함수, 사용자 등등
        
    <CREATE>
    데이터베이스의 객체를 생성하는 구문이다.
    
    <TABLE(테이블)>
    테이블은 행과 열로 구성되는 가장 기본적인 데이터베이스 객체로 데이터베이스 내에서 모든 데이터는 테이블에 저장된다.
        
    <테이블 생성> [문법]
    CREATE TABLE 테이블명 (
        칼럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
        칼럼명 자료형(크기) [DEFAULT 기본값] [제약조건],...
    );
*/

CREATE TABLE BOOK(
    TITLE VARCHAR2(100),
    PRICE NUMBER
);

SELECT * FROM BOOK;

DROP TABLE BOOK;

-- 회원에 대한 데이터를 담을 수 있는 MEMBER 테이블 생성
DROP TABLE MEMBER;
CREATE TABLE MEMBER(        -- 제약조건 : 순서상관X / DEFAULT는 항상 먼저
    ID VARCHAR2(100)        PRIMARY KEY,
    PASSWORD VARCHAR2(100)  CHECK(LENGTH(PASSWORD) >= 4),
    NICKNAME VARCHAR2(100),
    ENROLL_DATE TIMESTAMP   DEFAULT SYSDATE
);
DESC MEMBER;

--테이블 확인
SELECT * FROM MEMBER;
DESC MEMBER;

-- 컬럼에 주석 달기
-- COMMENT ON COLUMN 테이블명.컬럼명 IS 내용;
COMMENT ON COLUMN MEMBER.ID IS '아이디';
COMMENT ON COLUMN MEMBER.PASSWORD IS '패스워드';
COMMENT ON COLUMN MEMBER.NICKNAME IS '닉네임';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '가입일';

/*
    [데이터 딕셔너리(메타 데이터)]
    자원을 효율적으로 관리하기 위한 다양한 객체들의 정보를 저장하는 시스템 테이블이다.
    사용자가 객체를 생성하거나 객체를 변경하는 등의 작업을 할 때 데이터베이스에 의해서 자동으로 갱신되는 테이블이다.
    데이터에 관한 데이터가 저장되어 있다고 해서 메타 데이터라고도 한다.
        
    USER_TABLES      : 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인하는 뷰 테이블이다. 
    USER_TAB_COLUMNS : 테이블, 뷰의 칼럼과 관련된 정보를 조회하는 뷰 테이블이다.
*/

SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS;

INSERT INTO MEMBER(ID,PASSWORD,NICKNAME,ENROLL_DATE) VALUES('USER01','1234','홍길동',SYSDATE);
INSERT INTO MEMBER(ID,PASSWORD,NICKNAME) VALUES('USER02','1234','김철수');
-- 컬럼값에 넣지않으면 NULLR값이 들어감

-------------------------------------------
/*
    <제약 조건(CONSTRAINT)>
    사용자가 원하는 조건의 데이터만 유지하기 위해서 
    테이블 작성 시 각 칼럼에 대해 저장될 값에 대한 제약조건을 설정할 수 있다.
    제약 조건은 데이터 무결성 보장을 목적으로 한다. (데이터의 정확성과 일관성을 유지시키는 것)
        
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
             NULL값X   중복X
    [문법]
    1) 칼럼 레벨
        CRATE TABLE 테이블명 (
            칼럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건, ...
        );
    
    2) 테이블 레벨
        CRATE TABLE 테이블명 (
            칼럼명 자료형(크기), ...
            [CONSTRAINT 제약조건명] 제약조건(칼럼명)
        );
*/

-- 제약 조건확인
DESC USER_CONSTRAINTS;
-- 사용자가 작성한 제약조건 확인
SELECT * FROM USER_CONSTRAINTS;

/*
    <NOT NULL 제약조건 - NULL값 X>
    해당 칼럼에 반드시 값이 있어야만 하는 경우 사용한다.
    삽입/수정 시 NULL 값을 허용하지 않도록 제한한다.
*/
INSERT INTO MEMBER(ID,PASSWORD,NICKNAME) VALUES('USER01','1234','홍길동');

/*
    <UNIQUE 제약조건 - 중복X>
    칼럼의 입력 값에 중복 값을 제한하는 제약조건이다.
    데이터를 삽입/수정 시 기존에 있는 데이터 값 중에 중복되는 값이 있을 경우 삽입/수정되지 않는다.
    제약조건 지정 방식으로 칼럼 레벨, 테이블 레벨 방식 모두 사용 가능하다.
*/

/*
    <CHECK 제약조건>
    칼럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 기록할 수 있다.
    비교 값은 리터럴만 사용 가능하다.(변하는 값이나 함수 사용하지 못한다.)
        
    [문법]
    CHECK(비교연산자)
        CHECK(칼럼 [NOT] IN(값, 값, ...))
        CHECK(칼럼 = 값)
        CHECK(칼럼 BETWEEN 값 AND 값)
        CHECK(칼럼 LIKE '_문자' OR 칼럼 LIKE '문자%')
    
    EX) CHECK(LENGTH(PASSWORD) >= 4) => 패스워드 4글자 이상 체크 통과
*/
INSERT INTO MEMBER(ID,PASSWORD,NICKNAME) VALUES('USER01','000','홍길동');

/*
    <PRIMARY KEY(기본 키) 제약조건>
    테이블에서 한 행의 정보를 식별하기 위해 사용할 칼럼에 부여하는 제약조건이다.
    각 행들을 구분할 수 있는 식별자 역할(사번, 부서 코드, 직급 코드, ..)
    기본 키 제약조건을 설정하게 되면 자동으로 해당 칼럼에 NOT NULL + UNIQUE 제약조건이 설정된다.
    한 테이블에 한 개만 설정할 수 있다.(단, 한 개 이상의 칼럼을 묶어서 PRIMARY KEY로 제약조건을 설정할 수 있다.)
    칼럼 레벨, 테이블 레벨 방식 모두 설정 가능하다.
*/
INSERT INTO MEMBER(ID,PASSWORD,NICKNAME) VALUES('USER01','000','홍길동');

/*
    <FOREIGN KEY(외래 키) 제약조건>
    다른 테이블에 존재하는 값만을 가져야 하는 칼럼에 부여하는 제약조건이다.
    (단, NULL 값도 가질 수 있다.)
    즉, 참조된 다른 테이블이 제공하는 값만 기록할 수 있다. 
    (FOREIGN KEY 제약조건에 의해서 테이블 간에 관계가 형성된다.)
        
    [문법]
    1) 칼럼 레벨
        칼럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명 [(기본키)] [삭제룰]
        
    2) 테이블 레벨
        [CONSTRAINT 제약조건명] FOREIGN KEY(칼럼명) REFERENCES 참조할테이블명 [(기본키)] [삭제룰]
                
    [삭제룰]
    부모 테이블의 데이터가 삭제됐을 때의 옵션을 지정해 놓을 수 있다.
    1) ON DELETE RESTRICT : 자식 테이블의 참조 키가 부모 테이블의 키 값을 참조하는 경우 부모 테이블의 행을 삭제할 수 없다. 
                            (기본적으로 적용되는 옵션)
    2) ON DELETE SET NULL : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 NULL로 변경된다.
    3) ON DELETE CASCADE  : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 존재하는 행 전체가 삭제된다.
*/
DROP TABLE STUDENT;
CREATE TABLE STUDENT(
    STUDENT_NUM NUMBER PRIMARY KEY,
    STUDENT_NAME VARCHAR2(100)
);

DROP TABLE GRADE;
CREATE TABLE GRADE(
    STUDENT_NUM NUMBER REFERENCES STUDENT (STUDENT_NUM),
    SCORE VARCHAR2(1)
);

INSERT INTO STUDENT(STUDENT_NUM, STUDENT_NAME) VALUES(1, '박연진');
INSERT INTO STUDENT(STUDENT_NUM, STUDENT_NAME) VALUES(2, '박희진');
INSERT INTO STUDENT(STUDENT_NUM, STUDENT_NAME) VALUES(3, '박소진');

INSERT INTO GRADE(STUDENT_NUM, SCORE) VALUES(1, 'A');
INSERT INTO GRADE(STUDENT_NUM, SCORE) VALUES(2, 'B');
INSERT INTO GRADE(STUDENT_NUM, SCORE) VALUES(3, 'C');

SELECT * FROM STUDENT;
SELECT * FROM GRADE;

DELETE FROM STUDENT
WHERE STUDENT_NUM = 2;
