-- 사용자 계정 생성
/*
여러줄 주석 ~~
*/

-- 사용자 계정 생성 구문(관리자만 가능)
-- [문법]CREATE USER 계정명 INENTIFIED BY 1234;
-- 계정명앞에 C##~을 붙여줘야함
CREATE USER C##KH IDENTIFIED BY 1234; 

-- 권한부여
-- GRANT 권한1, 권한2,.....TO 계정명;
-- GRANT 접속권한, 객체다루는 권한 TO C##HJ;
GRANT CONNECT, RESOURCE TO C##KH;

-- 권한추가 : 데이터를 넣을 공간을 다룰 권한이 없어서 추가해줌
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;