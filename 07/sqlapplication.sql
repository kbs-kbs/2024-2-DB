CREATE DATABASE IF NOT EXISTS univDB;
USE univDB;
CREATE TABLE 학생 (
학번 char(4) not null,
이름 varchar(20) not null,
주소 varchar(50) null DEFAULT '미정',
학년 int not null,
나이 int null,
성별 char(1) not null,
휴대폰번호 char(14) null,
소속학과 varchar(20) null,
primary key (학번)
);

create table 과목 (
과목번호 char(4) not null primary key,
이름 varchar(20) not null,
강의실 char(3) not null,
개설학과 varchar(20) not null,
시수  int not null
); 

CREATE table 수강 (
학번 char(6) not null,
과목번호 char(4) not null,
신청날짜 date not null,
중간성적 int null default 0,
기말성적 int null default 0,
평가학점 char(1) null,
primary key (학번, 과목번호)
);

insert into 학생 values ('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터');
insert into 학생 values ('s002', '홍길동', default, 1, 26, '남', null, '통계');
insert into 학생 values ('s003', '이승엽', null, 3, 30, '남', null, '정보통신');
insert into 학생 values ('s004', '이영애', '경기 분당', 2, null, '여', '010-4444-5555', '정보통신');
insert into 학생 values ('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터');
insert into 학생 values ('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터');
insert into 학생 values ('s007', '이은진', '경기 과천', 1, 23, '여', '010-2222-3333', '컴퓨터');
insert into 과목 values ('c001', '데이터베이스', '126', '컴퓨터', 3);
insert into 과목 values ('c002', '정보보호', '137', '정보토신', 3);
insert into 과목 values ('c003', '모바일웹', '128', '컴퓨터', 3);
insert into 과목 values ('c004', '철학개론', '117', '철학', 2);
insert into 과목 values ('c005', '정보글쓰기', '120', '교양학부', 1);
insert into 수강 values ('s001', 'c002', '2019-09-03', 93, 98, 'A');
insert into 수강 values ('s004', 'c005', '2019-03-03', 72, 78, 'C');
insert into 수강 values ('s003', 'c002', '2019-09-06', 85, 82, 'B');
insert into 수강 values ('s002', 'c001', '2019-03-10', 31, 50, 'F');
insert into 수강 values ('s001', 'c004', '2019-03-05', 82, 89, 'B');
insert into 수강 values ('s004', 'c003', '2019-09-03', 91, 94, 'A');
insert into 수강 values ('s001', 'c005', '2019-09-03', 94, 79, 'C');
insert into 수강 values ('s003', 'c001', '2019-03-03', 81, 92, 'B');
insert into 수강 values ('s004', 'c002', '2019-03-05', 92, 95, 'A');

show tables;

desc 과목;

select * from 과목;
select * from 학생;
select * from 수강;

SELECT ABS(+17) as '절댓값(+17)', ABS(-17) as '절댓값(+17)', CEIL(3.28) as '올림(3.28)', FLOOR(4.259) as '내림(4.29)';

SELECT 학번, SUM(기말성적)/COUNT(*), ROUND(SUM(기말성적)/COUNT(*), 2)
FROM 수강
GROUP BY 학번;

SELECT 
substring(주소,1,2),
substr(주소,1,2),
주소,
REPLACE(SUBSTRING(휴대폰번호, 5, 9), '-', ','),
휴대폰번호,
주소
FROM 학생;

SELECT
신청날짜,
LAST_DAY(신청날짜) -- 마지막날 반환
FROM 수강
WHERE YEAR(신청날짜) = '2019';

SELECT
SYSDATE(),
DATEDIFF(신청날짜, '2019-01-01'),	-- 신청날짜 기분 날짜수 차이 반환
신청날짜
FROM 수강;

SELECT 신청날짜,
DATE_FORMAT(신청날짜, '%b/%d/%y'),
DATE_FORMAT(신청날짜, '%Y년%c월%e일')
FROM 수강;

