-- Задание 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.

select *
from users;

alter table users
add column date_1 datetime not null default null;
insert into users (name)
values ('Иванов'),
       ('Петров'),
       ('Сидоров'),
       ('Васечкин');

update users
set date_1 = current_date;

-- Задание 2. Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at varchar(255),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users_new (name, birthday_at, created_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '20.10.2017 8:10'),
  ('Александр', '1985-05-20', '20.10.2017 8:10'),
  ('Сергей', '1988-02-14', '20.10.2017 8:10'),
  ('Иван', '1998-01-12', '20.10.2017 8:10'),
  ('Мария', '1992-08-29', '20.10.2017 8:10');
 

update users_new
set created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');

alter table users_new modify column created_at datetime default CURRENT_TIMESTAMP;



 
-- Задание 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.


DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  val int not null,
  UNIQUE unique_name(name(10))
);

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры', 5),
  (NULL, 'Материнские платы', 10),
  (NULL, 'Видеокарты', 0),
  (NULL, 'Жесткие диски', 0),
  (NULL, 'Оперативная память', 2);

select * from catalogs
order by if ( val  =  0, 1, 0 ), val;

-- Задание 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')

DROP TABLE IF EXISTS users_users;
CREATE TABLE users_users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users_users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
select * from users_users
where month(birthday_at) in (05, 08);

-- Задание 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
select * from catalogs
where id in (5, 1, 2)
order by field(id, 5, 1, 2);

-- Практическое задание теме “Агрегация данных”
-- задание 1. Подсчитайте средний возраст пользователей в таблице users

select round(AVG(timestampdiff(year, birthday_at, current_date()))) as age from users_users;


-- Задание 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

select 
count(id) as bd, 
date_format(date_format(birthday_at, '2019-%m-%d'), '%W') as day_of_the_week 
from users_users
group by day_of_the_week	
order by bd
;

-- Задание 3.(по желанию) Подсчитайте произведение чисел в столбце таблицы

select round(exp(sum(log(id))), 0) as summa 
from users_users;