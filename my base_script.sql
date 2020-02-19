-- 1. вывести марки, модели и количество автомобилей каждого поставщика. 

select p.name, m.name as marka, mo.name as model, count(*)
from providers p
join provider_cars pc on pc.provider_id = p.id
join cars c on c.id = pc.car_id
join models mo on mo.id = c.model_id
join marks m on m.id = mo.mark_id
group by p.name, m.name, mo.name;

-- 2. выбрать поставщика наибольшего количества автомобилей.
select p.name,  count(*) as value
from providers p
join provider_cars pc on pc.provider_id = p.id
join cars c on c.id = pc.car_id
join models mo on mo.id = c.model_id
join marks m on m.id = mo.mark_id
group by p.name
order by value desc limit 1;

-- 3. узнать какие автомобили чаще всего берут на тест драйв
select m.name as marks, mo.name as models, count(*) as value
from test_drives td
join cars c on td.car_id = c.id
join models mo on mo.id = c.model_id
join marks m on m.id = mo.mark_id
group by m.name, mo.name
order by value desc limit 5;

-- 4. Какой менеджер принес больше всего прибыли.
select (select concat(u.first_name, ' ', u.last_name)) as manager, sum(amount) as profit
from payments p
join users u on u.id = p.manager_id
where type_payment = 'SALE'
group by manager_id
order by profit desc limit 1;


-- 5. какой менеджер чаще всеx делает скидки
 
select t1.manager, count(*) as discont1   
from 
	(select p.manager_id, (select concat(u.first_name, ' ', u.last_name)) as manager, p.car_id, sum(c.sale_price - p.amount) as discont
		from payments p
		join users u on u.id = p.manager_id
		join cars c on c.id = p.car_id
		where type_payment = 'SALE'
		group by manager, p.manager_id, p.car_id
		order by p.manager_id) t1
where t1.discont > 0
group by t1.manager
order by discont1 desc limit 1;



