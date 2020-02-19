-- ���� �������������� ������
drop database if exists automobile_diller;
create database automobile_diller;


-- ������� ������� ����������� �����������
DROP TABLE IF EXISTS providers;
create table providers (
   id int(11) unsigned not null primary key auto_increment,
   name varchar(255) not null COMMENT '�������� ����������',
   adress varchar(255) not null COMMENT '����������� ����� ����������',
   phone varchar(20) COMMENT '������� ����������',
   contract_name varchar(255) not null COMMENT '�������� � ��������',
   status enum ('company', 'person') COMMENT 'C����� (����������� ����, �����e���� ����)',
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   index index_provider_id(id)
);
   
-- ������� ������� ����� �����������
DROP TABLE IF EXISTS marks;
create table marks (
    id int(10) unsigned not null primary key auto_increment,
    name varchar(50) unique COMMENT '�������� ����� ����������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index marks_name(name)
);


-- ������� ������� ������� �����������
DROP TABLE IF EXISTS models;
create table models (
    id int(10) unsigned not null primary key auto_increment,
    name varchar(50) COMMENT '�������� ������ ����������',
    mark_id int(10) unsigned default null ,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    unique index marks_model(name, mark_id),
    index index_model_mark_id(mark_id)
);

-- ������� ������� �����������
DROP TABLE IF EXISTS cars;
create table cars (
	id int unsigned not null primary key auto_increment,
	model_id int (10) unsigned not null COMMENT 'id ������ ����������',
	manager_id int(10) unsigned not null COMMENT 'id ���������',
	client_id int(10) unsigned COMMENT 'id ����������',
	type_status ENUM('SALE', 'SOLD', '') COMMENT '������ � �������, �������, �������, � ������',
	price decimal(10,2) unsigned COMMENT '���� �������',
	year_car YEAR(4) COMMENT '��� �������',
	volue smallint(11) unsigned COMMENT '���������� � �������',
	color varchar(50) default '' COMMENT '���� ����������',
	power_car smallint(11) unsigned COMMENT '�������� ����������',
	mileage mediumint(11) unsigned COMMENT '������ ����������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	index index_cars_model_id(model_id),
	index index_cars_manager_id(manager_id),
	index index_cars_client_id(client_id)
);

alter table cars add  sale_price decimal(10,2) unsigned after price; COMMENT '���� � �������'
-- ������� ������� ����������� ��������� ����������
DROP TABLE IF EXISTS provider_cars;	
create table provider_cars ( 
	car_id int(10) unsigned not null COMMENT 'id ����������',
	provider_id int(10) unsigned not null COMMENT 'id ���������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key (car_id, provider_id)
);

-- ������� ������� ���� �����������
DROP TABLE IF EXISTS photos;
create table photos (
	id int(11) unsigned not null primary key auto_increment,
	car_id int(10) unsigned not null COMMENT 'id ����������',
	filename varchar(255) unique default '' COMMENT '��� ����� ����',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index index_photos_filename(filename),
    index index_photos_car_id(car_id)
);
	
-- ������� ������� ���������� �����������
DROP TABLE IF EXISTS params;	
create table params ( 
	id int(11) unsigned not null primary key auto_increment,
	name varchar(255) unique not null default ' ' COMMENT '��������� ��������� ����������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index index_param_id(id)
);    
    
-- ������� ������� ����������� ��������� ����������
DROP TABLE IF EXISTS cars_params;	
create table cars_params ( 
	car_id int(10) unsigned not null COMMENT 'id ����������',
	param_id int(10) unsigned not null COMMENT 'id ���������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key (car_id, param_id),
    index index_cp_param_id(param_id)
);
    
-- ������� ������� �������������
DROP TABLE IF EXISTS users;	
create table users ( 
	id int(11) unsigned not null primary key auto_increment,
	first_name varchar(50) not null default ' ' COMMENT '������� ������������',
	last_name varchar(50) not null default ' ' COMMENT '��� ������������',
	phone varchar(20) default ' ' COMMENT '������� ������������',
	is_manager tinyint(1) unsigned not null COMMENT '1 - ���� �������� ������, 0 - ����������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ������� ������� ��������
DROP TABLE IF EXISTS payments;	
create table payments( 
	id int unsigned not null primary key auto_increment,
	car_id int(10) unsigned not null COMMENT 'id ����������',
	client_id int(10) unsigned COMMENT 'id ����������',
	manager_id int(10) unsigned COMMENT 'id ���������',
	amount decimal(10,2) unsigned COMMENT '��������� ����������',
	type_payment ENUM('PURCHASE', 'SALE', 'PREPAYMENT', ' '),
	date_payment datetime COMMENT '���� �������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index index_payment_car_id(car_id),
    index index_client_id(client_id)
);

-- ������� ������� ����-������
DROP TABLE IF EXISTS test_drives;	
create table test_drives(
	id int unsigned not null primary key auto_increment,
	car_id int(10) unsigned COMMENT 'id ����������',
	client_id int(10) unsigned COMMENT 'id ����������',
	manager_id int(10) unsigned COMMENT 'id ���������',
	date_test datetime COMMENT '��������������� ����',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	index index_test_car_id(car_id),
	index index_test_client_id(client_id),
	index index_test_manager_id(manager_id)
);

