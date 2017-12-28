use test1
select P.name, SP.name,T.task_description, (sum(DATEDIFF(MI,wp.start, wp.ended))+30)/60 from dbo.work_pass WP
join task T ON T.id = WP.task_id 
join project P ON P.id = T.project_id
left outer join sub_project SP ON SP.id = T.sub_project_id
where wp.start > '2017-11-30' group by task_id,T.task_description, P.name, SP.name 
