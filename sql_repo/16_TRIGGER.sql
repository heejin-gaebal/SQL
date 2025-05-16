/*
    <TRIGGER>
    테이블이 INSERT, UPDATE, DELETE 등 DML 구문에 의해서 변경될 경우
    자동으로 실행될 내용을 정의해놓는 객체이다.
    
    * 트리거의 종류
    1) SQL 문의 실행 시기에 따른 분류
    - BEFORE TRIGGER : 해당 SQL 문장 실행 전에 트리거를 실행한다.
    - AFTER TRIGGER : 해당 SQL 문장 실행 후에 트리거를 실행한다.
  
    2) SQL 문에 의해 영향을 받는 행에 따른 분류
    - 문장 트리거 : 해당 SQL 문에 한 번만 트리거를 실행한다.
    - 행 트리거 : 해당 SQL 문에 영향을 받는 행마다 트리거를 실행한다.
        
    [문법]
    CREATE OR REPLACE TRIGGER 트리거명
    BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명
    [FOR EACH ROW]
    DECLARE
        선언부
    BEGIN
        실행부
    EXCEPTION
        예외처리부
    END;
    /
*/

CREATE TABLE PRODUCT(
    NAME VARCHAR2(100),
    STOCK NUMBER
);
INSERT INTO PRODUCT(NAME, STOCK)VALUES('우산', 100);
INSERT INTO PRODUCT(NAME, STOCK)VALUES('그립톡', 300);
INSERT INTO PRODUCT(NAME, STOCK)VALUES('텀블러', 400);

CREATE TABLE PRODUCT_ORDER(
    NAME VARCHAR2(100),
    CNT NUMBER
);

INSERT INTO PRODUCT_ORDER(NAME, CNT)VALUES('우산', 5);
INSERT INTO PRODUCT_ORDER(NAME, CNT)VALUES('그립톡', 3);
INSERT INTO PRODUCT_ORDER(NAME, CNT)VALUES('텀블러', 10);

SELECT * FROM PRODUCT;
SELECT * FROM PRODUCT_ORDER;

UPDATE PRODUCT 
    SET STOCK = STOCK - 5
    WHERE NAME = '우산';

CREATE OR REPLACE TRIGGER T01
AFTER INSERT ON PRODUCT_ORDER
FOR EACH ROW -- 행트리거
BEGIN
    UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.CNT -- 새롭게 INSERT하는 행에 CNT
        WHERE NAME = :NEW.NAME;
END;
/











