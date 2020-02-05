-- 1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. 
-- ����������� ����������.

START TRANSACTION;
SELECT name FROM shop.users WHERE id = 1;
INSERT INTO sample.users (name) SELECT name FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;

USE sample;
SELECT * FROM users;
USE shop;
SELECT * FROM users;

-- 2.�������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.

CREATE VIEW product_name AS 
SELECT p.name as product, c.name as catalog_name
FROM products p 
JOIN catalogs c on c.id = p.catalog_id;

SELECT * from product_name;

-- 3. �� �������) ����� ������� ������� � ����������� ����� created_at. 
-- � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17. 
-- ��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1, ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.

CREATE TABLE date_august (created_at DATE);
INSERT INTO date_august
       VALUES 
             ('2018-08-01'), 
             ('2018-08-04'), 
             ('2018-08-16'), 
             ('2018-08-17');
            
SELECT * FROM date_august;

CREATE TEMPORARY TABLE temp_august (created_at DATE);
INSERT INTO temp_august 
       VALUES
	         ('2018-08-01'), ('2018-08-02'), ('2018-08-03'), ('2018-08-04'), ('2018-08-05'),
	         ('2018-08-06'), ('2018-08-07'), ('2018-08-08'), ('2018-08-09'), ('2018-08-10'),	
	         ('2018-08-11'), ('2018-08-12'), ('2018-08-13'), ('2018-08-14'), ('2018-08-15'),
	         ('2018-08-16'), ('2018-08-17'), ('2018-08-18'), ('2018-08-19'), ('2018-08-20'),
	         ('2018-08-21'), ('2018-08-22'), ('2018-08-23'), ('2018-08-24'), ('2018-08-25'),
	         ('2018-08-26'), ('2018-08-27'), ('2018-08-28'), ('2018-08-29'), ('2018-08-30'), ('2018-08-31');
	        
SELECT * FROM temp_august;

SELECT created_at, 
              IF(temp_august.created_at IN (SELECT created_at FROM date_august), 1, 0) AS flag 
              FROM temp_august;

-- 4. (�� �������) ����� ������� ����� ������� � ����������� ����� created_at. 
-- �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.

CREATE TABLE date_table (created_at DATE);

INSERT INTO date_table VALUES
	('2020-02-04'),
	('2020-02-02'),
	('2020-02-01'),
	('2020-01-30'),
	('2020-01-28'),
	('2020-01-26'),
	('2020-01-20'),
	('2020-01-14'),
	('2020-01-12'),
	('2020-01-10');

SELECT * 
FROM date_table 
ORDER BY created_at DESC;

SELECT * 
FROM date_table 
ORDER BY created_at DESC LIMIT 5;

DELETE FROM date_table
WHERE created_at NOT IN (
	SELECT *
	   FROM (
		  SELECT *
		  FROM date_table
		  ORDER BY created_at DESC LIMIT 5
	      ) AS new_1
 ) ORDER BY created_at DESC;


SELECT * 
FROM date_table 
ORDER BY created_at DESC;   