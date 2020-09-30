use tidrapport
select P.name AS Projekt, SP.name AS SubProjekt,T.task_description AS Uppgift, SUM((DATEDIFF(MI,wp.start, wp.ended)+30)/60) from dbo.work_pass WP
join task T ON T.id = WP.task_id 
join project P ON P.id = T.project_id
left outer join sub_project SP ON SP.id = T.sub_project_id
where wp.start > '2018-1-1 00:00' and wp.start < '2018-01-07' group by P.name, SP.name,T.id, T.task_description --order by wp.start, task_description 
