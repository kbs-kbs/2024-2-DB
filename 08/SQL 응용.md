## 1. 내장 함수
### 1-1. SQL 내장 함수와 사용자 정의 함수의 구분
#### SQL 내장 함수 (Built-in Functions)
- 데이터베이스 시스템에서 기본적으로 제공하는 함수들입니다.
- 데이터베이스 시스템에 내장되어 있어 별도의 정의나 설치 없이 바로 사용할 수 있습니다.
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

### 사용자 정의 함수 (User-defined Functions)
- 사용자가 직접 정의하여 데이터베이스 시스템에 추가하는 함수들입니다.
- **예시**:
  ```sql
  create function calculate_bonus(salary decimal(10, 2))
  returns decimal(10, 2)
  begin
    return salary * 0.1;
  end;

  select calculate_bonus(salary) from employees;
  ```

> `DECIMAL(10, 2)`는 숫자 데이터 타입을 정의할 때 사용됩니다. 여기서 `(10, 2)`는 숫자의 전체 자릿수와 소수점 이하 자릿수를 나타냅니다:
>
> - **10**: 전체 자릿수 (정수부와 소수부를 포함한 총 자릿수)
> - **2**: 소수점 이하 자릿수
>
> 따라서 `DECIMAL(10, 2)`는 최대 10자리 숫자를 저장할 수 있으며, 그 중 2자리는 소수점 이하 자릿수로 사용됩니다. 예를 들어, `12345678.90`와 같은 숫자를 저장할 수 있습니다.
> 
> 이렇게 하면 숫자의 정밀도를 제어할 수 있으며, 특히 금액이나 정확한 계산이 필요한 경우에 유용합니다.
> 정밀도를 지정하지 않으면 기본값이 사용됩니다. MySQL에서는 DECIMAL 타입의 기본값이 DECIMAL(10, 0)으로 설정됩니다.

## 2. 저장 프로시저
   - 저장 프로시저의 개념과 장점
   - CREATE PROCEDURE 문을 사용하여 저장 프로시저 생성
   - 저장 프로시저 호출 및 수정 방법
   - DROP PROCEDURE 명령문을 사용하여 저장 프로시저 삭제

## 3. 트리거
   - 트리거의 개념과 사용 목적
   - CREATE TRIGGER 명령문을 사용하여 트리거 생성
   - 트리거의 생성 및 실행 방법
   - DROP TRIGGER 명령문을 사용하여 트리거 삭제

## 4. 사용자 정의 함수
   - 사용자 정의 함수의 개념과 장점
   - CREATE FUNCTION 명령문을 사용하여 사용자 정의 함수 생성
   - 사용자 정의 함수의 적용 방법
   - DROP FUNCTION 명령문을 사용하여 사용자 정의 함수 삭제

## 5. 트랜잭션
   - 트랜잭션의 개념과 ACID 특성
   - 트랜잭션의 종류와 예시
   - 트랜잭션 로그와 체크 포인트
   - 트랜잭션과 록의 개념 및 관리 방법


p.31 까지
5.3 트랜젝션과 로그부터 안함


MySQL은 사용자가 직접 정의하고 생성할 수 있는 저장 프로시저, 트리거, 트랜잭션을 지원합니다.

저장 프로시저: 사용자가 미리 작성하여 데이터베이스에 저장한 SQL 문장들의 묶음입니다. CREATE PROCEDURE 문을 사용하여 생성할 수 있습니다.

트리거: 특정 이벤트(예: INSERT, UPDATE, DELETE)가 발생할 때 자동으로 실행되는 SQL 문장입니다. CREATE TRIGGER 문을 사용하여 생성할 수 있습니다.

트랜잭션: 여러 SQL 문장을 하나의 작업 단위로 묶어 처리하는 기능입니다. START TRANSACTION, COMMIT, ROLLBACK 명령어를 사용하여 트랜잭션을 제어할 수 있습니다.