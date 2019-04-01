DROP TABLE  EDU  CASCADE CONSTRAINTS;
DROP TABLE  PET CASCADE CONSTRAINTS ;
DROP TABLE  MEMBER CASCADE CONSTRAINTS;
DROP TABLE  MESSAGE  CASCADE CONSTRAINTS;
DROP TABLE  PAYMENT  CASCADE CONSTRAINTS;
DROP TABLE  PREBOOKING  CASCADE CONSTRAINTS;
DROP TABLE  PREANSWER CASCADE CONSTRAINTS ;
DROP TABLE  QUESTION  CASCADE CONSTRAINTS;
DROP TABLE  ANSWER  CASCADE CONSTRAINTS;
DROP TABLE  TIPBOARD  CASCADE CONSTRAINTS;
DROP TABLE  TIPBOARD_REPLY  CASCADE CONSTRAINTS;
DROP TABLE  FREEBOARD CASCADE CONSTRAINTS ;
DROP TABLE  FREEBOARD_REPLY  CASCADE CONSTRAINTS;
DROP TABLE  MANAGER CASCADE CONSTRAINTS ;
DROP TABLE  FAQ CASCADE CONSTRAINTS ;
DROP TABLE  REPORT CASCADE CONSTRAINTS ;
DROP TABLE  NOTICE CASCADE CONSTRAINTS ;
DROP TABLE  BOOKING CASCADE CONSTRAINTS ;
DROP TABLE  REVIEW CASCADE CONSTRAINTS ;
DROP TABLE SITTERIMG CASCADE CONSTRAINTS ;
DROP TABLE COUNTVISITOR CASCADE CONSTRAINTS;

CREATE TABLE  EDU  (
    USER_ID    VARCHAR2(100)      NOT NULL,
    EDU_YN    VARCHAR2(100)      NOT NULL,
    SITTER_YN    VARCHAR2(100)      NOT NULL
);

CREATE TABLE  PET  (
    PET_NO    NUMBER      NOT NULL,
    PET_NAME    VARCHAR2(100)      NOT NULL,
    PET_BREADS    VARCHAR2(100),
    PET_DATE    DATE      NOT NULL,
    PET_SIZE    VARCHAR2(100)      NOT NULL,
    PET_GENDER    VARCHAR2(100)      NOT NULL,
    PET_NEUTRALIZE    VARCHAR2(100)      NOT NULL,
    PET_CHARATER    VARCHAR2(100)      NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    PET_ORIGINFILE VARCHAR2(50),
    PET_REFILE VARCHAR2(50)
);
drop sequence seq_petno;
create sequence seq_petno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  MEMBER  (
    USER_ID    VARCHAR2(100)      NOT NULL,
    EMAIL    VARCHAR2(100)      NULL,
    USER_NAME    VARCHAR2(100)      NULL,
    ADDRESS    VARCHAR2(100)      NULL,
    PHONE    VARCHAR2(100)      NULL,
    JOB    VARCHAR2(100)      NULL,
    PETSITTER    VARCHAR2(100)   default 'n'   NULL,
    PRICE    NUMBER      NULL,
    USER_DATE    DATE      NULL,
    PASSWORD    VARCHAR2(100)      NULL,
    USER_DELETE    VARCHAR2(100)  default 'n'   NULL,
    USER_ORIGINFILE VARCHAR2(100) NULL,
    USER_REFILE VARCHAR2(100) NULL,
    naver_code VARCHAR2(100) NULL
);

CREATE TABLE SITTERIMG (
	IMG_NO	VARCHAR2(100)		NOT NULL,
	USER_ID	VARCHAR2(100)		NOT NULL,
	IMG_ORIGINFILE	VARCHAR2(100)		NULL,
	IMG_REFILE	VARCHAR2(100)		NULL
);

