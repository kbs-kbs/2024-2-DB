# 2024-DB

SQL 문 작성 시 일반적으로 따르는 컨벤션 규칙이 있습니다. 다음은 몇 가지 일반적인 컨벤션 규칙입니다:

1. **내장 함수**:
   - 주로 snake_case를 사용합니다.
   - 예시: `SUM()`, `AVG()`, `DATE_FORMAT()`

2. **사용자 정의 함수**:
   - 일관된 스타일을 유지하는 것이 중요합니다.
   - 주로 PascalCase 또는 camelCase를 사용합니다.
   - 예시: `CalculateBonus()`, `GetEmployeeDetails()`

3. **저장 프로시저**:
   - 사용자 정의 함수와 마찬가지로 일관된 스타일을 유지합니다.
   - 주로 PascalCase 또는 camelCase를 사용합니다.
   - 예시: `CreateNewOrder()`, `UpdateCustomerInfo()`

4. **테이블 및 컬럼 이름**:
   - 주로 snake_case를 사용합니다.
   - 예시: `employee_details`, `order_date`

5. **SQL 키워드**:
   - 대문자로 작성합니다.
   - 예시: `SELECT`, `INSERT`, `UPDATE`, `DELETE`

일반적인 컨벤션 규칙에서 내장 함수와 사용자 정의 함수의 컨벤션이 다르고 내장 함수와 테이블 및 컬럼 이름의 컨벤션이 같다는게 비합리적이지 않은가?

---

SQL 표준에서는 따옴표의 사용에 대해 다음과 같이 정의하고 있습니다.

홑따옴표(`' '`)는 문자열을 나타낼 때 사용됩니다:
  
   ```sql
   SELECT * FROM member WHERE name = 'Alice';
   ```
   
쌍따옴표(`" "`)는 식별자(컬럼명, 테이블명 등)를 나타낼 때 사용됩니다:
   
   ```sql
   SELECT "name", "reg_date" FROM "member";
   ```

하지만 MySQL에서는 다음과 같이 백틱을 사용하여 식별자를 감쌉니다:

```sql
SELECT * FROM `member`;
```

MySQL에서는 홑따옴표와 쌍따옴표를 구분하지 않고 문자열 값을 나타내는 데 사용할 수 있습니다:

```sql
SELECT * FROM member WHERE name = 'Alice';
SELECT * FROM member WHERE name = "Alice";
```


어떤 데이터베이스 시스템에서도 내장 프로시저, 내장 트리거, 내장 트랜잭션은 존재하지 않습니다.