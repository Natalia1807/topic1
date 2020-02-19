
-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

SCARD ip 


-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу
-- и наоброт, поиск электронного адреса пользователя по его имени.

hset user_name: 
			 {"first_name": "Natalia",
			"last_name": "Andreeva",
			"email": "eva0511@rambler.ru"}

hget first_name:Natalia
hget email:eva0511@rambler.ru

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use shop
shop.products.insertMany([{"name": "Intel Core i3-8100", "description": "Процессор для настольных ПК", "price": "8000.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
                          {"name": "Intel Core i5-7400", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.": "12700.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
                          {"name": "AMD FX-8320E", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD.", "price": "4780.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
                          {"name": "Gigabyte H310M S2H", "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price": "4900.00", "catalog_id": "Материнские платы", "created_at": new Date(), "updated_at": new Date()}]) 



shop.products.find()
shop.products.find({"catalog_id": "Процессоры"})



use catalogs
shop.catalogs.insertMany([{"name": "Процессоры"}, {"name": "Материнские платы"}, {"name": "Видеокарты"}, {"name": "Жесткие диски"}, {"name": "Оперативная память"}])


