### 1. ѕроанализировать какие запросы могут выполн€тьс€ наиболее часто в процессе работы приложени€ и добавить необходимые индексы.


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

### 2. «адание на оконные функции
ѕостроить запрос, который будет выводить следующие столбцы:
им€ группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый пожилой пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

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


### 3. (по желанию) «адание на денормализацию
–азобратьс€ как построен и работает следующий запрос:
Ќайти 10 пользователей, которые про€вл€ют наименьшую активность в использовании социальной сети.

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
	
ѕравильно-ли он построен?
 акие изменени€, включа€ денормализацию, можно внести в структуру Ѕƒ
чтобы существенно повысить скорость работы этого запроса?

-- –азбираемс€ насколько корректно работает запрос:
-- 1. выполн€ем запрос - получаем id пользователей.
-- 2. выдел€ем активность по каждой таблице в отдельности, провер€ем результат по каждой из таблиц 

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

запрос работает корректно.

¬арианты денормализации:
1. создать еще одну таблицу activity, в которой будут хранитьс€ уникальный идентификатор пользовател€
вычисл€емы пол€ активности по каждой таблице и общий счетчик активности;
