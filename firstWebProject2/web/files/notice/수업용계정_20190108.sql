-- DAY7

-- SET OPERATOR (집합 연산자)
-- UNION, UNION ALL, INTERSECT, MINUS
-- UNION, UNION ALL (합집합) : 여러 개의 SELECT 문의 결과를 하나로 합침
-- INTERSECT (교집합) : 여러 개의 SELECT 결과에서 공통된 행만 골라냄
-- MINUS (차집합) : 첫번째 SELECT 결과에서 두번째 SELECT 결과와 겹치는 / 일치하는 부분을 뺀 결과만 선택함

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
UNION 
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
MINUS
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- SET 연산자 사용시 주의사항
-- SELECT 절에 컬럼의 갯수가 같아야 함 : 갯수가 안 맞으면 DUMMY 컬럼을 만들어서 맞춰야 함!!
-- SELECT 절의 각 항목별로 자료형이 같아야 함
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- 50번 부서에 소속된 직원 중 관리자와 일반 직원을 따로 조회해서 하나로 합쳐라.
SELECT * FROM EMPLOYEE WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE DEPT_ID = '50' AND EMP_ID <> '141'
ORDER BY 3, 1;

SELECT 'SQL을 공부하고 있습니다' 문장, 3 순서 FROM DUAL
UNION
SELECT '우리는 지금', 1 FROM DUAL
UNION
SELECT '아주 재미있게', 2 FROM DUAL
ORDER BY 2;

-- 집합 연산자와 JOIN의 관계
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- 조인구문에서 USING (EMP_ID, ROLE_NAME)의 의미
-- 두 컬럼의 값을 하나의 값으로 생각하고 일치하는 항목을 찾음
-- (104 SE) = (104 SE) : 같은 값으로 보고 JOIN
-- (104 SE-ANLY) != (104 SE) : 다른 값이라 JOIN X

-- 위의 쿼리문을 JOIN 구문으로 바꾸면
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING (EMP_ID, ROLE_NAME);

-- 집합 연산자와 IN 연산자의 관계
-- UNION 과 IN이 서로 동일한 결과를 만들 수 있음
-- 직급이 대리 또는 사원인 직원의 이름과 직급명을 조회
-- 직급순 오름차순 정렬, 직급이 같을 경우에는 이름순 오름차순정렬
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE IN ('대리', '사원')
ORDER BY 2, 1;

SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE= '대리'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원'
ORDER BY 2;

-- *************************************
/*
메소드 (리턴값이 있는 메소드())
컬럼명 비교연산자 비교할 값 <-- 비교할 값을 알아내기 위한 SELECT 문을 값 사용 위치에 바로 쓸 수 있음
컬럼명 비교연산자 (SELECT ... )
*/

-- 서브 쿼리 (SUB QUERY)
-- 쿼리문 안에 사용된 쿼리문

-- 예 : 나승원이라는 직원과 같은 부서에 소속된 직원들의 명단 조회
-- 1. 나승원이 소속된 부서 조회
SELECT DEPT_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원'; --DEPT_ID = 50

-- 2. 조회된 결과값을 사용해서 부서원들 조회
-- 서브쿼리 이용
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '나승원');
                            
-- 서브쿼리의 유형은
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리, 다중열 다중행 서브쿼리
-- 상호연관 서브쿼리, 스칼라 서브쿼리로 구분
-- 서브쿼리 앞에 붙는 연산자가 달라짐

-- 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
-- 서브쿼리의 결과값이 한 개인 경우
-- 단일행 서브쿼리 앞에는 일반 비교연산자를 모두 사용 가능
-- <, >, <=, >=, =, !=, <>, ^=

-- 예 : 나승원과 직급이 같으면서 나승원보다 급여를 많이 받는 직원 조회
-- 이름, 직급, 급여 조회
-- 1. 나승원의 직급 조회
SELECT JOB_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원'; -- J5

-- 2. 나승원의 급여 조회
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '나승원'; -- 2300000

-- 3. 결과 조회
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '나승원')
AND SALARY > (SELECT SALARY
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '나승원');
                        
-- 최저 임금 받는 사람
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                            FROM EMPLOYEE);
                            
-- 임금의 합계가 가장 큰 부서
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                    FROM EMPLOYEE
                                    GROUP BY DEPT_ID);

-- 서브쿼리는 SELECT절, FROM절, WHERE절, GROUP BY절, HAVING절
-- ORDER BY절에서 모두 사용

-- 다중행(MULTIPLE ROW) 서브쿼리 *****************
-- 서브쿼리 결과값의 갯수가 여러 개인 경우

-- 예 : 부서별 급여 최저값 조회
SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 부서 별로 누가 최저 급여를 받는 지 조회
SELECT EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_ID); -- ERROR
                    
/*
다중행 서브쿼리 앞에는 일반 비교연산자 사용 못 함
일반 비교연산자는 한 개의 값을 가지고 비교 판단함

다중행 서브쿼리 앞에 사용할 수 있는 연산자는
컬럼명 IN (다중행 서브쿼리) : 여러 개의 값 중에서 한 개라도 일치하는 값이 있다면..
컬럼명 NOT IN (다중행 서브쿼리) : 여러 개의 값 중에서 한 개라도 일치하지 않는다면..

컬럼명< ANY : 비교 대상 중 최대 값 보다 작음
컬럼명> ANY : 비교 대상 중 최소 값 보다 큼
컬럼명= ANY : IN 연산자와 동일

컬럼명< ALL : 비교 대상 중 최소 값 보다 작음 / 모든 값보다 큰가
컬럼명> ALL : 비교 대상 중 최대 값 보다 큼 / 모든 값보다 작은가

*/

SELECT EMP_ID, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_ID);
                            
-- IN / NOT IN
-- 여러 개의 값과 비교해서 같은 값이 있는지 같은 값이 없는 지 비교
SELECT DISTINCT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원 정보에서 관리자만 추출 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE);

-- 직원 정보에서 관리자가 아닌 직원 추출 조회
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE
                                WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;

-- SELECT 절에서도 서브쿼리 사용할 수 있음
SELECT EMP_ID, EMP_NAME,
            CASE
            WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '관리자'
            ELSE '직원'
            END 구분
FROM EMPLOYEE
ORDER BY 3, 1;


-- 직원 정보에서 관리자만 추출

-- 그룹함수 실습 **************************************

-- 부서별 급여평균, 급여는 천단위에서 반올림되게 함.
SELECT ROUND(AVG(SALARY), -4) "급여 평균"
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 성별별 급여 평균  : group by 절에 계산식 사용 가능
-- DECODE, SUBSTR 사용
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여') 성별, ROUND(AVG(SALARY), -4) "급여 평균"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여');

	     -- 계산식이 똑같이 입력되어야 함



-- 실습 : 직급별 급여의 합계와 인원수를 조회함
-- 출력은 직급, 급여합게, 인원수 
SELECT JOB_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_ID;



-- 실습 : 부서코드와 직급코드를 함께 그룹을 묶고, 
-- 급여의 합계를 구함
-- ROLLUP 사용함
SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID);


-- ************************************************
-- rollup 함수  
/* 부서/직업별 평균임금 조회 */


-- cube 함수