-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. 
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

USE vk;

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello ()
RETURNS TINYTEXT NO SQL
BEGIN
	DECLARE hour INT;
	SET hour = hour(NOW());
	CASE 
		WHEN HOUR BETWEEN 6 AND 12 THEN
			RETURNS '������ ����';
		WHEN HOUR BETWEEN 12 AND 18 THEN
			RETURNS '������ ����';
		WHEN HOUR BETWEEN 18 AND 23 THEN
			RETURNS '������ �����';
		ELSE
			RETURNS '������ ����';
	END CASE;
END //
DELIMITER ;

SELECT NOW(), hello ();


-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
-- ��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
-- ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
USE shop;

DROP TRIGGER IF EXISTS notnull;

delimiter //

CREATE TRIGGER notnull BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('Gigabyte H310M S5H', '����������� ����� Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2);

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 5060.00, 3); 

INSERT INTO products (name, description, price, catalog_id)
VALUES ('AMD FX-8780E', NULL, 4780.00, 1); 

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, '��������� ��� ���������� ������������ �����������', 12700.00, 1); 

-- -- 3.�������� �������� ������� ��� ���������� ������������� ����� ���������. 
-- ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����.
--# ����� ������� FIBONACCI(10) ������ ���������� ����� 55.

DROP FUNCTION IF EXISTS number_fib;

DELIMITER //

CREATE FUNCTION number_fib (num int)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE fn DOUBLE;
  SET fn = SQRT(5);

  RETURN (POW((1 + fs) / 2.0, num) + POW((1 - fs) / 2.0, num)) / fs;
END//
DELIMITER ;

SELECT number_fib(10);


