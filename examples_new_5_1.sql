
-- 3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.
SELECT COUNT(*)
   FROM likes
   WHERE target_type_id = 2
   AND target_id IN
	(SELECT * 
		FROM 
	            (SELECT user_id 
				FROM profiles
 				ORDER BY birthdate LIMIT 10) as yong
);

-- 4. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

SELECT sex, COUNT(*) as total_likes
	  FROM (
	    SELECT 
	      user_id as user, 
		    (SELECT sex FROM profiles WHERE user_id = user) as sex 
		  FROM likes) temp_table 
  GROUP BY sex
  ORDER BY total_likes DESC
  LIMIT 1;


