-- ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';

INSERT INTO users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');
  
 DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = '������';
INSERT INTO orders (user_id)
VALUES (1),
       (1),
       (2),
       (3),
       (3),
       (4),
       (4),
       (5),
       (5),
       (5),
       (4);
       
SELECT DISTINCT name
FROM users u
JOIN orders o on o.user_id = u.id
ORDER by name; 