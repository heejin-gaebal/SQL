-- ******************************
--DROP SEQ
-- ******************************
DROP SEQUENCE SEQ_MEMBER;
DROP SEQUENCE SEQ_BOARD;

-- ******************************
--DROP TABLE
-- ******************************
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;

-- ******************************
--CREATE SEQ
-- ******************************
CREATE SEQUENCE SEQ_MEMBER NOCACHE NOCYCLE;
CREATE SEQUENCE SEQ_BOARD NOCACHE NOCYCLE;

-- ******************************
--CREATE TABLE
-- ******************************
CREATE TABLE MEMBER (
    NO              NUMBER              PRIMARY KEY
    , USER_ID       VARCHAR2(100)       NOT NULL UNIQUE
    , USER_PWD      VARCHAR2(4000)      NOT NULL
    , USER_NICK     VARCHAR2(100)       NOT NULL
    , CREATED_DATE  TIMESTAMP           DEFAULT SYSDATE
    , DEL_YN        CHAR(1)             DEFAULT 'N' CHECK(DEL_YN IN ('Y','N'))
);


CREATE TABLE BOARD(
    NO              NUMBER          PRIMARY KEY
    , TITLE         VARCHAR2(100)   NOT NULL
    , CONTENT       VARCHAR2(4000)  NOT NULL
    , WRITER_NO     NUMBER          NOT NULL
    , CREATED_DATE  TIMESTAMP       DEFAULT SYSDATE
    , HIT           NUMBER          DEFAULT 0
    , DEL_YN        CHAR(1)         DEFAULT 'N' CHECK(DEL_YN IN ('Y','N'))
);

-- ******************************
-- FOREIGN KEY
-- ******************************
ALTER TABLE BOARD
ADD CONSTRAINT FK_BOARD_MEMBER
FOREIGN KEY (WRITER_NO)
REFERENCES MEMBER;
