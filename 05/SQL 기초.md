```sql
select version();
select current_date(), current_time(), now();
select user();
show databases;

drop database if exists univDB;
create database if not exists univDB;

use univDB;

create table 학생 (
  학번 char(4) not null,
  이름 varchar(20) not null,
	주소 varchar(50) null default '미정',
  학년 int null,
  나이 int null,
  성별 char(1) not null,
  휴대폰번호 char(14) null,
  소속학과 varchar(20) null,
  primary key(학번)
);
    
insert into 학생
  values ('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터');
insert into 학생
  values ('s002', '홍길동', default, 1, 26, '남', null, '통계');
insert into 학생
  values ('s003', '이승엽', null, 3, 30, '남', null, '정보통신');
insert into 학생
  values ('s004', '이영애', '경기 분당', 2, null, '여', '010-4444-5555', '정보통신');
insert into 학생
  values ('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터');
insert into 학생
  values ('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터');
insert into 학생
  values ('s007', '이은진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영');

select *
  from 학생;

select 이름, 주소
  from 학생;

select 학번, 이름, 주소, 학년, 나이, 성별, 휴대폰번호, 소속학과
  from 학생;

select distinct 소속학과
	from 학생;
```
