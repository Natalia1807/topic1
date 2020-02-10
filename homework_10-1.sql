### 1. ���������������� ����� ������� ����� ����������� �������� ����� � �������� ������ ���������� � �������� ����������� �������.


USE vk;
SELECT * from users;
CREATE INDEX first_name_idx ON users(first_name);
CREATE INDEX last_name_idx ON users(last_name);

describe users;

SELECT * from profiles;
CREATE INDEX birthdate_idx ON profiles(birthdate);
CREATE INDEX hometown_idx ON profiles(hometown);

describe profiles;

SELECT * from media;

CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);

describe media;

SELECT * from likes;
CREATE INDEX likes_user_id_target_type_id_idx ON likes(user_id, target_type_id);

describe likes;

### 2. ������� �� ������� �������
��������� ������, ������� ����� �������� ��������� �������:
��� ������
������� ���������� ������������� � �������
����� ������� ������������ � ������
����� ������� ������������ � ������
����� ���������� ������������� � ������
����� ������������� � �������
��������� � ��������� (����� ���������� ������������� � ������ / ����� ������������� � �������) * 100

SELECT distinct c.name,
-- AVG(SUM(cu.user_id)) OVER () AS average,
MAX(p.birthdate) OVER w as young,
MIN(p.birthdate) OVER w as old,
COUNT(cu.user_id) OVER w AS total,
COUNT(cu.user_id) OVER () AS total_1,
COUNT(cu.user_id) OVER w / COUNT(cu.user_id) OVER () * 100 AS "%%"   
FROM (communities_users cu
JOIN communities c ON c.id = cu.community_id
JOIN profiles p on p.user_id = cu.user_id
JOIN users u on u.id = cu.user_id)
         WINDOW w AS (PARTITION BY cu.community_id);


### 3. (�� �������) ������� �� ��������������
����������� ��� �������� � �������� ��������� ������:
����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.

SELECT users.id,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) + 
  COUNT(DISTINCT media.id) AS activity 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY activity
  LIMIT 10;
	
���������-�� �� ��������?
����� ���������, ������� ��������������, ����� ������ � ��������� ��
����� ����������� �������� �������� ������ ����� �������?

-- ����������� ��������� ��������� �������� ������:
-- 1. ��������� ������ - �������� id �������������.
-- 2. �������� ���������� �� ������ ������� � �����������, ��������� ��������� �� ������ �� ������ 

SELECT users.id,
  COUNT(DISTINCT messages.id) as total_messages,
  COUNT(DISTINCT likes.id) as total_likes,
  COUNT(DISTINCT media.id) AS total_media,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) + 
  COUNT(DISTINCT media.id) AS activity 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY total_messages, total_likes, total_media, activity
  LIMIT 10;

������ �������� ���������.

�������� ��������������:
1. ������� ��� ���� ������� activity, � ������� ����� ��������� ���������� ������������� ������������
���������� ���� ���������� �� ������ ������� � ����� ������� ����������;
