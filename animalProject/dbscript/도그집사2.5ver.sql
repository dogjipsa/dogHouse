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
    naver_code VARCHAR2(100) NULL,
    TITLE_IMG VARCHAR2(100) null,
    REPORT_ADD NUMBER default 0,
    PETSITTER_CONTENT VARCHAR2(3000) NULL
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
    REVIEW_REFILE    VARCHAR2(100)      NULL,
    REVIEW_DATE  DATE  default sysdate    NOT NULL
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
COMMENT ON COLUMN ANSWER.QUESTION_NO IS '霜庚 腰硲';
COMMENT ON COLUMN ANSWER.REPLY_CONTENT IS '岩痕 鎧遂';
COMMENT ON COLUMN ANSWER.REPLY_DATE IS '岩痕 劾促';

COMMENT ON COLUMN BOOKING.BOOKING_NO IS '森鉦 腰硲';
COMMENT ON COLUMN BOOKING.CHECKIN_DATE IS '端滴昔 劾促';
COMMENT ON COLUMN BOOKING.CHECKOUT_DATE IS '端滴焼数 劾促';
COMMENT ON COLUMN BOOKING.PET_NO IS '楢腰硲';
COMMENT ON COLUMN BOOKING.USER_ID IS '森鉦切 焼戚巨';
COMMENT ON COLUMN BOOKING.BOOKING_PROGRESS IS '0: 森鉦重短/ 1: 森鉦刃戟/ 2: 衣薦企奄/ 3: 衣薦刃戟';
COMMENT ON COLUMN BOOKING.BOOKING_ETC IS '働戚紫牌';
COMMENT ON COLUMN BOOKING.SERVICE_KIND IS '辞搾什曽嫌';
COMMENT ON COLUMN BOOKING.PUSER_ID IS '楢獣斗 焼戚巨';

COMMENT ON COLUMN EDU.USER_ID IS '焼戚巨';
COMMENT ON COLUMN EDU.EDU_YN IS '嘘整 呪戟 食採(Y/N)';
COMMENT ON COLUMN EDU.SITTER_YN IS '楢獣斗 食採(Y/N)';

COMMENT ON COLUMN FAQ.FAQ_NO IS '越 腰硲';
COMMENT ON COLUMN FAQ.FAQ_TITLE IS '越 薦鯉';
COMMENT ON COLUMN FAQ.FAQ_CONTENT IS '越 鎧遂';
COMMENT ON COLUMN FAQ.FAQ_DATE IS '惟獣 劾促';
COMMENT ON COLUMN FAQ.MANAGER_ID IS '淫軒切 焼戚巨';
COMMENT ON COLUMN FAQ.FAQ_TYPE IS '曽嫌';

COMMENT ON COLUMN FREEBOARD.FREEBOARD_NO IS '越 腰硲';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_TITLE IS '越 薦鯉';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_CONTENT IS '越 鎧遂';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_DATE IS '惟獣 劾促';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_ORIGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_VIEWS IS '繕噺呪';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_RECOMMEND IS '蓄探呪';
COMMENT ON COLUMN FREEBOARD.USER_ID IS '拙失切 焼戚巨';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_DELETE IS '肢薦食採 (Y/N)';
COMMENT ON COLUMN FREEBOARD.FREEBOARD_REFILE IS '呪舛 督析誤';

COMMENT ON COLUMN FREEBOARD_REPLY.FREEREPLY_NO IS '奇越 腰硲';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEREPLY_CONTENT IS '奇越 鎧遂';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEREPLY_DATE IS '奇越 惟獣析切';
COMMENT ON COLUMN FREEBOARD_REPLY.USER_ID IS '拙失切 焼戚巨';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEBOARD_NO IS '据越 腰硲';
COMMENT ON COLUMN FREEBOARD_REPLY.FREEBOARD_DELETE IS '肢薦食採 (Y/N)';

COMMENT ON COLUMN MANAGER.MANAGER_ID IS '淫軒切 焼戚巨';
COMMENT ON COLUMN MANAGER.MANAGER_NAME IS '淫軒切誤';
COMMENT ON COLUMN MANAGER.MANAGER_PASSWORD IS '搾腔腰硲';

COMMENT ON COLUMN MEMBER.USER_ID IS '焼戚巨';
COMMENT ON COLUMN MEMBER.EMAIL IS '戚五析';
COMMENT ON COLUMN MEMBER.USER_NAME IS '戚硯';
COMMENT ON COLUMN MEMBER.ADDRESS IS '爽社';
COMMENT ON COLUMN MEMBER.PHONE IS '穿鉢腰硲';
COMMENT ON COLUMN MEMBER.JOB IS '送穣';
COMMENT ON COLUMN MEMBER.PETSITTER IS '楢獣斗噺据 食採 0: 析鋼/ 1: 渋昔企奄掻/ 2: 楢獣斗';
COMMENT ON COLUMN MEMBER.PRICE IS '亜維(析)';
COMMENT ON COLUMN MEMBER.USER_DATE IS '持鰍杉析';
COMMENT ON COLUMN MEMBER.PASSWORD IS '搾腔腰硲';
COMMENT ON COLUMN MEMBER.USER_DELETE IS '肢薦食採(Y/N)';
COMMENT ON COLUMN MEMBER.USER_ORIGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN MEMBER.USER_REFILE IS '呪舛 督析誤';

