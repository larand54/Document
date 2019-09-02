use test1
select P.name AS Projekt, SP.name AS SubProjekt,T.task_description AS Uppgift, wp.comment AS Arbetspass,wp.start, DATEDIFF(MI,wp.start, wp.ended),(DATEDIFF(MI,wp.start, wp.ended)+30)/60 from dbo.work_pass WP
join task T ON T.id = WP.task_id 
join project P ON P.id = T.project_id
left outer join sub_project SP ON SP.id = T.sub_project_id
where wp.start > '2017-11-30' and wp.start < '2018-01-01'  order by wp.start, task_description 
