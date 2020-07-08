

select o.user_id, o.amount, case when o.is_invoice_sent = true then 1 else 0 end is_invoice_sent, case when ocsp.target_type = 'bundle' then 1 else 0 end is_bundle,
case when o.amocrm_lead_id is not null and o.amocrm_lead_id != 0 then 1 else 0 end is_amo_lead, ucs.end_date - ucs.start_date access_days, to_char(ucs.start_date, 'D') start_date_dow,
MAX(case when sd.day_number = 1 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d1_complete, MAX(case when sd.day_number = 1 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d1_duration,
MAX(case when sd.day_number = 2 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d2_complete, MAX(case when sd.day_number = 2 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d2_duration,
MAX(case when sd.day_number = 3 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d3_complete, MAX(case when sd.day_number = 3 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d3_duration,
MAX(case when sd.day_number = 4 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d4_complete, MAX(case when sd.day_number = 4 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d4_duration,
MAX(case when sd.day_number = 5 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d5_complete, MAX(case when sd.day_number = 5 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d5_duration,
MAX(case when sd.day_number = 6 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d6_complete, MAX(case when sd.day_number = 6 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d6_duration,
MAX(case when sd.day_number = 7 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d7_complete, MAX(case when sd.day_number = 7 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d7_duration,
MAX(case when sd.day_number = 8 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d8_complete, MAX(case when sd.day_number = 8 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d8_duration,
MAX(case when sd.day_number = 9 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d9_complete, MAX(case when sd.day_number = 9 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d9_duration,
MAX(case when sd.day_number = 10 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d10_complete, MAX(case when sd.day_number = 10 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d10_duration,
MAX(case when sd.day_number = 11 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d11_complete, MAX(case when sd.day_number = 11 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d11_duration,
MAX(case when sd.day_number = 12 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d12_complete, MAX(case when sd.day_number = 12 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d12_duration,
MAX(case when sd.day_number = 13 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d13_complete, MAX(case when sd.day_number = 13 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d13_duration,
MAX(case when sd.day_number = 14 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d14_complete, MAX(case when sd.day_number = 14 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d14_duration,
MAX(case when sd.day_number = 15 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d15_complete, MAX(case when sd.day_number = 15 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d15_duration,
MAX(case when sd.day_number = 16 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d16_complete, MAX(case when sd.day_number = 16 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d16_duration,
MAX(case when sd.day_number = 17 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d17_complete, MAX(case when sd.day_number = 17 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d17_duration,
MAX(case when sd.day_number = 18 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d18_complete, MAX(case when sd.day_number = 18 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d18_duration,
MAX(case when sd.day_number = 19 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d19_complete, MAX(case when sd.day_number = 19 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d19_duration,
MAX(case when sd.day_number = 20 and uds.end_time is not null and sd.day_of_rest != true then 1 else 0 end) d20_complete, MAX(case when sd.day_number = 20 and uds.end_time is not null and sd.day_of_rest != true then to_timestamp(uds.end_time)::date - ucs.start_date else 0 end) d20_duration,
MAX(case when (uhs.target_type = 'stage_day_homework' and sdh.homework_id in (248,249,250) and uhs.status != 0 and uhs.status is not null)
	or (uhs2.target_type = 'course_stage_homework' and csh.homework_id in (248,249,250) and uhs2.status != 0 and uhs.status is not null) then 1 else 0 end) start_selfie,
MAX(case when uhs.target_type = 'stage_day_homework' and sdh.homework_id in (283,220) and uhs.status != 0 and uhs.status is not null then 1 else 0 end) dz1,
MAX(case when uhs.target_type = 'stage_day_homework' and sdh.homework_id in (221,284) and uhs.status != 0 and uhs.status is not null then 1 else 0 end) dz2,
MAX(case when uhs.target_type = 'stage_day_homework' and sdh.homework_id in (229,285,222) and uhs.status != 0 and uhs.status is not null then 1 else 0 end) final_selfie,
MAX(case when f."type" = 1 then 1 else 0 end) sent_video,
MAX(cm_count."count") sent_messages_count
from project_1."order" o
left join project_1."order_course_service" ocs ON o.order_course_service_id = ocs.id
left join (select distinct gm.member_id, gm.group_id from project_1.group_member gm
	where gm.group_id in (25)) g on g.member_id = ocs.course_service_id
left join project_1."order_course_service_params" ocsp ON o.order_course_service_id = ocsp.order_course_service_id
left join (
	select ocsp.course_id , ocs.parent_id, ocsp.target_id from project_1."order_course_service" ocs
	left join project_1."order_course_service_params" ocsp ON ocsp.order_course_service_id = ocs.id
	where ocs.parent_id is not null and ocsp.target_id is not null) child on child.parent_id = ocsp.order_course_service_id and child.course_id = ocsp.course_id
left join project_1."user_course_stream" ucs on (case when ocsp.target_type = 'bundle' then child.target_id	when ocsp.target_type = 'user_course'
	then ocsp.target_id end) = ucs.id
left join project_1."user_day_status" uds on ucs.id = uds.user_course_stream_id
left join project_1."stage_day" sd on uds.stage_day_id = sd.id
left join project_1."stage_day_homework" sdh on sdh.stage_day_id = sd.id
left join project_1."user_homework_status" uhs on uhs.target_id = sdh.id and uhs.user_course_stream_id = ucs.id and uhs.target_type = 'stage_day_homework'
left join project_1."user_homework_status" uhs2 on uhs2.user_course_stream_id = ucs.id and uhs2.target_type = 'course_stage_homework'
left join project_1."course_stage_homework" csh on csh.id = uhs2.target_id
left join project_1.chat_message cm on cm.user_id = ucs.user_id and cm.dialog_id = ucs.chat_channel_id
left join project_1.chat_message_file_assn cmfa on cmfa.message_id = cm.id
left join project_1.file f on f.id = cmfa.file_id
left join (select cm.user_id, cm.dialog_id, count(cm.id) from project_1.chat_message cm
	group by cm.user_id, cm.dialog_id) cm_count on cm_count.user_id = ucs.user_id and cm_count.dialog_id = ucs.chat_channel_id
where o.status = 'paid'
and g.group_id is not null
and to_timestamp(o.updated_at)::date between '2019-01-01' and '2020-03-31'
group by o.user_id, o.amount, case when o.is_invoice_sent = true then 1 else 0 end, case when ocsp.target_type = 'bundle' then 1 else 0 end,
case when o.amocrm_lead_id is not null and o.amocrm_lead_id != 0 then 1 else 0 end, ucs.end_date - ucs.start_date, to_char(ucs.start_date, 'D')
;