COMMENT ON COLUMN MESSAGE.SENDER_ID IS '左浬紫寓 焼戚巨';
COMMENT ON COLUMN MESSAGE.MESSAGE_TITLE IS '楕走 薦鯉';
COMMENT ON COLUMN MESSAGE.MESSAGE_CONTENT IS '楕走 鎧遂';
COMMENT ON COLUMN MESSAGE.MESSAGE_READ IS '石製 食採';
COMMENT ON COLUMN MESSAGE.MESSAGE_DATE IS '左浬 劾促';
COMMENT ON COLUMN MESSAGE.REICEIVER_ID IS '閤澗 紫寓 焼戚巨';

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '越 腰硲';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '越 薦鯉';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '越 鎧遂';
COMMENT ON COLUMN NOTICE.NOTICE_DATE IS '惟獣 析切';
COMMENT ON COLUMN NOTICE.NOTICE_ORIGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN NOTICE.NOTICE_VIEWS IS '繕噺呪';
COMMENT ON COLUMN NOTICE.MANAGER_ID IS '淫軒切 焼戚巨';
COMMENT ON COLUMN NOTICE.NOTICE_DELETE IS '肢薦食採';
COMMENT ON COLUMN NOTICE.NOTICE_REFILE IS '呪舛 督析誤';

COMMENT ON COLUMN PAYMENT.BOOKING_NO IS '森鉦 腰硲';
COMMENT ON COLUMN PAYMENT.PAYMENT_DATE IS '衣薦 劾促';
COMMENT ON COLUMN PAYMENT.PAYMENT_METHOD IS '衣薦 号縦';
COMMENT ON COLUMN PAYMENT.PAYMENT_YN IS '衣薦 食採';

COMMENT ON COLUMN PET.PET_NO IS '悪焼走 腰硲';
COMMENT ON COLUMN PET.PET_NAME IS '戚硯';
COMMENT ON COLUMN PET.PET_BREADS IS '胃曽';
COMMENT ON COLUMN PET.PET_DATE IS '持鰍杉析';
COMMENT ON COLUMN PET.PET_SIZE IS '滴奄';
COMMENT ON COLUMN PET.PET_GENDER IS '失紺(M/F)';
COMMENT ON COLUMN PET.PET_NEUTRALIZE IS '掻失鉢 食採';
COMMENT ON COLUMN PET.PET_CHARATER IS '働臓';
COMMENT ON COLUMN PET.USER_ID IS '爽昔 焼戚巨';
COMMENT ON COLUMN PET.PET_ORIGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN PET.PET_REFILE IS '呪舛 督析誤';

COMMENT ON COLUMN PREANSWER.PREBOOKONG_NO IS '紫穿庚税腰硲';
COMMENT ON COLUMN PREANSWER.USER_ID IS '焼戚巨';
COMMENT ON COLUMN PREANSWER.ANSWER_CONTENT IS '岩痕 鎧遂';
COMMENT ON COLUMN PREANSWER.ANSWER_DATE IS '岩痕 析切';

COMMENT ON COLUMN PREBOOKING.PREBOOKING_NO IS '紫穿庚税腰硲';
COMMENT ON COLUMN PREBOOKING.USER_ID IS '焼戚巨';
COMMENT ON COLUMN PREBOOKING.PREBOOKING_TITLE IS '薦鯉';
COMMENT ON COLUMN PREBOOKING.PREBOOKING_CONTENT IS '鎧遂';
COMMENT ON COLUMN PREBOOKING.PREBOOKING_DATE IS '惟獣析';
COMMENT ON COLUMN PREBOOKING.ANSWER_YN IS '岩痕 食採(Y/N)';

COMMENT ON COLUMN QUESTION.QUESTION_NO IS '越 腰硲';
COMMENT ON COLUMN QUESTION.QUESTION_TITLE IS '薦鯉';
COMMENT ON COLUMN QUESTION.QUESTION_CONTENT IS '鎧遂';
COMMENT ON COLUMN QUESTION.QUESTION_DATE IS '惟獣析切';
COMMENT ON COLUMN QUESTION.REPLY_YN IS '岩痕食採';
COMMENT ON COLUMN QUESTION.USER_ID IS '焼戚巨';

COMMENT ON COLUMN REPORT.REPORT_NO IS '重壱 腰硲';
COMMENT ON COLUMN REPORT.REPORT_CONTENT IS '重壱 鎧遂';
COMMENT ON COLUMN REPORT.REPORT_CATEGORY IS '重壱 曽嫌';
COMMENT ON COLUMN REPORT.BOARD_NO IS '越 腰硲';
COMMENT ON COLUMN REPORT.USER_ID IS '焼戚巨';

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '軒坂 腰硲';
COMMENT ON COLUMN REVIEW.USER_ID IS '拙失切 焼戚巨';
COMMENT ON COLUMN REVIEW.BOOKING_NO IS '森鉦 腰硲';
COMMENT ON COLUMN REVIEW.POINT IS '汝繊';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '鎧遂';
COMMENT ON COLUMN REVIEW.REVIEW_ORGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN REVIEW.REVIEW_REFILE IS '呪舛 督析誤';