delimiter //
create procedure InsertOrUpdateCourse (
  in CourseNo VARCHAR(4),
  in CourseName VARCHAR(20),
  in CourseRoom CHAR(3),
  in CourseDept VARCHAR(20),
  in CourseCredit int
)
BEGIN
  declare Count int;	-- 지역변수
SELECT COUNT(*) INTO Count FROM 과목 WHERE 과목번호 = CourseNo;
IF (Count = 0) THEN
  insert into 과목 (과목번호, 이름, 강의실, 개설학과, 시수)
    values (CourseNo, CourseName, CourseRoom, CourseDept, CourseCredit);
ELSE
  update 과목
  set 이름 = CourseName
				, 강의실 = CourseRoom
                , 개설학과 = CourseDept
                , 시수 = CourseCredit
		  where 과목번호 = CourseNo;
	END IF;
END //
delimiter ;

-- 'InsertOrUpdateCourse' 저장 프로시저를 호출하여 '과목' 테이블에 '연극학개론'과목을 등록하시오.
-- 연극학개론 정보가 과목 테이블에 등록되어 있는지 확인한다.
select * from 과목 where 이름='연극학개론';
-- 정보 등록
CALL InsertOrUpdateCourse('c006', '연극학개론', '310', '교양학부', 2);
-- 정상등록 여부 확인
select * from 과목;

-- 예제 7-3
-- 'InsertOrUpdateCourse' 저장 프로시저를 호출하여 '과목' 테이블의 '연극학개론' 과목 강의실을 '410'으로 수정하시오
CALL InsertOrUpdateCourse('c006', '연극학개론', '410', '교양학부', 2);

-- 변경확인
select * from 과목 where 이름='연극학개론';

-- 검색 저장 프로시저의 생성
-- 7-4 '수강' 테이블에서 중간 성적 혹은 기말 성적으로 특정 점수 이상을 받는 학생수를 반환하는
-- 'SelectAverageOfBestScore' 프로시저를 작성하시오.
delimiter //
create procedure SelectAverageOfBestScore (
	in Score int
    , out Count int)
BEGIN
	declare NoMoreData int default false;
	declare Midterm int;
	declare Final int;
	declare Best int;
	declare ScoreListCursor CURSOR FOR
		SELECT 중간성적, 기말성적 FROM 수강;
	declare CONTINUE HANDLER FOR NOT FOUND SET NoMoreData = TRUE;
		set Count = 0;
	OPEN ScoreListCursor;
    REPEAT    
		FETCH ScoreListCursor INTO Midterm, Final;
        IF Midterm > Final THEN
			SET Best = Midterm;
		ELSE
			SET Best = Final;
		END IF;
        IF (Best >= Score) THEN
			SET Count = Count + 1;
		END IF;
	UNTIL NoMoreData END REPEAT;
	CLOSE ScoreListCursor;
END;
//
DELIMITER ;

-- 예제 7-5
-- SelectAverageOfBestScore 저장 프로시저를 호출하는 중간 혹은 기말 성적 중 95점 이상 받은 학생수를 검색하시오.
-- 행 검색 예
CALL SelectAverageOfBestScore(95, @Count);
SELECT @Count;


-- 저장 프로시저의 삭제
-- 예제 7-6 'SelectAverageOfBestScore 프로시저를 삭제하시오.
DROP PROCEDURE SelectAverageOfBestScore;

-- 트리거
-- 예제 7-7 '학생' 테이블에 행이 삽입되면 '남녀학생총수' 테이블의 
-- 			'남'학생 또는 '여"학생의 인원수를 1만큼씩 자동으로 증가시키는 트리거를 작성하시오.
-- 임시테이블 남녀학생총수 테이블을 생성한다.
CREATE TABLE 남녀학생총수
( 성별 CHAR(1) NOT NULL default 0
, 인원수 INT NOT NULL DEFAULT 0
, PRIMARY KEY (성별));

