show databases;

create database univDB;

show databases;

use univDB;

show tables;

CREATE TABLE 과목2 (
	과목번호 CHAR(4) NOT NULL PRIMARY KEY,
	이름 VARCHAR(20) NOT NULL,
	강의실 CHAR(5) NOT NULL,
	개설학과 VARCHAR(20) NOT NULL,
	시수 INT NOT NULL
);

show tables;

desc 과목2;

CREATE TABLE 학생2 (
	학번 CHAR(4) NOT NULL,
	이름 VARCHAR(20) NOT NULL,
	주소 VARCHAR(50) DEFAULT '미정', 
	학년 INT NOT NULL,
	나이 INT NULL,
	성별 CHAR(1) NOT NULL,
	휴대폰번호 CHAR(13) NULL, 
	소속학과 VARCHAR(20) NULL,
	PRIMARY KEY (학번), 
	UNIQUE (휴대폰번호)
);

show tables;

desc 학생2;

SHOW CREATE TABLE 학생2;

CREATE TABLE 수강2 (
	학번 CHAR(6) NOT NULL,
	과목번호 CHAR(4) NOT NULL,
	신청날짜 DATE NOT NULL,
	중간성적 INT NULL DEFAULT 0,
	기말성적 INT NULL DEFAULT 0, 
	평가학점 CHAR(1) NULL,        
	PRIMARY KEY(학번, 과목번호),
	FOREIGN KEY(학번) REFERENCES 학생2(학번),
	FOREIGN KEY(과목번호) REFERENCES 과목2(과목번호)
);

INSERT INTO 과목2(과목번호, 이름, 강의실, 개설학과, 시수)
VALUES ('c111', 'database', 'A-123', '산업공학', 3);

select * from 과목2;

INSERT INTO 학생2(학번, 이름, 학년, 나이, 성별, 휴대폰번호, 소속학과)
VALUES ('s111', '박태환', 4, NULL, '남', '010-1111-1111', '산업공학');

INSERT INTO 학생2(학번, 이름, 학년, 나이, 성별, 휴대폰번호, 소속학과)
VALUES ('s222', '박태환', 2, NULL, '남', '010-111-1111', '산업공학'); 

select * from 학생2;

INSERT INTO 수강2(학번, 과목번호, 신청날짜)
VALUES ('s111', 'c111', '2019-12-31');
-- ❼ 정상 수행
INSERT INTO 수강2(학번, 과목번호, 신청날짜, 중간성적, 기말성적, 평가학점)
VALUES ('s111', 'c222', '2019-12-31', 93, 98, 'A'); 
-- ❽ 외래키 제약 조건 오류(입력 과목번호 값이 ‘과목2’ 테이블에 존재하지 않음)
INSERT INTO 수강2(학번, 과목번호, 신청날짜, 중간성적, 기말성적, 평가학점)
VALUES ('s111', 'c111', '2019-12-31', 93, 98, 'A'); 
-- ❾ 기본키 제약 조건 오류(기본키 ‘학번’과 ‘과목번호’열의 조합이 중복 값이 존재함)
INSERT INTO 수강2(학번, 과목번호, 신청날짜, 중간성적, 기말성적, 평가학점)
VALUES ('s222', 'c111', '2019-12-31', 93, 98, 'A');
-- ❿ 정상 수행

select * from 수강2;

ALTER TABLE 학생2
ADD 등록날짜 DATETIME NOT NULL DEFAULT '2019-12-30';

desc 학생2;

ALTER TABLE 학생2
DROP COLUMN 등록날짜;

desc 학생2;

ALTER TABLE 학생2
CHANGE 이름 학생이름 VARCHAR(20);

ALTER TABLE 학생2 RENAME TO 재학생2;

desc 재학생2;

DROP TABLE 과목2;     -- 삭제 불가. 과목2를 참조하는 테이블이 있음.
DROP TABLE 수강2;     -- 참조하는 테이블 삭제
DROP TABLE 과목2;     -- 삭제 가능

show tables;

CREATE USER 'user1'@'127.1.1.1' IDENTIFIED BY '1111';
CREATE USER 'user2'@'localhost' IDENTIFIED BY '2222';
CREATE USER 'user3'@'192.182.10.2' IDENTIFIED BY '3333';
CREATE USER 'user4'@'%' IDENTIFIED BY '4444';

SELECT host, user FROM mysql.user;

show databases;

use mysql;

show tables;

desc user;

select host, user from user;

GRANT INSERT, UPDATE, DELETE ON univDB.* TO 'user1'@'127.1.1.1';
GRANT ALL ON *.* TO 'user4'@'%' WITH GRANT OPTION; 
GRANT SELECT ON univDB.재학생2 TO 'user2'@'localhost'; 

SHOW GRANTS FOR 'user1'@'127.1.1.1';  -- user1 사용자의 권한 표시

SHOW GRANTS;                          -- 현재 접속 사용자의 권한 표시

REVOKE DELETE ON univDB.* FROM 'user1'@'127.1.1.1'; 