--Запросы на PostgreSQL

--1 Вывести сколько заказов было оформлено, и сколько в итоге получено. Не учитывать тестовые заказы

select count(o.id) total_orders, --если статус у заказа меняется, то всего заказов оформлено - это всего заказов с любым статусом
	count(o.id) filter (where o.ClientOrderStateID = 2) completed_orders
from orders o
left join AdditionalInfo ai on ai.ClientOrderID = o.id and ai.code = 'IsTestOrder'
where ai.value != 'true' --не равно - потму что может быть null, кавычки - потому что если тут есть названия платформы, то это скорее всего тип varchar
;


--2 Для каждой платформы и категории посчитать: сколько было куплено товаров, сколько было получено заказов, GMV. Не учитывать тестовые заказы.

select ai_platform.value platform, coi.category, count(coi.ItemId) items_qty, count(distinct coi.ClientOrderID ) orders_qty, sum(coi.price * coi.qty) gmv
from ClientOrderItem coi
left join orders o on o.id = coi.ClientOrderID
left join AdditionalInfo ai_test on ai_test.ClientOrderID = o.id and ai.code = 'IsTestOrder'
left join AdditionalInfo ai_platform on ai_platform.ClientOrderID = o.id and ai_platform.code = 'platform'
where o.ClientOrderStateID = 2
and ai_test.value != 'true'
group by ai_platform.value, coi.category
order by ai_platform.value, count(coi.ItemId) desc
;


--3 Найти категорию, которая приносит наибольшую выручку

select coi.category
from ClientOrderItem coi
left join orders o on o.id = coi.ClientOrderID
where o.ClientOrderStateID = 2
group by coi.category
order by sum(coi.price * coi.qty) desc
limit 1
;


--4 Какой товар чаще других встречается в отмененных заказах.

select coi.ItemId
from ClientOrderItem coi
left join orders o on o.id = coi.ClientOrderID
where o.ClientOrderStateID = 3
group by coi.ItemId
order by count(coi.ItemId) desc --sum(coi.qty) - если мы хотим учесть кол-во штук в заказах
limit 1
;


--5 Найдите среднее время между первым и вторым заказом у пользователей. Для решения запроса не используйте джойны. Тестовые заказы фильтровать не нужно.

with df as (
	select o.clientId, o."date" o_date,
		row_number() over (partition by o.clientId order by o."date") o_number,
		lag(o."date", -1) over (partition by o.clientId order by o."date") next_order
	from orders o
	--where o.ClientOrderStateID = 2 можем учитывать только оплаченные заказы
	order by o.clientId, o."date")
select avg(df.next_order::date - df.o_date::date) avg_datediff --в данном случае считаю время в днях
from df
where df.o_number = 1
	and df.next_order is not null
;


--6 Для каждой категории найдите топ – 3 пользователей, у которых наименьшее количество дней между первой и последней покупкой в этой категории.

with
	user_level as (
		select coi.category, o.clientId, max(o."date"::date) - min(o."date"::date) diff
		from ClientOrderItem coi
		left join orders o on coi.ClientOrderID = o.id
		group by coi.category, o.clientId
		having max(o."date") != min(o."date") --исключаем пользователей с одной покупкой
		order by coi.category, max(o."date"::date) - min(o."date"::date)),
	user_rank as (
		select *,
			row_number() over (partition by user_level.category order by user_level.diff) u_rank
		from user_level)
select user_rank.category, user_rank.clientId
from user_rank
where user_rank.u_rank <= 3
/* Если я правильно понял, нужно было сделать это.
Но такой запрос не учитывает ситуацию, где у нас, например, 5 человек на первом месте имеют одинаковое кол-во дней */
;