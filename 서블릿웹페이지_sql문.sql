-- ************************************************************
-- MEMBER
-- ************************************************************
-- 회원가입
INSERT INTO MEMBER
(
    NO
    ,USER_ID
    ,USER_PWD
    ,USER_NICK
)
VALUES
(
    SEQ_MEMBER.NEXTVAL
    , 'USER01'
    , '1234'
    , 'NICK01'
)
;
-- 로그인
SELECT
    NO
    ,USER_ID
    ,USER_PWD
    ,USER_NICK
    ,CREATED_DATE
    ,DEL_YN
FROM MEMBER
WHERE USER_ID = 'USER01' AND USER_PWD = '1234' AND DEL_YN = 'N';

-- 마이페이지 (조회)
SELECT
    NO
    ,USER_ID
    ,USER_PWD
    ,USER_NICK
    ,CREATED_DATE
    ,DEL_YN
FROM MEMBER WHERE USER_ID = 'USER01';

-- 회원 탈퇴
UPDATE MEMBER SET DEL_YN = 'Y' WHERE USER_ID = 'USER01' AND USER_PWD = '1234';

-- ******************************
-- BOARD
-- ******************************
-- 게시글 작성
INSERT INTO BOARD
(
    NO
    ,TITLE
    ,CONTENT
    ,WRITER_NO
)
VALUES
(
    SEQ_BOARD.NEXTVAL
    , 'TITLE01'
    , 'CONTENT01'
    , 1
)
;
-- 게시글 목록조회
SELECT
    NO
    ,TITLE
    ,CONTENT
    ,WRITER_NO
    ,CREATED_DATE
    ,HIT
    ,DEL_YN
FROM BOARD
WHERE DEL_YN = 'N'
ORDER BY NO DESC
;
-- 게시글 상세조회(조회수 증가)
UPDATE BOARD SET HIT = HIT+1 WHERE NO=1 AND DEL_YN = 'N';

-- 게시글 상세조회
SELECT
NO
    ,TITLE
    ,CONTENT
    ,WRITER_NO
    ,CREATED_DATE
    ,HIT
    ,DEL_YN
FROM BOARD WHERE NO = 1 AND DEL_YN = 'N';

-- 게시글 수정
UPDATE BOARD SET
        TITLE = '수정한제목01'
        , CONTENT = '수정한내용01'
    WHERE NO = 1 AND DEL_YN = 'N';
    
-- 게시글 삭제
UPDATE BOARD SET DEL_YN = 'Y' WHERE NO = 1;











