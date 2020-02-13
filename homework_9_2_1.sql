-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

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
			RETURNS 'Доброе утро';
		WHEN HOUR BETWEEN 12 AND 18 THEN
			RETURNS 'Добрый день';
		WHEN HOUR BETWEEN 18 AND 23 THEN
			RETURNS 'Добрый вечер';
		ELSE
			RETURNS 'Доброй ночи';
	END CASE;
END //
DELIMITER ;

SELECT NOW(), hello ();


-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.
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
VALUES ('Gigabyte H310M S5H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2);

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 5060.00, 3); 

INSERT INTO products (name, description, price, catalog_id)
VALUES ('AMD FX-8780E', NULL, 4780.00, 1); 

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, 'Процессор для настольных персональных компьютеров', 12700.00, 1); 

-- -- 3.Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
--# Вызов функции FIBONACCI(10) должен возвращать число 55.

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


