/*

В таблице display дважды повторяется поле client - в бд на sql так нельзя - переименовал первое поле в client_name

В таблице display пусто поле direct_conv_visits_last_significant - надо проверить не ошибка ли это; для данного кейса предположим, что у нас просто нет данных

*/

with
	clients as ( --тут делаем основную таблицу, где для каждого клиента будет запись с категорией и типом устройства (чтобы резултат не зависел от того, есть ли конкретный клиент в таблице direct или display)
		select *
		from dict d
		cross join (select 'РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ' category union select 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ') cat
		cross join (select 'Desktop' device union select 'Mobile') dev),	
	direct as (
		select dr.client_id, dr.client, dr.category, dr.device,
			sum(dr.shows) shows_direct, sum(dr.clicks) clicks_direct, sum(dr.direct_conv_visits_last_significant) conv_visits_direct, sum(dr.cost_rub_wo_nds) costs_direct,
			sum(dr.clicks)::float / sum(dr.shows) cr_shows_clicks_direct, sum(dr.direct_conv_visits_last_significant)::float / sum(dr.clicks) cr_clicks_acquisition_direct,
			sum(dr.cost_rub_wo_nds) / sum(dr.shows) cpv_direct, sum(dr.cost_rub_wo_nds) / sum(dr.clicks) cpc_direct, sum(dr.cost_rub_wo_nds) / sum(dr.direct_conv_visits_last_significant) cpa_direct
		from direct dr
		where dr.category in ('РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ', 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ')
		and extract(month from dr."month") between 6 and 8
		group by dr.client_id, dr.client, dr.category, dr.device),
	display as (
		select dp.client_id, dp.client, dp.category, dp.device,
			sum(dp.shows) shows_display, sum(dp.clicks) clicks_display, sum(dp.cost_rub_wo_nds) costs_display,
			sum(dp.clicks)::float / sum(dp.shows) cr_shows_clicks_display,
			sum(dp.cost_rub_wo_nds) / sum(dp.shows) cpv_display, sum(dp.cost_rub_wo_nds) / sum(dp.clicks) cpc_display
		from display dp
		where dp.category in ('РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ', 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ')
		and extract(month from dp."month") between 6 and 8
		group by dp.client_id, dp.client, dp.category, dp.device)
select clients.client, clients.category, clients.device, 
	direct.shows_direct, direct.clicks_direct, direct.conv_visits_direct, direct.costs_direct, direct.cr_shows_clicks_direct, direct.cr_clicks_acquisition_direct, direct.cpv_direct, direct.cpc_direct, direct.cpa_direct,
	display.shows_display, display.clicks_display, display.costs_display, display.cr_shows_clicks_display, display.cpv_display, display.cpc_display
from clients
left join direct on direct.client = clients.client and direct.client_id = clients.client_id and direct.category = clients.category and direct.device = clients.device
left join display on display.client = clients.client and display.client_id = clients.client_id and display.category = clients.category and display.device = clients.device
where direct.client_id is not null or display.client_id is not null
;