-- 2. ѕусть задан некоторый пользователь. 
--»з всех друзей этого пользовател€ найдите человека, который больше всех общалс€ 
--с нашим пользователем. 
-- «апрос работает без использовани€ Join и вложенных запросов
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

-- 3. ѕодсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(likes_per_user) AS likes_total FROM ( 
  SELECT COUNT(*) AS likes_per_user 
    FROM likes 
      WHERE target_type_id = 2
        AND target_id IN (
          SELECT * FROM (
            SELECT user_id FROM profiles ORDER BY birthdate DESC LIMIT 10
          ) AS sorted_profiles 
        ) 
      GROUP BY target_id
) AS counted_likes;

-- 4. ќпределить кто больше поставил лайков (всего) - мужчины или женщины?

select p.sex, count(*) as likes_count
from likes l
join profiles p on p.user_id = l.user_id
where p.sex = 'f'
union
select p.sex, count(*)
from likes l
join profiles p on p.user_id = l.user_id
where p.sex = 'm'
ORDER BY likes_count desc LIMIT 1;


-- 5. Ќайти 10 пользователей, которые про€вл€ют наименьшую активность в использовании социальной 
-- сети.     

select temp.user, sum(temp.total) as total
from
(SELECT CONCAT(first_name, ' ', last_name) AS user, count(l.user_id) as total
from users u
left join likes l on l.user_id = u.id
GROUP BY user
union
SELECT CONCAT(first_name, ' ', last_name) AS user, count(m.user_id) as total
from users u
join media m on m.user_id = u.id
GROUP BY user
union
SELECT CONCAT(first_name, ' ', last_name) AS user, count(ms.from_user_id) as total
from users u
left join messages ms on ms.from_user_id = u.id
GROUP BY user) as temp
group by temp.user
order by total limit 10;

