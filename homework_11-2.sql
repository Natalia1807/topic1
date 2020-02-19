
-- 1. � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.

SCARD ip 


-- 2. ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������
-- � �������, ����� ������������ ������ ������������ �� ��� �����.

hset user_name: 
			 {"first_name": "Natalia",
			"last_name": "Andreeva",
			"email": "eva0511@rambler.ru"}

hget first_name:Natalia
hget email:eva0511@rambler.ru

-- 3. ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.

use shop
shop.products.insertMany([{"name": "Intel Core i3-8100", "description": "��������� ��� ���������� ��", "price": "8000.00", "catalog_id": "����������", "created_at": new Date(), "updated_at": new Date()},
                          {"name": "Intel Core i5-7400", "description": "��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.": "12700.00", "catalog_id": "����������", "created_at": new Date(), "updated_at": new Date()},
                          {"name": "AMD FX-8320E", "description": "��������� ��� ���������� ������������ �����������, ���������� �� ��������� AMD.", "price": "4780.00", "catalog_id": "����������", "created_at": new Date(), "updated_at": new Date()},
                          {"name": "Gigabyte H310M S2H", "description": "����������� ����� Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price": "4900.00", "catalog_id": "����������� �����", "created_at": new Date(), "updated_at": new Date()}]) 



shop.products.find()
shop.products.find({"catalog_id": "����������"})



use catalogs
shop.catalogs.insertMany([{"name": "����������"}, {"name": "����������� �����"}, {"name": "����������"}, {"name": "������� �����"}, {"name": "����������� ������"}])