drop sequence seq_IMGNO;
create sequence seq_IMGNO
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  MESSAGE  (
    SENDER_ID    VARCHAR2(100)      NOT NULL,
    MESSAGE_TITLE    VARCHAR2(100)      NULL,
    MESSAGE_CONTENT    VARCHAR2(2000)      NULL,
    MESSAGE_READ    VARCHAR2(100)      NULL,
    MESSAGE_DATE    DATE  default sysdate    NULL,
    REICEIVER_ID    VARCHAR2(100)      NOT NULL
);

CREATE TABLE  PAYMENT  (
    BOOKING_NO    NUMBER      NOT NULL,
    PAYMENT_DATE    DATE      NOT NULL,
    PAYMENT_METHOD    VARCHAR2(100)      NOT NULL,
    PAYMENT_YN    VARCHAR2(100)      NOT NULL
);


CREATE TABLE  PREBOOKING  (
    PREBOOKING_NO    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    PREBOOKING_TITLE    VARCHAR2(100)      NOT NULL,
    PREBOOKING_CONTENT    VARCHAR2(100)      NOT NULL,
    PREBOOKING_DATE    DATE   default sysdate   NOT NULL,
    ANSWER_YN    VARCHAR2(100)      NOT NULL
);
drop sequence seq_prebookingno;
create sequence seq_prebookingno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  PREANSWER  (
    PREBOOKING_NO    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    ANSWER_CONTENT    VARCHAR2(4000)      NOT NULL,
    ANSWER_DATE    DATE  default sysdate    NOT NULL
);

CREATE TABLE  QUESTION  (
    QUESTION_NO    NUMBER      NOT NULL,
    QUESTION_TITLE    VARCHAR2(100)      NOT NULL,
    QUESTION_CONTENT    VARCHAR2(4000)      NOT NULL,
    QUESTION_DATE    DATE  default sysdate    NOT NULL,
    REPLY_YN    VARCHAR2(100)      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    QUESTION_ORIGINAL_FILENAME VARCHAR2(100) null,
    QUESTION_RENAME_FILENAME VARCHAR2(100) null,
    QUESTION_REF number not null,
    QUESTION_REPLY_REF number not null,
    QUESTION_REPLY_LEV number not null,
    QUESTION_REPLY_SEQ number not null
);

drop sequence seq_QUESTIONno;
create sequence seq_QUESTIONno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  ANSWER  (
    QUESTION_NO    NUMBER      NOT NULL,
    REPLY_CONTENT    VARCHAR2(4000)      NOT NULL,
    REPLY_DATE    DATE   default sysdate   NOT NULL
);

CREATE TABLE  TIPBOARD  (
    TIPBOARD_NO    NUMBER      NOT NULL,
    TIPBOARD_TITLE    VARCHAR2(100)      NOT NULL,
    TIPBOARD_CONTENT    VARCHAR2(4000)      NOT NULL,
    TIPBOARD_DATE    DATE  default sysdate    NOT NULL,
    TIPBOARD_ORIGINFILE    VARCHAR2(100)      NULL,
    TIPBOARD_VIEWS    NUMBER      NOT NULL,
    TIPBOARD_RECOMMEND    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    TIPBOARD_DELETE    VARCHAR2(100)  default 'n'    NULL,
    TIPBOARD_REFILE    VARCHAR2(100)      NULL
);

drop sequence seq_tipboardno;
create sequence seq_tipboardno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  TIPBOARD_REPLY  (
    TIPREPLY_NO    NUMBER      NOT NULL,
    TIPREPLY_CONTENT    VARCHAR2(600)      NOT NULL,
    TIPREPLY_DATE    DATE  default sysdate    NOT NULL,
    TIP_NO    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    TIPREPLY_DELETE    VARCHAR2(100)  default 'n'    NULL
);
drop sequence seq_tipreplyno;
create sequence seq_tipreplyno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  FREEBOARD  (
    FREEBOARD_NO    NUMBER      NOT NULL,
    FREEBOARD_TITLE    VARCHAR2(100)      NOT NULL,
    FREEBOARD_CONTENT    VARCHAR2(4000)      NOT NULL,
    FREEBOARD_DATE    DATE  default sysdate    NOT NULL,
    FREEBOARD_ORIGINFILE    VARCHAR2(100)      NULL,
    FREEBOARD_VIEWS    NUMBER      NOT NULL,
    FREEBOARD_RECOMMEND    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    FREEBOARD_DELETE    VARCHAR2(100)   default 'n'   NULL,
    FREEBOARD_REFILE    VARCHAR2(100)      NULL
);

