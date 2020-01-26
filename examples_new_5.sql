-- 1. ���������������� �������, ������� ����������� �� �������, ���������� ��������� 
-- ������������� �/��� ��������� (JOIN ���� �� ���������).
USE vk;

-- ��� ������� -- �������� ���������� ������������
SELECT filename FROM media
  WHERE user_id = 3
    AND media_type_id = 1; -- ������� ��������� ������, �.�. �� ������� media_types ����� ������������ id. ��� �������� ��� � ��� ����������
    
   

-- ��� ������� -- �������� ������� �� ���������� ���������� �������������
SELECT CONCAT(
  '������������ ������� ���� ', 
  filename, 
  ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = 1; -- (������������ id  media_types);


-- ��� ������� -- �������� ������
SELECT CONCAT(
  '������������ ', 
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users WHERE id = media.user_id),
  ' ������� ���� ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = 1; -- (������������ id  media_types)


-- ��� ������� -- �������� ������ ������ � �������� ��������
SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 3
    AND status_id = 2 --  ������� ��������� ������
    )
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 3
    AND status_id = 2  -- ������� ��������� ������
  );


-- ��� ������� -- �������� ���������� ������
SELECT filename FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 15
    AND status_id = 2 -- ������� ��������� ������
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 15 
      AND status_id = 2 -- ������� ��������� ������
  )
);


-- ��� ������� -- ���������� ���������� ������������ � ��� ������ ��� �������� ����� ��������
SELECT filename, user_id, created_at FROM media WHERE user_id = 15
UNION
SELECT filename, user_id, created_at FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 15
    AND status_id = 2 -- ������� ��������� ������
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 15 
      AND status_id = 2 -- ������� ��������� ������
  )
);


-- ��� ������� -- ������������ ����� ��� ����������� ������������ � ��� ������
SELECT target_id AS mediafile, COUNT(*) AS likes 
  FROM likes 
    WHERE target_id IN (
      SELECT id FROM media WHERE user_id = 3
        UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT friend_id 
          FROM friendship 
            WHERE user_id = 3 
              AND status_id = 2 -- ������� ��������� ������
              ))
        UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT user_id 
          FROM friendship 
            WHERE friend_id = 3 
              AND status_id = 2 -- ������� ��������� ������
              )) 
    )
    AND target_type_id = 3 -- ������� ��������� ������
    GROUP BY target_id;
   
 
 -- ��� ������� -- ������� ������ ������������ � ��������������� ���� � �������� 
SELECT 
    (SELECT CONCAT(first_name, ' ', last_name) 
      FROM users 
      WHERE id = user_id) AS friend, 
      
    CASE (sex)
      WHEN 'm' THEN 'man'
      WHEN 'f' THEN 'women'
    END AS sex,
    
    TIMESTAMPDIFF(YEAR, birthdate, NOW()) AS age
     
  FROM profiles
  
  WHERE user_id IN (
     SELECT friend_id 
      FROM friendship
      WHERE user_id = 3
        AND confirmed_at IS NOT NULL
        AND status_id = 2 -- ������� ��������� ������
        )
      UNION
      SELECT user_id 
      FROM friendship
      WHERE friend_id = 3
        AND confirmed_at IS NOT NULL
        AND status_id = 2 -- ������� ��������� ������
  );
    
 
-- ��� ������� -- ����� ������������ �� �������� �����  
SELECT first_name, last_name -- ������������� ���������� ����, ������ ��� ������ ��������� ���������� ��� ������ �� ������� ��� ������ �� ����� 
  FROM users
  WHERE first_name LIKE 'M%';
 
 -- ��� ������� -- ���������� ���������� ���������
SELECT first_name, last_name -- ������������� ���������� ����, ������ ��� ������ ��������� ���������� ��� ������ �� ������� ��� ������ �� ����� 
  FROM users
  WHERE last_name RLIKE '^M.*n$';

-- 2. ����� ����� ��������� ������������. 
--�� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� 
--� ����� �������������. 
-- ����������: �� ������� � ������������ �������. ���� � ������� � ������������ ����� ������ �� ������ ��������� �� ������ �������������, �� 
-- ����������, ��� ������� ������ ������� ����, � ���� ����� ��������� ������������ ����������. ���� �� ��������� ��� ������� 
(SELECT from_user_id, to_user_id, count(*) as mes
    FROM messages
    WHERE to_user_id = 43
    GROUP BY from_user_id, to_user_id
    ORDER BY mes )
UNION
 (SELECT from_user_id, to_user_id, count(*) as mes
    FROM messages
    WHERE from_user_id = 43
    GROUP BY from_user_id, to_user_id
    ORDER BY mes DESC )
ORDER BY mes DESC LIMIT 1;

-- 3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.
 SELECT COUNT(*)
   FROM likes
   WHERE user_id IN
	(SELECT * 
		FROM 
	            (SELECT user_id 
				FROM profiles
 				ORDER BY birthdate LIMIT 10) as yong
);

-- 4. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

SELECT sex FROM (
        SELECT sex, COUNT((SELECT COUNT(*) 
           FROM likes as L where L.user_id = P.user_id)) as sex_count 
               FROM profiles as P
                   WHERE sex = 'm'
                     GROUP BY sex
UNION ALL
       SELECT sex, COUNT((SELECT COUNT(*) 
           FROM likes as L where L.user_id = P.user_id)) 
                FROM profiles as P
                     WHERE sex = 'f'
                     GROUP BY sex
                      ) AS T
GROUP BY sex
ORDER BY MAX(sex_count) DESC
LIMIT 1;

-- 5. ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� 
-- ���������� ����.

SELECT 
   (SELECT concat(first_name, ' ', last_name) FROM users where id = user_id) fullname,  SUM(temp.coun) AS counti
     FROM 
       (
         SELECT user_id, COUNT(*) AS coun
         FROM likes
         GROUP BY user_id
         UNION ALL
         SELECT user_id, COUNT(*) AS coun
         FROM media
         GROUP BY user_id
         UNION ALL
         SELECT from_user_id, COUNT(*) AS coun
         FROM messages
         GROUP BY from_user_id
       ) as temp
GROUP BY fullname
ORDER BY counti
LIMIT 10;
