-- 2. Пусть задан некоторый пользователь. 
--Из всех друзей этого пользователя найдите человека, который больше всех общался 
--с нашим пользователем. Дорабтала с join 
 
SELECT (SELECT CONCAT(first_name, ' ', last_name) 
          FROM users 
            WHERE id = m.from_user_id) AS friend_name,  
        COUNT(DISTINCT m.id) AS total
FROM users u
    JOIN friendship f on f.user_id = u.id
         OR f.friend_id = u.id
    JOIN messages m on m.to_user_id = u.id
         OR m.from_user_id = u.id
WHERE u.id = 15
GROUP BY m.from_user_id
ORDER BY total DESC LIMIT 1;

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(total) as yong
FROM (
     SELECT COUNT(distinct l.id) as total
       FROM profiles p
     LEFT JOIN likes l on l.user_id = p.user_id
     WHERE target_type_id = 2
     GROUP BY p.user_id
     ORDER BY p.birthdate DESC LIMIT 10) as total_likes;

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT p.sex, count(*) as total
FROM likes l
JOIN profiles p on p.user_id = l.user_id
GROUP BY p.sex
ORDER BY total DESC LIMIT 1;


-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной 
-- сети.     

SELECT (SELECT CONCAT_WS(' ',first_name, last_name)) AS name, 
COUNT(DISTINCT m.id) + COUNT(DISTINCT l.id) + COUNT(DISTINCT md.id) AS total
FROM users u
LEFT JOIN messages m ON m.from_user_id = u.id
LEFT JOIN likes l  ON l.user_id = u.id
LEFT JOIN media md ON md.user_id = u.id
GROUP BY  u.id
ORDER BY total LIMIT 10;


