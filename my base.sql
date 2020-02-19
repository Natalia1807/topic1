-- База автомоблиьного салона
drop database if exists automobile_diller;
create database automobile_diller;


-- Создаем таблицу поставщиков автомобилей
DROP TABLE IF EXISTS providers;
create table providers (
   id int(11) unsigned not null primary key auto_increment,
   name varchar(255) not null COMMENT 'Название поставщика',
   adress varchar(255) not null COMMENT 'Юридический адрес поставщика',
   phone varchar(20) COMMENT 'Телефон поставщика',
   contract_name varchar(255) not null COMMENT 'Сведения о договоре',
   status enum ('company', 'person') COMMENT 'Cтатус (юридическое лицо, физичeское лицо)',
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   index index_provider_id(id)
);
   
-- Создаем таблицу марок автомобилей
DROP TABLE IF EXISTS marks;
create table marks (
    id int(10) unsigned not null primary key auto_increment,
    name varchar(50) unique COMMENT 'Название марки автомоблия',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index marks_name(name)
);


-- Создаем таблицу моделей автомоблией
DROP TABLE IF EXISTS models;
create table models (
    id int(10) unsigned not null primary key auto_increment,
    name varchar(50) COMMENT 'Название модели автомоблия',
    mark_id int(10) unsigned default null ,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    unique index marks_model(name, mark_id),
    index index_model_mark_id(mark_id)
);

-- Создаем таблицу автомобилей
DROP TABLE IF EXISTS cars;
create table cars (
	id int unsigned not null primary key auto_increment,
	model_id int (10) unsigned not null COMMENT 'id модели автомоблия',
	manager_id int(10) unsigned not null COMMENT 'id менеджера',
	client_id int(10) unsigned COMMENT 'id покупателя',
	type_status ENUM('SALE', 'SOLD', '') COMMENT 'статус в продаже, продано, возврат, в ремонт',
	price decimal(10,2) unsigned COMMENT 'цена закупки',
	year_car YEAR(4) COMMENT 'год выпуска',
	volue smallint(11) unsigned COMMENT 'количество в наличии',
	color varchar(50) default '' COMMENT 'Цвет автомобиля',
	power_car smallint(11) unsigned COMMENT 'мощность автомобиля',
	mileage mediumint(11) unsigned COMMENT 'пробег автомобиля',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	index index_cars_model_id(model_id),
	index index_cars_manager_id(manager_id),
	index index_cars_client_id(client_id)
);

alter table cars add  sale_price decimal(10,2) unsigned after price; COMMENT 'цена в продаже'
-- Создаем таблицу связывающую параметры автомобиля
DROP TABLE IF EXISTS provider_cars;	
create table provider_cars ( 
	car_id int(10) unsigned not null COMMENT 'id автомобиля',
	provider_id int(10) unsigned not null COMMENT 'id параметра',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key (car_id, provider_id)
);

-- Создаем таблицу фото автомобилей
DROP TABLE IF EXISTS photos;
create table photos (
	id int(11) unsigned not null primary key auto_increment,
	car_id int(10) unsigned not null COMMENT 'id автомобиля',
	filename varchar(255) unique default '' COMMENT 'имя файла фото',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index index_photos_filename(filename),
    index index_photos_car_id(car_id)
);
	
-- Создаем таблицу параметров автомобилей
DROP TABLE IF EXISTS params;	
create table params ( 
	id int(11) unsigned not null primary key auto_increment,
	name varchar(255) unique not null default ' ' COMMENT 'Назавание параметра автомобиля',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index index_param_id(id)
);    
    
-- Создаем таблицу связывающую параметры автомобиля
DROP TABLE IF EXISTS cars_params;	
create table cars_params ( 
	car_id int(10) unsigned not null COMMENT 'id автомобиля',
	param_id int(10) unsigned not null COMMENT 'id параметра',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key (car_id, param_id),
    index index_cp_param_id(param_id)
);
    
-- Создаем таблицу пользователей
DROP TABLE IF EXISTS users;	
create table users ( 
	id int(11) unsigned not null primary key auto_increment,
	first_name varchar(50) not null default ' ' COMMENT 'Фамилия пользователя',
	last_name varchar(50) not null default ' ' COMMENT 'Имя пользователя',
	phone varchar(20) default ' ' COMMENT 'Телефон пользователя',
	is_manager tinyint(1) unsigned not null COMMENT '1 - если менеджер салона, 0 - покупатель',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Создаем таблицу платежей
DROP TABLE IF EXISTS payments;	
create table payments( 
	id int unsigned not null primary key auto_increment,
	car_id int(10) unsigned not null COMMENT 'id автомобиля',
	client_id int(10) unsigned COMMENT 'id покупателя',
	manager_id int(10) unsigned COMMENT 'id менеджера',
	amount decimal(10,2) unsigned COMMENT 'стоимость автомобиля',
	type_payment ENUM('PURCHASE', 'SALE', 'PREPAYMENT', ' '),
	date_payment datetime COMMENT 'дата платежа',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    index index_payment_car_id(car_id),
    index index_client_id(client_id)
);

-- Создаем таблицу тест-драйва
DROP TABLE IF EXISTS test_drives;	
create table test_drives(
	id int unsigned not null primary key auto_increment,
	car_id int(10) unsigned COMMENT 'id автомобиля',
	client_id int(10) unsigned COMMENT 'id покупателя',
	manager_id int(10) unsigned COMMENT 'id менеджера',
	date_test datetime COMMENT 'Запланированная дата',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	index index_test_car_id(car_id),
	index index_test_client_id(client_id),
	index index_test_manager_id(manager_id)
);