COMMENT ON COLUMN SITTERIMG.IMG_NO IS '戚耕走 腰硲';
COMMENT ON COLUMN SITTERIMG.USER_ID IS '焼戚巨';
COMMENT ON COLUMN SITTERIMG.IMG_ORIGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN SITTERIMG.IMG_REFILE IS '呪舛督析誤';

COMMENT ON COLUMN TIPBOARD.TIPBOARD_NO IS '越 腰硲';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_TITLE IS '越 薦鯉';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_CONTENT IS '越 鎧遂';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_DATE IS '惟獣析切';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_ORIGINFILE IS '据沙 督析誤';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_VIEWS IS '繕噺呪';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_RECOMMEND IS '蓄探呪';
COMMENT ON COLUMN TIPBOARD.USER_ID IS '拙失切 焼戚巨';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_DELETE IS '肢薦食採(Y/N)';
COMMENT ON COLUMN TIPBOARD.TIPBOARD_REFILE IS '呪舛 督析誤';

COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_NO IS '奇越 腰硲';
COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_CONTENT IS '鎧遂';
COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_DATE IS '惟獣析切';
COMMENT ON COLUMN TIPBOARD_REPLY.TIP_NO IS '据越 腰硲';
COMMENT ON COLUMN TIPBOARD_REPLY.USER_ID IS '拙失切 焼戚巨';
COMMENT ON COLUMN TIPBOARD_REPLY.TIPREPLY_DELETE IS '肢薦 食採(Y/N)';



insert into manager values('manager','古艦煽戚硯1','pass01');
insert into notice values(seq_noticeno.nextval,'1腰越','1腰鎧遂',default,'0',0,'manager','n','0');

insert into member values('user01','user1@naver.com','政煽1','辞随','010-1111-1111','送穣1',default,0,'91/06/18','pass01',default,null,null,null,NULL,default,null);
insert into member values('user02','user2@naver.com','政煽2','辞随','010-1111-1111','送穣2',default,0,'91/06/18','pass01',default,null,null,null,null,default,null);
INSERT INTO MEMBER VALUES ( 'tjrghekt', 'tjrghekt@naver.com', '畠掩疑', ' 辞随獣 韻遭姥', '011-1234-1234', '俳持', '2', 80000, sysdate, 1234,'N',NULL,NULL,NULL,null,default,null );
insert into member values ('admin', 1,1,1,1,1,0,10000,  sysdate, '1234','n',null,null,NULL,null,default,null);

insert into tipboard values(seq_tipboardno.nextval,'徳1腰越','1腰越 鎧遂',default,null,0,0,'user01',default,null );
insert into tipboard values(seq_tipboardno.nextval,'徳2腰越','2腰越 鎧遂',default,null,0,0,'user01',default,null );


insert into pet values(seq_petno.nextval, '1腰楢', '1',sysdate, '企莫','呪墜','n','紫蟹崇','user02',null,null);


insert into faq values(seq_faqno.nextval, 'faqtest', '鎧遂', sysdate, 'manager', '奄展');
commit;


INSERT INTO PET VALUES(SEQ_PETNO.NEXTVAL, '含軒', '帖人人', '2010/01/01', '掻莫', 'M', 'N', NULL, 'admin', NULL, NULL );
INSERT INTO PET VALUES(SEQ_PETNO.NEXTVAL, '段坪', '源銅綜', '2018/04/08', '社莫', 'M', 'Y', NULL, 'tjrghekt', NULL, NULL);

INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/01/01', '2019/01/03', 1, 'admin', 1, '設採店球験艦陥',  1, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/01/03', '2019/01/06', 1, 'admin', 3, '蕉奄 設 坐爽室推',  3, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/01/20', '2019/01/22', 1, 'admin', 3, '照括馬室推~',  1, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/02/01', '2019/02/01', 1, 'admin', 3, '暁 人初推!!',  2, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/03/01', '2019/03/01', 1, 'admin', 1, 'ぞしぞし',  0, 'tjrghekt');

INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/04/01', '2019/04/03', 1, 'user01', 1, '設採店球験艦陥',  1, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/01/03', '2019/01/06', 1, 'user01', 3, '蕉奄 設 坐爽室推',  3, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/01/20', '2019/01/22', 1, 'user01', 3, '照括馬室推~',  1, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/02/01', '2019/02/01', 1, 'user01', 3, '暁 人初推!!',  2, 'tjrghekt');
INSERT INTO BOOKING VALUES(seq_bookingno.nextval, '2019/03/01', '2019/03/01', 1, 'user01', 1, 'ぞしぞし',  0, 'tjrghekt');

insert into review values(seq_reviewno.nextval, (select user_id from booking where booking_no = 6), 6, 3, '汐硲翫還 戚腰拭亀 姶紫杯艦陥', null, null, default);
UPDATE BOOKING SET BOOKING_PROGRESS = '4' WHERE BOOKING_NO = 6;
commit;

