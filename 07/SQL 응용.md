## 1. SQL 함수
### 1-1. 내장 함수(Built-in Functions)
데이터베이스 시스템에서 기본적으로 제공하는 함수들입니다.
데이터베이스 시스템에 내장되어 있어 별도의 정의나 설치 없이 바로 사용할 수 있습니다.
- **수학 함수**:
  | 리턴 타입 | 함수 | 설명 |
  |-----------|------|------|
  | *decimal* | **abs**(x *decimal*) | 절대값 |
  | *decimal* | **ceil**(x *decimal*) | 올림 |
  | *decimal* | **floor**(x *decimal*) | 내림 |
  | *decimal* | **round**(x *decimal*, d *int*) | 반올림 |
  | *varchar* | **format**(x *decimal*, d *int*) | 형식화 |
- **문자열 함수**:
  | 리턴 타입 | 함수 | 설명 |
  |-----------|------|------|
  | *int* | **length**(str *varchar*) | 문자열 길이 |
  | *varchar* | **substring**(str *varchar*, pos *int*, len *int*) | 부분 문자열 추출 |
  | *varchar* | **concat**(str1 *varchar*, str2 *varchar*) | 문자열 결합 |
  | *varchar* | **replace**(str *varchar*, from_str *varchar*, to_str *varchar*) | 문자열 대체 |
  | *varchar* | **trim**(str *varchar*) | 공백 제거 |
- **날짜 및 시간 함수**:
  | 리턴 타입 | 함수 | 설명 |
  |-----------|------|------|
  | *datetime* | **now**() | 현재 날짜와 시간 |
  | *date* | **curdate**() | 현재 날짜 |
  | *int* | **year**(date *date*) | 연도 추출 |
  | *int* | **month**(date *date*) | 월 추출 |
  | *date* | **last_day**(date *date*) | 해당 월의 마지막 날 |
  | *varchar* | **date_format**(date *date*, format *varchar*) | 날짜 형식 변환 |
- **집계 함수**:
  | 리턴 타입 | 함수 | 설명 |
  |-----------|------|------|
  | *decimal* | **sum**(expr *decimal*) | 합계 |
  | *decimal* | **avg**(expr *decimal*) | 평균 |
  | *int* | **count**(expr any) | 개수 |
  | same as input | **max**(expr any) | 최대값 |
  | same as input | **min**(expr any) | 최소값 |
- **시스템 정보 함수**:
  | 리턴 타입 | 함수 | 설명 |
  |-----------|------|------|
  | *varchar* | **user**() | 현재 사용자 |
  | *varchar* | **database**() | 현재 데이터베이스 |
- **예시**:
  ```sql
  select sum(salary) from employees;
  select length(name) from customers;
  ```

### 1-2. 사용자 정의 함수(User-defined Functions)
- 사용자가 직접 정의하여 데이터베이스 시스템에 추가하는 함수들입니다.
- **예시**:
  ```sql
  CREATE FUNCTION CALCULATE_BONUS(salary DECIMAL(10, 2)) -- 함수 정의
  RETURNS DECIMAL(10, 2)
  BEGIN
    RETURN salary * 0.1;
  END;

  SELECT CALCULATE_BONUS(salary) FROM employees; -- 함수 사용

  DROP FUNCTION CALCULATE_BONUS; -- 함수 삭제
  ```

  ```sql
  DELIMITER //
  CREATE FUNCTION fn_grade(grade CHAR(1))
  RETURNS VARCHAR(10)
  BEGIN
    DECLARE ret_grade VARCHAR(10);
    IF (grade = 'A') THEN
      SET ret_grade = '최우수';
    ELSEIF (grade = 'B') THEN
      SET ret_grade = '우수';
    ELSEIF (grade = 'C') THEN
      SET ret_grade = '보통';
    ELSEIF (grade = 'D' OR grade = 'F') THEN
      SET ret_grade = '미흡';
    END IF;
    RETURN ret_grade;
  END//
  DELIMITER ;
  ```

