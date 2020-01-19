
-- ������ ������� ���� vk
USE vk;
-- 1 ������� (���� ���������� ���� ������ �������� ����������� �� ���������� ����� �� ����)
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  autor_id INT UNSIGNED NOT NULL, -- ������� ���� �� ������� users ��� communities
  post TEXT NOT NULL,
  likes_count INT UNSIGNED DEFAULT 0, 
  created_at DATETIME DEFAULT NOW()
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- 2 ������� (���� ����� ���������� ������ �� ���� � ���� ��� ����������� (���������� �������������))
-- ������ ������� ������
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  community_id INT UNSIGNED NOT NULL, -- ������� ���� �� ������� communities
  post TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

-- ������� ������� ������
CREATE TABLE likes ( 
   community_id INT UNSIGNED NOT NULL, -- ������� ���� �� ������� communities
   post_id INT UNSIGNED NOT NULL, -- ������� ���� �� ������� posts
   user_id INT UNSIGNED NOT NULL, -- ������� ���� �� ������� users
   like BOOLEAN
);      
-- ����� ������������ ��������� ���� (post_id, user_id) ��� �������� id ����� ��� ������ �� ����)

  