-- 남녀학생 수를 임시테이블 남녀학생총수 테이블에 입력한다.
INSERT INTO 남녀학생총수 SELECT '남', COUNT(*) FROM 학생 WHERE 성별='남';
INSERT INTO 남녀학생총수 SELECT '여', COUNT(*) FROM 학생 WHERE 성별='여';
SELECT * FROM 남녀학생총수;

-- 트리거를 생성한다.
DELIMITER //
CREATE TRIGGER AfterInsertStu
after insert on 학생 for each row
begin
	if (new.성별='남') then
		update 남녀학생총수 set 인원수 = 인원수 + 1 where 성별='남';
	elseif (new.성별='여') then
		update 남녀학생총수 set 인원수 = 인원수 + 1 where 성별='여';
	end if;
end;
//
delimiter ;

-- 트리거 실행
insert into 학생 values ('s008', '최동석', '경기 수원', 2, 26, '남', '010-8888-6666', '컴퓨터');

select * from 학생;
select * from 남녀학생총수;

show triggers;

-- 트리거 삭제
DROP TRIGGER AfterInsertStu;
SHOW TRIGGERS; -- 트리거 삭제여부 확인

/* 4.1 사용자 정의 함수 */
-- '수강' 테이블에서 학생의 학점이 A이면 '최우수', B이면 '우수', C이면 '보통', D나 F이면 '미흡'으로 변화한여 사용자 정의 함수를 작성하시오.

delimiter //
CREATE FUNCTION Fn_Grade(grade char(1))
returns varchar(10)
begin
	declare ret_grade varchar(10);
    if (grade = 'A') then
		set ret_grade = '최우수';
	elseif(grade = 'B') then
		set ret_grade = '우수';
	elseif(grade = 'C') then
		set ret_grade = '보통';
	elseif(grade = 'D' or grade = 'F') then
		set ret_grade = '미흡';
	end if;
    return ret_grade;
end
//
delimiter ;

-- mySQL function 생성 시 1418에러 해결 방법
show global variables like 'log_bin_trust_function_creators'; 
SET GLOBAL log_bin_trust_function_creators = 1;
show global variables like 'log_bin_trust_function_creators'; 

select 학번, 과목번호, 평가학점, Fn_Grade(평가학점) as '평가등급' from 수강;

-- 트랜젝션
START transaction;
	DELETE FROM 학생 WHERE 성별 = '남';
    SELECT * FROM 학생;
rollback;
    SELECT * FROM 학생;
    
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
--  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- Edit > Preferences > SQL Editor 항목 Other -> Safe Updaes (rejects UPDATEs and DELETEs with no rstrictions)

select @@autocommit; -- 자동 commit 설정상태를 확인(기본 : 자동)
set @@autocommit=1;

SET SQL_SAFE_UPDATES = 0;

set transaction isolation level read uncommitted;	-- 고립수준 0
set transaction isolation level read committed;		-- 고림수준 1
set transaction isolation level repeatable read;	-- 고립수준 2
set transaction isolation level serializable;		-- 고립수준 3

use univDB;
create table 고객 select 이름, 나이, 성별 from 학생;
select * from 고객;

SET SQL_SAFE_UPDATES = 0;
USE univDB;
SET transaction isolation level read committed; -- 고립수준 1

start transaction;
select * from 고객;
select * from 고객;	-- 대기상태(이전 버전을 읽음)
update 고객 set 나이 = 나이+100; -- 대기상태
select * from 고객;
rollback;
select * from 고객;

select @@autocommit; -- 자동 commit 설정상태를 확인(기본 : 자동)
set @@autocommit=0;

delete from 과목 where 이름='연극학개론';
select * from 과목;
insert into 과목 values ('c008', '독서와토론', '111', '교양학부', 2);
select * from 과목;
rollback;
select * from 과목;
set autocommit=1;