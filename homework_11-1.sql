-- 1. �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, 
-- catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������,
-- ������������� ���������� ����� � ���������� ���� name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_date DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	table_id BIGINT(20) NOT NULL,
	name_tab VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


DROP TRIGGER IF EXISTS log_users;
delimiter //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_date, table_name, table_id, name_tab)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


DROP TRIGGER IF EXISTS log_catalogs;
delimiter //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_date, table_name, table_id, name_tab)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


delimiter //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_date, table_name, table_id, name_tab)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('����', '1980-02-16');

SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('�������', '1900-07-07'),
		('�����', '1993-07-18'),
		('��������', '1995-06-18'),
		('�����', '1985-03-08');

SELECT * FROM users;
SELECT * FROM logs;



SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES   ('����������'),
		('�������');

SELECT * FROM catalogs;
SELECT * FROM logs;


SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, desription, price, catalog_id)
VALUES ('PATRIOT PSD34G13332', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.', 8000, 1),
		('DARK ROCK PRO 4 (BK022)', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.', 4780, 1),
		('ASUS ROG MAXIMUS X HERO, Z370', '����������� ����� ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR14, ATX', 19310, 2);

SELECT * FROM products;
SELECT * FROM logs;


-- 2. (�� �������) �������� SQL-������, ������� �������� � ������� users ������� �������.


DROP TABLE IF EXISTS users; 
CREATE TABLE users (
	id int unsigned, not null auto_increment,  PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


DROP PROCEDURE IF EXISTS insert_million;
DELIMITER //
CREATE PROCEDURE insert_million()
BEGIN
  DECLARE v INT DEFAULT 0;
  WHILE v < 20 DO
    INSERT into users (name, birthday_at) VALUES (CONCAT('user_name', v), NOW());;
    SET v = v + 1;
  END WHILE;
end //
DELIMITER ;


SELECT * FROM users;

CALL insert_million();
