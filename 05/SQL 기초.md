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
    
select 이름, 학년, 소속학과, 휴대폰번호
from 학생
where 학년 >= 2 and 소속학과 = '컴퓨터';

select 이름, 학년, 소속학과, 휴대폰번호
from 학생
where (학년 >= 1 and 학년 <= 3) or not 소속학과 = '컴퓨터';

select 이름, 학년, 소속학과
from 학생
where 소속학과 = '컴퓨터' or 소속학과 = '정보통신'
order by 학년 asc;

select *
from 학생
order by 학년 asc, 이름 desc;

-- 카디널리티
select count(*)
from 학생;

-- 널 값이 아닌 주소 행 개수
select count(주소)
from 학생;

select count(*) as 전체학생수1, count(주소) as 주소있는학생수2, count(distinct 주소) as 학생의주소수
from 학생;

select 성별, max(나이) as '최고 나이', min(나이) as 최소나이
from 학생
group by 성별;



select 나이, count(*) as '나이별 학생수;'
from 학생
where 나이 >= 20 and 나이 < 30
group by 나이;

-- 위와 같음 거르고 찾거나 찾고 거르거나의 차이
select 나이, count(*) as '나이별 학생수;'
from 학생
group by 나이
having 나이 >= 20 and 나이 < 30;

-- 집계 함수 값을 기준으로 거르려면 나중에 걸러야 되니까 having을 써야함.?

-- 왜 됨
select 학년, count(*) as '학년별 학생수'
from 학생
where '254df' >= 2
group by 학년;

select 학년, count(*) as '학년별 학생수'
from 학생
group by 학년
having count(*) >= 2;

select 학번, 이름
from 학생
where 이름 like '이__';
```
