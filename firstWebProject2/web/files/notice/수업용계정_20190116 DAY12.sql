-- DAY 12 **************************************
-- TRUNCATE : DELETE���� �ӵ��� �������� ROLLBACK �Ұ���

-- DELETE ��
-- ���� �����ϴ� ����
/*
DELETE [FROM] ���̺��
WHERE ���ǽ�;
*/
-- WHERE ���� ������� ������ ���̺��� ��� ���� ������
SELECT * FROM DCOPY;

DELETE FROM DCOPY;

ROLLBACK; -- DELETE ���

SELECT * FROM DCOPY;

-- �ٸ� ���̺��� FOREIGN KEY�� �����ǰ� �ִ� ���̺��� ���, �� ���� �� ��
DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';
-- �����ǰ� �ִ� ���� ��ϵ� ���� ���� ����

DELETE FROM DEPARTMENT
WHERE DEPT_ID = '30';
-- �����ǰ� �ִ� ���� ���� ���� ���� ����

SELECT * FROM DEPARTMENT;
ROLLBACK;

-- TRUNCATE ��
-- ���̺��� ��� �� ������ �����. �ӵ��� ����
-- ���� �Ұ���, ���� ���� ������ ���� �� ��

TRUNCATE TABLE DCOPY;
SELECT * FROM DCOPY;
ROLLBACK;

-- *****************************************************
-- TCL (Transaction Control Language)
-- COMMIT, ROLLBACK, SAVEPOINT

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINTS FK_MGRID; --�����ڻ�� ��Ȱ��ȭ, DDL ������ �����ϸ� �� Ʈ����� ����

SELECT CONSTRAINT_NAME
FROM USER_CONSTRAINTS;

SAVEPOINT S0;

INSERT INTO DEPARTMENT
VALUES ('40', '��ȹ������', 'A1');

SAVEPOINT S1;

UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL;

SAVEPOINT S2;

DELETE FROM EMPLOYEE;

ROLLBACK TO S2;

SELECT * FROM EMPLOYEE;

--SELECT CONSTRAINT_NAME, TABLE_NAME
--FROM USER_CONSTRAINTS
--WHERE CONSTRAINT_NAME = 'SYS_C007202';

--DROP TABLE TESTFK CASCADE CONSTRAINTS;

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID = '40';

ROLLBACK TO S0;

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID = '40'; -- 0�� ���;� �Ѵ�

-- ���ü� ���� : ���(LOCK)
SELECT EMP_ID, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID = '143';

UPDATE EMPLOYEE
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '143';

COMMIT;

