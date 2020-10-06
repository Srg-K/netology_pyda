--В таблице display дважды повторяется поле client - в бд на sql так нельзя - переименовал первое поле в client_name

with
	clients as ( --тут делаем основную таблицу, где для каждого клиента будет запись с категорией и типом устройства (чтобы резултат не зависел от того, есть ли конкретный клиент в таблице direct или display)
		select *
		from dict d
		cross join (select 'РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ' category union select 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ') cat),	
	direct as (
		select dr.client_id, dr.client, dr.category,
			sum(dr.shows) shows_direct, sum(dr.clicks) clicks_direct, sum(dr.direct_conv_visits_last_significant) conv_visits_direct, sum(dr.cost_rub_wo_nds) costs_direct,
			sum(dr.clicks)::float / sum(dr.shows) cr_shows_clicks_direct, sum(dr.direct_conv_visits_last_significant)::float / sum(dr.clicks) cr_clicks_acquisition_direct,
			sum(dr.cost_rub_wo_nds) / sum(dr.shows) cpv_direct, sum(dr.cost_rub_wo_nds) / sum(dr.clicks) cpc_direct, sum(dr.cost_rub_wo_nds) / sum(dr.direct_conv_visits_last_significant) cpa_direct
		from direct dr
		where dr."month" between '2020-06-01' and '2020-08-01'
		and dr.category in ('РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ', 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ')
		group by dr.client_id, dr.client, dr.category),
	display as (
		select dp.client_id, dp.client, dp.category,
			sum(dp.shows) shows_display, sum(dp.clicks) clicks_display, sum(dp.cost_rub_wo_nds) costs_display,
			sum(dp.clicks)::float / sum(dp.shows) cr_shows_clicks_display,
			sum(dp.cost_rub_wo_nds) / sum(dp.shows) cpv_display, sum(dp.cost_rub_wo_nds) / sum(dp.clicks) cpc_display
		from display dp
		where dp."month" between '2020-06-01' and '2020-08-01'
		and dp.category in ('РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ', 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ')
		group by dp.client_id, dp.client, dp.category)
select clients.category, clients.client,
	direct.shows_direct, direct.clicks_direct, direct.conv_visits_direct, direct.costs_direct, direct.costs_direct / sum(direct.costs_direct) over (partition by clients.category) direct_budget_share,
		direct.cr_shows_clicks_direct, direct.cr_clicks_acquisition_direct, direct.cpv_direct, direct.cpc_direct, direct.cpa_direct,
	display.shows_display, display.clicks_display, display.costs_display, display.costs_display / sum(display.costs_display) over (partition by clients.category) display_budget_share,
		display.cr_shows_clicks_display, display.cpv_display, display.cpc_display
from clients
left join direct on direct.client = clients.client and direct.client_id = clients.client_id and direct.category = clients.category
left join display on display.client = clients.client and display.client_id = clients.client_id and display.category = clients.category
where direct.client_id is not null or display.client_id is not null
order by clients.category, clients.client
;



--------------------------анализируем директ подробнее
select dr."month", dr.category, dr.client, dr.device, dr.place, dr.adtype, dr.bannertype, dr."QueryType (search only)", dr.targetingtype, dr.shows, dr.clicks, 
	dr.direct_conv_visits_last_significant, dr.cost_rub_wo_nds
from direct dr
where dr.category in ('РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ', 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ')
and dr."month" between '2020-06-01' and '2020-08-01'
;

--------------------------анализируем дисплей подробнее
select dp."month", dp.category, dp.client, dp.device, dp.campaigntype, dp.shows, dp.clicks, dp.cost_rub_wo_nds
from display dp
where dp.category in ('РАСЧЕТНО-КАССОВОЕ ОБСЛУЖИВАНИЕ', 'ПОТРЕБИТЕЛЬСКОЕ КРЕДИТОВАНИЕ')
and dp."month" between '2020-06-01' and '2020-08-01'
;
