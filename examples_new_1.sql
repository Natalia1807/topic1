
-- Делаем текущей базу vk
USE vk;
-- 1 вариант (если преследуем цель просто собирать статитстику по количеству лайов на пост)
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  autor_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу users или communities
  post TEXT NOT NULL,
  likes_count INT UNSIGNED DEFAULT 0, 
  created_at DATETIME DEFAULT NOW()
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- 2 вариант (цель знать количество лайков на пост и кому они принадлежат (активность пользователей))
-- Создаём таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  community_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу communities
  post TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

-- Создаем таблицу лайков
CREATE TABLE likes ( 
   community_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу communities
   post_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу posts
   user_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу users
   like BOOLEAN
);      
-- Можно использовать составной ключ (post_id, user_id) или добавить id опять все завист от цели)

  


