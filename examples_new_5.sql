-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные 
-- корректировки и/или улучшения (JOIN пока не применять).
USE vk;

-- Мой вариант -- Получаем фотографии пользователя
SELECT filename FROM media
  WHERE user_id = 3
    AND media_type_id = 1; -- Убираем вложенный запрос, т.к. из таблицы media_types проще использовать id. Это скоратит код и его восприятие
    
   

-- Мой вариант -- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
  'Пользователь добавил фото ', 
  filename, 
  ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = 1; -- (использовала id  media_types);


-- Мой вариант -- Улучшаем запрос
SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users WHERE id = media.user_id),
  ' добавил фото ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = 1; -- (использовала id  media_types)


-- Мой вариант -- Выбираем только друзей с активным статусом
SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 3
    AND status_id = 2 --  убираем вложенный запрос
    )
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 3
    AND status_id = 2  -- убираем вложенный запрос
  );


-- мой вариант -- Выбираем медиафайлы друзей
SELECT filename FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 15
    AND status_id = 2 -- убираем вложенный запрос
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 15 
      AND status_id = 2 -- убираем вложенный запрос
  )
);


-- Мой вариант -- Объединяем медиафайлы пользователя и его друзей для создания ленты новостей
SELECT filename, user_id, created_at FROM media WHERE user_id = 15
UNION
SELECT filename, user_id, created_at FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 15
    AND status_id = 2 -- убираем вложенный запрос
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 15 
      AND status_id = 2 -- убираем вложенный запрос
  )
);


-- Мой вариант -- Подсчитываем лайки для медиафайлов пользователя и его друзей
SELECT target_id AS mediafile, COUNT(*) AS likes 
  FROM likes 
    WHERE target_id IN (
      SELECT id FROM media WHERE user_id = 3
        UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT friend_id 
          FROM friendship 
            WHERE user_id = 3 
              AND status_id = 2 -- убираем вложенный запрос
              ))
        UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT user_id 
          FROM friendship 
            WHERE friend_id = 3 
              AND status_id = 2 -- убираем вложенный запрос
              )) 
    )
    AND target_type_id = 3 -- убираем вложенный запрос
    GROUP BY target_id;
   
 
 -- мой вариант -- Выводим друзей пользователя с преобразованием пола и возраста 
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
        AND status_id = 2 -- убираем вложенный запрос
        )
      UNION
      SELECT user_id 
      FROM friendship
      WHERE friend_id = 3
        AND confirmed_at IS NOT NULL
        AND status_id = 2 -- убираем вложенный запрос
  );
    
 
-- Мой вариант -- Поиск пользователя по шаблонам имени  
SELECT first_name, last_name -- необязательно объединять поля, потому что иногда требуется соритровка или только по фамилии или только по имени 
  FROM users
  WHERE first_name LIKE 'M%';
 
 -- Мой вариант -- Используем регулярные выражения
SELECT first_name, last_name -- необязательно объединять поля, потому что иногда требуется соритровка или только по фамилии или только по имени 
  FROM users
  WHERE last_name RLIKE '^M.*n$';

-- 2. Пусть задан некоторый пользователь. 
--Из всех друзей этого пользователя найдите человека, который больше всех общался 
--с нашим пользователем. 
-- Комментрий: не уверена в правильности выборки. Если к примеру у пользователю будет только по одному сообщению от других пользователей, то 
-- получается, что выборка должна вернуть всех, у кого будет одинаково максимальное количество. Пока не придумала как выбрать 
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

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
 SELECT COUNT(*)
   FROM likes
   WHERE user_id IN
	(SELECT * 
		FROM 
	            (SELECT user_id 
				FROM profiles
 				ORDER BY birthdate LIMIT 10) as yong
);

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

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

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании 
-- социальной сети.

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