drop sequence seq_freeboardno;
create sequence seq_freeboardno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  FREEBOARD_REPLY  (
    FREEREPLY_NO    NUMBER      NOT NULL,
    FREEREPLY_CONTENT    VARCHAR2(600)      NOT NULL,
    FREEREPLY_DATE    DATE  default sysdate    NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    FREEBOARD_NO    NUMBER      NOT NULL,
    FREEBOARD_DELETE    VARCHAR2(100)  default 'n'    NULL
);

drop sequence seq_freereplyno;
create sequence seq_freereplyno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  MANAGER  (
    MANAGER_ID    VARCHAR2(100)      NOT NULL,
    MANAGER_NAME    VARCHAR2(100)      NOT NULL,
    MANAGER_PASSWORD VARCHAR2(100) NOT NULL
);

CREATE TABLE  FAQ  (
    FAQ_NO    NUMBER      NOT NULL,
    FAQ_TITLE    VARCHAR2(100)      NOT NULL,
    FAQ_CONTENT    VARCHAR2(4000)      NOT NULL,
    FAQ_DATE    DATE  default sysdate    NOT NULL,
    MANAGER_ID    VARCHAR2(100)      NOT NULL,
    FAQ_TYPE VARCHAR2(100) NOT NULL
);

drop sequence seq_faqno;
create sequence seq_faqno
start with 1
increment by 1
nocycle
nocache;

drop sequence seq_prebookingno;
create sequence seq_prebookingno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  REPORT  (
    REPORT_NO    NUMBER      NOT NULL,
    REPORT_CONTENT    VARCHAR2(4000)      NOT NULL,
    REPORT_CATEGORY    VARCHAR2(100)      NULL,
    BOARD_NO    NUMBER      NULL,
    USER_ID    VARCHAR2(100)      NOT NULL
);

drop sequence seq_reportno;
create sequence seq_reportno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  NOTICE  (
    NOTICE_NO    NUMBER      NOT NULL,
    NOTICE_TITLE    VARCHAR2(100)      NOT NULL,
    NOTICE_CONTENT    VARCHAR2(4000)      NOT NULL,
    NOTICE_DATE    DATE   default sysdate   NOT NULL,
    NOTICE_ORIGINFILE    VARCHAR2(100)      NULL,
    NOTICE_VIEWS    NUMBER      NOT NULL,
    MANAGER_ID    VARCHAR2(100)      NOT NULL,
    NOTICE_DELETE    VARCHAR2(100)   default 'n'   NOT NULL,
    NOTICE_REFILE    VARCHAR2(100)      NULL
);

drop sequence seq_noticeno;
create sequence seq_noticeno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  BOOKING  (
    BOOKING_NO    NUMBER      NOT NULL,
    CHECKIN_DATE    DATE      NOT NULL,
    CHECKOUT_DATE    DATE      NOT NULL,
    PET_NO    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    BOOKING_PROGRESS    VARCHAR2(100)      NOT NULL,
    BOOKING_ETC    VARCHAR2(100)      NULL,
    SERVICE_KIND    VARCHAR2(100)      NOT NULL,
    PUSER_ID	VARCHAR2(100)	NOT NULL
);

drop sequence seq_bookingno;
create sequence seq_bookingno
start with 1
increment by 1
nocycle
nocache;

