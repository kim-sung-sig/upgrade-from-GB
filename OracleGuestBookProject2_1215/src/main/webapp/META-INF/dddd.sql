DROP SEQUENCE guest2_idx_seq;
DROP TABLE MYGUESTBOOK ;
CREATE SEQUENCE guest2_idx_seq;
CREATE TABLE myguestbook(
	idx NUMBER PRIMARY KEY ,
	title varchar2(50) NOT NULL ,
	name varchar2(50) NOT null,
	password varchar2(50) NOT NULL ,
	content varchar2(2000) NOT NULL ,
	regdate timestamp DEFAULT sysdate,
	vcount NUMBER,
	ip varchar2(50)
)

SELECT * FROM MYGUESTBOOK m ;

INSERT INTO MYGUESTBOOK m VALUES (guest2_idx_seq.nextval,'햄버거','중운쌤','1234','햄버거 사주세요',sysdate,'127.0.0.1');
