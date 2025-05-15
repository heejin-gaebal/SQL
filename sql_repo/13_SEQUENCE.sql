/*
    <SEQUENCE> 정수값을 순차적으로 생성하는 역할을 하는 객체이다.
        
    <SEQUENCE 생성>
    [문법]
    CREATE SEQUNCE 시퀀스명
    [START WITH 숫자]
    [INCREMENT BY 숫자] 증가값
    [MAXVALUE 숫자]     최대값
    [MINVALUE 숫자]     최소값
    [CYCLE | NOCYCLE]   옵션
    [CACHE 바이트크기 | NOCACHE]; (기본값 20 바이트)
        
    [사용 구문]
    시퀀스명.CURRVAL : 현재 시퀀스의 값
    시퀀스명.NEXTVAL : 시퀀스 값을 증가시키고 증가된 시퀀스 값
                      (기존 시퀀스 값에서 INCREAMENT 값 만큼 증가된 값)
                          
    * 캐시메모리
    - 데이터를 미리 가져오는 것 : 캐싱
    - 미리 다음 값들을 생성해서 저장해둔다.
    - 매번 호출할 때마다 시퀀스 값을 새로 생성을 하는 것이 아닌 캐시 메모리 공간에 미리 생성된 값들을 사용한다.
*/
--CREATE SEQUENCE ABC; 뷰객체가 ABC이름을 사용하고있으므로 생성불가
CREATE SEQUENCE SEQ_MEMBER; 

SELECT SEQ_MEMBER.NEXTVAL FROM DUAL; -- 증가되는 시퀀스 값.
SELECT SEQ_MEMBER.CURRVAL FROM DUAL; -- 현재 시퀀스 값.

DROP SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_MEMBER NOCACHE NOCYCLE; 



DROP TABLE MEMBER CASCADE CONSTRAINTS;
-- NO에 기본키 설정
CREATE TABLE MEMBER(
    NO              NUMBER          DEFAULT SEQ_MEMBER.NEXTVAL PRIMARY KEY
    , ID            VARCHAR2(100)   NOT NULL UNIQUE
    , PWD           VARCHAR2(100)   CHECK( LENGTH(PWD) >= 4 )
    , NICK          VARCHAR2(100)   
    , ENROLL_DATE   TIMESTAMP       DEFAULT SYSDATE
);

-- ENROLL_DATE는 디폴트이므로 INSERT 생략
-- NO의 데이터 값에 시퀀스문 넣기
INSERT INTO MEMBER (
    ID
    ,PWD
    ,NICK
) VALUES(
    'USER05'
    ,'1234'
    ,'HELLO'
);
