CREATE TABLE  REVIEW  (
    REVIEW_NO    NUMBER      NOT NULL,
    USER_ID    VARCHAR2(100)      NOT NULL,
    BOOKING_NO    NUMBER      NOT NULL,
    POINT    VARCHAR2(100)      NOT NULL,
    REVIEW_CONTENT    VARCHAR2(600)      NOT NULL,
    REVIEW_ORIGINFILE    VARCHAR2(100)      NULL,
    REVIEW_REFILE    VARCHAR2(100)      NULL
);
CREATE TABLE countvisitor (
visit_date DATE NOT NULL,
count_visitor NUMBER DEFAULT 0
);

drop sequence seq_reviewno;
create sequence seq_reviewno
start with 1
increment by 1
nocycle
nocache;

ALTER TABLE  EDU  ADD CONSTRAINT  PK_EDU  PRIMARY KEY (
    USER_ID 
);

ALTER TABLE  PET  ADD CONSTRAINT  PK_PET  PRIMARY KEY (
    PET_NO 
);

ALTER TABLE  MEMBER  ADD CONSTRAINT  PK_MEMBER  PRIMARY KEY (
    USER_ID 
);

ALTER TABLE SITTERIMG ADD CONSTRAINT PK_SITTERIMG PRIMARY KEY (
	IMG_NO
);



ALTER TABLE  MESSAGE  ADD CONSTRAINT  PK_MESSAGE  PRIMARY KEY (
    SENDER_ID 
);

ALTER TABLE  PAYMENT  ADD CONSTRAINT  PK_PAYMENT  PRIMARY KEY (
    BOOKING_NO 
);

ALTER TABLE  PREBOOKING  ADD CONSTRAINT  PK_PREBOOKING  PRIMARY KEY (
    PREBOOKING_NO 
);

ALTER TABLE  PREANSWER  ADD CONSTRAINT  PK_PREANSWER  PRIMARY KEY (
    PREBOOKING_NO 
);

ALTER TABLE  QUESTION  ADD CONSTRAINT  PK_QUESTION  PRIMARY KEY (
    QUESTION_NO 
);

ALTER TABLE  ANSWER  ADD CONSTRAINT  PK_ANSWER  PRIMARY KEY (
    QUESTION_NO 
);

ALTER TABLE  TIPBOARD  ADD CONSTRAINT  PK_TIPBOARD  PRIMARY KEY (
    TIPBOARD_NO 
);

ALTER TABLE  TIPBOARD_REPLY  ADD CONSTRAINT  PK_TIPBOARD_REPLY  PRIMARY KEY (
    TIPREPLY_NO 
);

ALTER TABLE  FREEBOARD  ADD CONSTRAINT  PK_FREEBOARD  PRIMARY KEY (
    FREEBOARD_NO 
);

ALTER TABLE  FREEBOARD_REPLY  ADD CONSTRAINT  PK_FREEBOARD_REPLY  PRIMARY KEY (
    FREEREPLY_NO 
);

ALTER TABLE  MANAGER  ADD CONSTRAINT  PK_MANAGER  PRIMARY KEY (
    MANAGER_ID 
);

ALTER TABLE  FAQ  ADD CONSTRAINT  PK_FAQ  PRIMARY KEY (
    FAQ_NO 
);

ALTER TABLE  REPORT  ADD CONSTRAINT  PK_REPORT  PRIMARY KEY (
    REPORT_NO 
);

ALTER TABLE  NOTICE  ADD CONSTRAINT  PK_NOTICE  PRIMARY KEY (
    NOTICE_NO 
);

ALTER TABLE  BOOKING  ADD CONSTRAINT  PK_BOOKING  PRIMARY KEY (
    BOOKING_NO 
);

ALTER TABLE  REVIEW  ADD CONSTRAINT  PK_REVIEW  PRIMARY KEY (
    REVIEW_NO 
);

