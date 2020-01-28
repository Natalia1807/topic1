-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  from_in VARCHAR(255) COMMENT 'Откуда вылет',
  to_in VARCHAR(255) COMMENT 'Куда вылет',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Расписанип вылетов';

INSERT INTO flights (from_in, to_in) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
 

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'Название города English',
  name VARCHAR(255) COMMENT 'Название города Russian',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Расписанип вылетов';

INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('novgorod', 'Новгород'),
  ('irkutsk', 'Иркутск'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань');
 
SELECT c.name as from_in, ci.name as to_in
FROM flights f
JOIN cities c on c.label = f.from_in
JOIN cities ci on ci.label = f.to_in
ORDER BY id;

