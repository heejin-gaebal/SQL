-- 테이블 생성 | -- SQL의 주석 : --
CREATE TABLE BOOK(
    TITLE VARCHAR2(100),
    -- VARCHAR2 는 sql에서 문자열
    PRICE NUMBER
    -- NUMBER는 sql에서 숫자형
);

-- 데이터 추가 : INSERT
INSERT INTO BOOK(TITLE, PRICE) VALUES('해리포터1', 100);
INSERT INTO BOOK(TITLE, PRICE) VALUES('해리포터2', 200);
INSERT INTO BOOK(TITLE, PRICE) VALUES('해리포터3', 300);
-- 데이터 조회 : SELECT
SELECT TITLE, PRICE FROM BOOK;

-- 데이터 삭제 : DELETE
DELETE FROM BOOK WHERE TITLE = '해리포터2';

-- 데이터 수정 : UPDATE

-- 테이블 삭제
DROP TABLE BOOK;