ALTER TABLE  EDU  ADD CONSTRAINT  FK_MEMBER_TO_EDU_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  PET  ADD CONSTRAINT  FK_MEMBER_TO_PET_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE SITTERIMG ADD CONSTRAINT FK_MEMBER_TO_SITTERIMG_1 FOREIGN KEY (
	USER_ID
)
REFERENCES MEMBER (
	USER_ID
);

ALTER TABLE  MESSAGE  ADD CONSTRAINT  FK_MEMBER_TO_MESSAGE_1  FOREIGN KEY (
    SENDER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  MESSAGE  ADD CONSTRAINT  FK_MEMBER_TO_MESSAGE_2  FOREIGN KEY (
    REICEIVER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  PAYMENT  ADD CONSTRAINT  FK_BOOKING_TO_PAYMENT_1  FOREIGN KEY (
    BOOKING_NO 
)
REFERENCES  BOOKING  (
    BOOKING_NO 
)  ON DELETE CASCADE;

ALTER TABLE  PREBOOKING  ADD CONSTRAINT  FK_MEMBER_TO_PREBOOKING_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  PREANSWER  ADD CONSTRAINT  FK_PREBOOKING_TO_PREANSWER_1  FOREIGN KEY (
    PREBOOKING_NO 
)
REFERENCES  PREBOOKING  (
    PREBOOKING_NO 
);

ALTER TABLE  PREANSWER  ADD CONSTRAINT  FK_MEMBER_TO_PREANSWER_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  QUESTION  ADD CONSTRAINT  FK_MEMBER_TO_QUESTION_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  ANSWER  ADD CONSTRAINT  FK_QUESTION_TO_ANSWER_1  FOREIGN KEY (
    QUESTION_NO 
)
REFERENCES  QUESTION  (
    QUESTION_NO 
);

ALTER TABLE  TIPBOARD  ADD CONSTRAINT  FK_MEMBER_TO_TIPBOARD_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  TIPBOARD_REPLY  ADD CONSTRAINT  FK_TIPBOARD_REPLY_1  FOREIGN KEY (
    TIP_NO 
)
REFERENCES  TIPBOARD  (
    TIPBOARD_NO 
);

ALTER TABLE  TIPBOARD_REPLY  ADD CONSTRAINT  FK_MEMBER_TO_TIPBOARD_REPLY_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  FREEBOARD  ADD CONSTRAINT  FK_MEMBER_TO_FREEBOARD_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  FREEBOARD_REPLY  ADD CONSTRAINT  FK_MEMBER_TO_FREEBOARD_REPLY_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  FREEBOARD_REPLY  ADD CONSTRAINT  FK_FREEBOARD_REPLY_1  FOREIGN KEY (
    FREEBOARD_NO 
)
REFERENCES  FREEBOARD  (
    FREEBOARD_NO 
);

ALTER TABLE  FAQ  ADD CONSTRAINT  FK_MANAGER_TO_FAQ_1  FOREIGN KEY (
    MANAGER_ID 
)
REFERENCES  MANAGER  (
    MANAGER_ID 
);

ALTER TABLE  REPORT  ADD CONSTRAINT  FK_MEMBER_TO_REPORT_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  NOTICE  ADD CONSTRAINT  FK_MANAGER_TO_NOTICE_1  FOREIGN KEY (
    MANAGER_ID 
)
REFERENCES  MANAGER  (
    MANAGER_ID 
);

ALTER TABLE  BOOKING  ADD CONSTRAINT  FK_PET_TO_BOOKING_1  FOREIGN KEY (
    PET_NO 
)
REFERENCES  PET  (
    PET_NO 
) ON DELETE CASCADE;

ALTER TABLE  BOOKING  ADD CONSTRAINT  FK_MEMBER_TO_BOOKING_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
) ON DELETE CASCADE;

ALTER TABLE BOOKING ADD CONSTRAINT FK_MEMBER_TO_BOOKING_2 FOREIGN KEY (
	PUSER_ID
)
REFERENCES MEMBER (
	USER_ID
) on delete cascade;

ALTER TABLE  REVIEW  ADD CONSTRAINT  FK_MEMBER_TO_REVIEW_1  FOREIGN KEY (
    USER_ID 
)
REFERENCES  MEMBER  (
    USER_ID 
);

ALTER TABLE  REVIEW  ADD CONSTRAINT  FK_BOOKING_TO_REVIEW_1  FOREIGN KEY (
    BOOKING_NO 
)
REFERENCES  BOOKING  (
    BOOKING_NO 
);
COMMENT ON COLUMN ANSWER.QUESTION_NO IS '질문 번호';
COMMENT ON COLUMN ANSWER.REPLY_CONTENT IS '답변 내용';
COMMENT ON COLUMN ANSWER.REPLY_DATE IS '답변 날짜';

COMMENT ON COLUMN BOOKING.BOOKING_NO IS '예약 번호';
COMMENT ON COLUMN BOOKING.CHECKIN_DATE IS '체크인 날짜';
COMMENT ON COLUMN BOOKING.CHECKOUT_DATE IS '체크아웃 날짜';
COMMENT ON COLUMN BOOKING.PET_NO IS '펫번호';
COMMENT ON COLUMN BOOKING.USER_ID IS '예약자 아이디';
COMMENT ON COLUMN BOOKING.BOOKING_PROGRESS IS '0: 예약신청/ 1: 예약완료/ 2: 결제대기/ 3: 결제완료';
COMMENT ON COLUMN BOOKING.BOOKING_ETC IS '특이사항';
COMMENT ON COLUMN BOOKING.SERVICE_KIND IS '서비스종류';
COMMENT ON COLUMN BOOKING.PUSER_ID IS '펫시터 아이디';

COMMENT ON COLUMN EDU.USER_ID IS '아이디';
COMMENT ON COLUMN EDU.EDU_YN IS '교육 수료 여부(Y/N)';
COMMENT ON COLUMN EDU.SITTER_YN IS '펫시터 여부(Y/N)';

COMMENT ON COLUMN FAQ.FAQ_NO IS '글 번호';
COMMENT ON COLUMN FAQ.FAQ_TITLE IS '글 제목';
COMMENT ON COLUMN FAQ.FAQ_CONTENT IS '글 내용';
COMMENT ON COLUMN FAQ.FAQ_DATE IS '게시 날짜';
COMMENT ON COLUMN FAQ.MANAGER_ID IS '관리자 아이디';
COMMENT ON COLUMN FAQ.FAQ_TYPE IS '종류';

COMMENT ON COLUMN FREEBOARD.FREEBOARD_NO IS '글 번호';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_TITLE IS '글 제목';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_CONTENT IS '글 내용';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_DATE IS '게시 날짜';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_ORIGINFILE IS '원본 파일명';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_VIEWS IS '조회수';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_RECOMMEND IS '추천수';
COMMENT ON COLUMN FREEBOARD.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_DELETE IS '삭제여부 (Y/N)';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_REFILE IS '수정 파일명';

COMMENT ON COLUMN FREEBOARD_REPLY.FREEREPLY_NO IS '댓글 번호';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEREPLY_CONTENT IS '댓글 내용';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEREPLY_DATE IS '댓글 게시일자';
COMMENT ON COLUMN FREEBOARD_REPLY.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEBOARD_NO IS '원글 번호';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEBOARD_DELETE IS '삭제여부 (Y/N)';

COMMENT ON COLUMN MANAGER.MANAGER_ID IS '관리자 아이디';
COMMENT ON COLUMN MANAGER.MANAGER_NAME IS '관리자명';
COMMENT ON COLUMN MANAGER.MANAGER_PASSWORD IS '비밀번호';

COMMENT ON COLUMN MEMBER.USER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.USER_NAME IS '이름';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.JOB IS '직업';
COMMENT ON COLUMN MEMBER.PETSITTER IS '펫시터회원 여부 0: 일반/ 1: 승인대기중/ 2: 펫시터';
COMMENT ON COLUMN MEMBER.PRICE IS '가격(일)';
COMMENT ON COLUMN MEMBER.USER_DATE IS '생년월일';
COMMENT ON COLUMN MEMBER.PASSWORD IS '비밀번호';
COMMENT ON COLUMN MEMBER.USER_DELETE IS '삭제여부(Y/N)';
COMMENT ON COLUMN MEMBER.USER_ORIGINFILE IS '원본 파일명';
COMMENT ON COLUMN MEMBER.USER_REFILE IS '수정 파일명';

COMMENT ON COLUMN MESSAGE.SENDER_ID IS '보낸사람 아이디';
COMMENT ON COLUMN MESSAGE.MESSAGE_TITLE IS '쪽지 제목';
COMMENT ON COLUMN MESSAGE.MESSAGE_CONTENT IS '쪽지 내용';
COMMENT ON COLUMN MESSAGE.MESSAGE_READ IS '읽음 여부';
COMMENT ON COLUMN MESSAGE.MESSAGE_DATE IS '보낸 날짜';
COMMENT ON COLUMN MESSAGE.REICEIVER_ID IS '받는 사람 아이디';

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '글 번호';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '글 제목';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '글 내용';
COMMENT ON COLUMN NOTICE.NOTICE_DATE IS '게시 일자';
COMMENT ON COLUMN NOTICE.NOTICE_ORIGINFILE IS '원본 파일명';
COMMENT ON COLUMN NOTICE.NOTICE_VIEWS IS '조회수';
COMMENT ON COLUMN NOTICE.MANAGER_ID IS '관리자 아이디';
COMMENT ON COLUMN NOTICE.NOTICE_DELETE IS '삭제여부';
COMMENT ON COLUMN NOTICE.NOTICE_REFILE IS '수정 파일명';

COMMENT ON COLUMN PAYMENT.BOOKING_NO IS '예약 번호';
COMMENT ON COLUMN PAYMENT.PAYMENT_DATE IS '결제 날짜';
COMMENT ON COLUMN PAYMENT.PAYMENT_METHOD IS '결제 방식';
COMMENT ON COLUMN PAYMENT.PAYMENT_YN IS '결제 여부';

COMMENT ON COLUMN PET.PET_NO IS '강아지 번호';
COMMENT ON COLUMN PET.PET_NAME IS '이름';
COMMENT ON COLUMN PET.PET_BREADS IS '견종';
COMMENT ON COLUMN PET.PET_DATE IS '생년월일';
COMMENT ON COLUMN PET.PET_SIZE IS '크기';
COMMENT ON COLUMN PET.PET_GENDER IS '성별(M/F)';
COMMENT ON COLUMN PET.PET_NEUTRALIZE IS '중성화 여부';
COMMENT ON COLUMN PET.PET_CHARATER IS '특징';
COMMENT ON COLUMN PET.USER_ID IS '주인 아이디';
COMMENT ON COLUMN PET.PET_ORIGINFILE IS '원본 파일명';
COMMENT ON COLUMN PET.PET_REFILE IS '수정 파일명';

COMMENT ON COLUMN PREANSWER.PREBOOKONG_NO IS '사전문의번호';
COMMENT ON COLUMN PREANSWER.USER_ID IS '아이디';
COMMENT ON COLUMN PREANSWER.ANSWER_CONTENT IS '답변 내용';
COMMENT ON COLUMN PREANSWER.ANSWER_DATE IS '답변 일자';

COMMENT ON COLUMN PREBOOKING.PREBOOKING_NO IS '사전문의번호';
COMMENT ON COLUMN PREBOOKING.USER_ID IS '아이디';
COMMENT ON COLUMN PREBOOKING.PREBOOKING_TITLE IS '제목';
COMMENT ON COLUMN PREBOOKING.PREBOOKING_CONTENT IS '내용';
COMMENT ON COLUMN PREBOOKING.PREBOOKING_DATE IS '게시일';
COMMENT ON COLUMN PREBOOKING.ANSWER_YN IS '답변 여부(Y/N)';

COMMENT ON COLUMN QUESTION.QUESTION_NO IS '글 번호';
COMMENT ON COLUMN QUESTION.QUESTION_TITLE IS '제목';
COMMENT ON COLUMN QUESTION.QUESTION_CONTENT IS '내용';
COMMENT ON COLUMN QUESTION.QUESTION_DATE IS '게시일자';
COMMENT ON COLUMN QUESTION.REPLY_YN IS '답변여부';
COMMENT ON COLUMN QUESTION.USER_ID IS '아이디';

COMMENT ON COLUMN REPORT.REPORT_NO IS '신고 번호';
COMMENT ON COLUMN REPORT.REPORT_CONTENT IS '신고 내용';
COMMENT ON COLUMN REPORT.REPORT_CATEGORY IS '신고 종류';
COMMENT ON COLUMN REPORT.BOARD_NO IS '글 번호';
COMMENT ON COLUMN REPORT.USER_ID IS '아이디';

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '리뷰 번호';
COMMENT ON COLUMN REVIEW.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN REVIEW.BOOKING_NO IS '예약 번호';
COMMENT ON COLUMN REVIEW.POINT IS '평점';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '내용';
COMMENT ON COLUMN REVIEW.REVIEW_ORGINFILE IS '원본 파일명';
COMMENT ON COLUMN REVIEW.REVIEW_REFILE IS '수정 파일명';

COMMENT ON COLUMN SITTERIMG.IMG_NO IS '이미지 번호';
COMMENT ON COLUMN SITTERIMG.USER_ID IS '아이디';
COMMENT ON COLUMN SITTERIMG.IMG_ORIGINFILE IS '원본 파일명';
COMMENT ON COLUMN SITTERIMG.IMG_REFILE IS '수정파일명';

COMMENT ON COLUMN TIPBOARD.TIPBOARD_NO IS '글 번호';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_TITLE IS '글 제목';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_CONTENT IS '글 내용';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_DATE IS '게시일자';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_ORIGINFILE IS '원본 파일명';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_VIEWS IS '조회수';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_RECOMMEND IS '추천수';
COMMENT ON COLUMN TIPBOARD.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_DELETE IS '삭제여부(Y/N)';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_REFILE IS '수정 파일명';

COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_NO IS '댓글 번호';
COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_CONTENT IS '내용';
COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_DATE IS '게시일자';
COMMENT ON COLUMN TIPBOARD_REPLY.TIP_NO IS '원글 번호';
COMMENT ON COLUMN TIPBOARD_REPLY.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_DELETE IS '삭제 여부(Y/N)';


insert into manager values('manager','매니저이름1','pass01');
insert into notice values(seq_noticeno.nextval,'1번글','1번내용',default,'0',0,'manager','n','0');

insert into member values('user01','user1@naver.com','유저1','서울','010-1111-1111','직업1',default,0,'91/06/18','pass01',default,null,null,null);


insert into tipboard values(seq_tipboardno.nextval,'팁1번글','1번글 내용',default,'0',0,0,'user01',default,'0' );
insert into tipboard values(seq_tipboardno.nextval,'팁2번글','2번글 내용',default,'0',0,0,'user01',default,'0' );

insert into member values('user02','user2@naver.com','유저2','서울','010-1111-1111','직업2',default,0,'91/06/18','pass01',default,null,null,null);
insert into pet values(seq_petno.nextval, '1번펫', '1',sysdate, '대형','수컷','n','사나움','user02',null,null);


insert into faq values(seq_faqno.nextval, 'faqtest', '내용', sysdate, 'manager', '기타');
commit;