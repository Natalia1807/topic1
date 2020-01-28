-- (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, ���� name � �������. 
-- �������� ������ ������ flights � �������� ���������� �������.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  from_in VARCHAR(255) COMMENT '������ �����',
  to_in VARCHAR(255) COMMENT '���� �����',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '���������� �������';

INSERT INTO flights (from_in, to_in) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
 

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT '�������� ������ English',
  name VARCHAR(255) COMMENT '�������� ������ Russian',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '���������� �������';

INSERT INTO cities (label, name) VALUES
  ('moscow', '������'),
  ('novgorod', '��������'),
  ('irkutsk', '�������'),
  ('omsk', '����'),
  ('kazan', '������');
 
SELECT c.name as from_in, ci.name as to_in
FROM flights f
JOIN cities c on c.label = f.from_in
JOIN cities ci on ci.label = f.to_in
ORDER BY id;

