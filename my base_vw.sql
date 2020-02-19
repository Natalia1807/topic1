drop VIEW IF exists provider_models_mars;
create VIEW provider_models_mars as
select 
p.name, 
p.adress, 
p.status,
m.name as marka,
mo.name as model,
c.type_status,
c.volue,
c.year_car,
c.price
from providers p
left join provider_cars pc on pc.provider_id = p.id
left join cars c on c.id = pc.car_id
left join models mo on mo.id = c.model_id
left join marks m on m.id = mo.mark_id;

select * from provider_models_mars;


drop VIEW IF exists marks_payment;
create VIEW marks_payment as
select
m.name as marka,
mo.name as model,
c.color,
c.type_status,
c.volue,
pay.manager_id,
pay.amount
from marks m
join models mo on mo.mark_id = m.id
join cars c on c.model_id = mo.id
join payments pay on pay.car_id = c.id
join users u on u.id = c.manager_id;

select * from marks_payment;