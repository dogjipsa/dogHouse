-- 19.
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT), 1) 전공평점
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE CATEGORY = (SELECT CATEGORY
                                FROM TB_DEPARTMENT
                                WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME;

-- 18. 
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME  
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                                FROM TB_STUDENT
                                JOIN TB_GRADE USING (STUDENT_NO)
                                JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                                WHERE DEPARTMENT_NAME = '국어국문학과'
                                GROUP BY STUDENT_NO, STUDENT_NAME);
                                
SELECT MAX(AVG(POINT))
                                FROM TB_STUDENT
                                JOIN TB_GRADE USING (STUDENT_NO)
                                JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                                WHERE DEPARTMENT_NAME = '국어국문학과'
                                GROUP BY STUDENT_NO, STUDENT_NAME;
                                
SELECT   STUDENT_NO, STUDENT_NAME, P
FROM     ( SELECT  AVG(POINT) P , STUDENT_NO, STUDENT_NAME
           FROM     TB_GRADE
           JOIN     TB_STUDENT USING (STUDENT_NO)
           JOIN     TB_DEPARTMENT USING (DEPARTMENT_NO)
           WHERE    DEPARTMENT_NAME LIKE '국어%' 
           GROUP BY STUDENT_NO, STUDENT_NAME
           ORDER BY 1 DESC )
WHERE   ROWNUM = 1;                  

SELECT  STUDENT_NO, STUDENT_NAME, P
FROM (SELECT  AVG(POINT) P, STUDENT_NO, STUDENT_NAME,
                    RANK() OVER (ORDER BY AVG(POINT) DESC) AS RANK
                   FROM TB_STUDENT
                JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                    JOIN TB_GRADE USING(STUDENT_NO)
                    WHERE DEPARTMENT_NAME LIKE '국어%'
                    GROUP BY STUDENT_NO, STUDENT_NAME)
WHERE RANK = 1;

                                
                                

                                
-- 17.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO
                                        FROM TB_STUDENT
                                        WHERE STUDENT_NAME = '최경희');
                                        
-- 16.
SELECT CLASS_NO, CLASS_NAME, ROUND(AVG(POINT), 8)
FROM TB_CLASS 
JOIN TB_GRADE USING (CLASS_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '환경조경학과'
                                        AND CLASS_TYPE LIKE '전공%')                                       
GROUP BY CLASS_NAME, CLASS_NO
ORDER BY 1;

-- 15
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", ROUND(AVG(POINT), 8)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING ROUND(AVG(POINT), 8) >= 4.0
ORDER BY 1;

-- 14
SELECT STUDENT_NAME, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT
JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO (SELECT
                                