## 2. 저장 프로시저(Stored Procedure)
사용자가 미리 작성하여 데이터베이스에 저장한 SQL 문장들의 묶음입니다.
- **프로시저 목록 출력**: `SHOW PROCEDURE STATUS;`
- **프로시저 생성**:
  - `DELIMITER`: 구분자 변경
  - `CREATE PROCEDURE 프로시저명`
    - `IN|OUT|INOUT 매개변수명 타입`
  - `BEGIN`
    - `DECLARE 지역변수명 타입`
  - `END`
  <br>
  
  ```sql
  DELIMITER //
  CREATE PROCEDURE InsertOrUpdateCourse(
    IN courseNo VARCHAR(4),
    IN courseName VARCHAR(20),
    IN courseRoom CHAR(3),
    IN courseDept VARCHAR(20),
    IN courseCredit INT
  ) BEGIN
    DECLARE count INT;
    SELECT count(*) INTO count FROM 과목 WHERE 과목번호 = courseNo;
    IF (count = 0) THEN
      INSERT INTO 과목 (과목번호, 이름, 강의실, 개설학과, 시수)
      VALUES (courseNo, courseName, courseRoom, courseDept,   courseCredit);
    ELSE
      UPDATE 과목
      SET
        이름 = courseName,
        강의실 = courseRoom,
        개설학과 = courseDept,
        시수 = courseCredit
      WHERE 과목번호 = courseNo;
    END IF;
  END//
  DELIMITER ;
  ```
- **프로시저 호출**: `CALL PROCEDURE`
- **프로시저 수정**: `ALTER PROCEDURE`
- **프로시저 삭제**: `DROP PROCEDURE`





## 3. 트리거(Trigger)
특정 이벤트(예: INSERT, UPDATE, DELETE)가 발생할 때 자동으로 실행되는 SQL 문장입니다.
- **트리거 목록 출력**: `SHOW TRIGGERS;`
- **트리거 생성**:
  - `DELIMITER`
  - `CREATE TRIGGER`
  - `AFTER|BEFORE INSERT|UPDATE|DELETE ON 속성 FOR EACH ROW`
  - `BEGIN`, `END`
  <br>
  ```sql
  DELIMITER //
  CREATE TRIGGER after_insert_stu
  AFTER INSERT ON 학생 FOR EACH ROW
  BEGIN
    IF (NEW.성별 = '남') THEN -- 삽입될 행의 성별 값이 '남'일 경우
      UPDATE 남녀학생총수
      SET 인원수 = 인원수 + 1
      WHERE 성별 = '남';
    ELSEIF (NEW.성별 = '여') THEN -- 삽입될 행의 성별 값이 '여'일 경우
      UPDATE 남녀학생총수
      SET 인원수 = 인원수 + 1
      WHERE 성별 = '여';
    END IF;
  END//
  DELIMITER ;
  ```
  
- **트리거 삭제**: `DROP TRIGGER after_insert_stu;`

## 4. 트랜잭션
여러 SQL 문장을 하나의 작업 단위로 묶어 처리하는 기능입니다.
### 4-1. 트랜잭션의 독일지원(ACID) 특성
- 독립성 또는 고립성(Isolation)
- 일관성(Consistency)
- 지속성(Durability)
- 원자성(Atomicity)

독일은 동시성 제어 기법(locking)을 통해 유지되며,
지원은 회복 기법(logging)을 통해 유지됩니다.

### 4-2. 트랜잭션의 종류
1. **자동완료 트랜잭션**:
   - `SELECT @@AUTOCOMMIT;`: 시스템 변수 `@@AUTOCOMMIT`을 출력
   - `SET @@AUTOCOMMIT = 1;`: 
2. **수동완료 트랜잭션 또는 명시적 트랜잭션**:
   - `SELECT @@AUTOCOMMIT;`
   - `SET @@AUTOCOMMIT = 0;`
   - `START TRANSACTION;`
   - `COMMIT|ROLLBACK;`
