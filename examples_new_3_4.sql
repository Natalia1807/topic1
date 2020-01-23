-- ������� 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������.
-- ��������� �� �������� ����� � ��������.

select *
from users;

alter table users
add column date_1 datetime not null default null;
insert into users (name)
values ('������'),
       ('������'),
       ('�������'),
       ('��������');

update users
set date_1 = current_date;

-- ������� 2. ������� users ���� �������� ��������������. 
-- ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". 
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

DROP TABLE IF EXISTS users_u;
CREATE TABLE users_u (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at varchar(255),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';

INSERT INTO users_u (name, birthday_at, created_at) VALUES
  ('��������', '1990-10-05', '20.10.2017 8:10'),
  ('�������', '1984-11-12', '20.10.2017 8:10'),
  ('���������', '1985-05-20', '20.10.2017 8:10'),
  ('������', '1988-02-14', '20.10.2017 8:10'),
  ('����', '1998-01-12', '20.10.2017 8:10'),
  ('�����', '1992-08-29', '20.10.2017 8:10');
 
rename table users_u to users_us;

create table users_u (
 id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME,
  updated_at DATETIME
);

insert into users_u (id, name, created_at, updated_at)
select id, name, STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at) from users_us;

drop table users_us;

select *  from users_u; 
 
-- ������� 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 
-- 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
-- ������, ������� ������ ������ ���������� � �����, ����� ���� �������.


DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '�������� �������',
  val int not null,
  UNIQUE unique_name(name(10))
);

INSERT INTO catalogs VALUES
  (NULL, '����������', 5),
  (NULL, '����������� �����', 10),
  (NULL, '����������', 0),
  (NULL, '������� �����', 0),
  (NULL, '����������� ������', 2);

select * from catalogs
order by if ( val  =  0, 1, 0 ), val;

-- ������� 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���.
-- ������ ������ � ���� ������ ���������� �������� ('may', 'august')

DROP TABLE IF EXISTS users_users;
CREATE TABLE users_users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';

INSERT INTO users_users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');
 
select * from users_users
where DATE_FORMAT(birthday_at, '%M') in ('may', 'august')
order by DATE_FORMAT(birthday_at, '%M');

-- ������� 5. (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- ������������ ������ � �������, �������� � ������ IN.
select * from catalogs
where id in (5, 1, 2)
order by field(id, 5, 1, 2);

-- ������������ ������� ���� ���������� �������
-- ������� 1. ����������� ������� ������� ������������� � ������� users

select round(AVG(timestampdiff(year, birthday_at, current_date()))) as age from users_users;


-- ������� 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
-- ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.

select 
count(id) as bd, 
date_format(date_format(birthday_at, '2019-%m-%d'), '%W') as day_of_the_week 
from users_users
group by day_of_the_week	
order by bd
;

-- ������� 3.(�� �������) ����������� ������������ ����� � ������� �������

select round(exp(sum(log(id))), 0) as summa 
from users_users;
