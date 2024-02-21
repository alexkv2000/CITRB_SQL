--Чистка Лицензий в БД:
--select * from [dbo].[dvtable_{b4a2559b-45fd-4aba-919f-0f170ccddb5d}]
delete from [dbo].[dvtable_{b4a2559b-45fd-4aba-919f-0f170ccddb5d}]
--Подключенные сессии
--select * from dvsys_sessions
delete from dvsys_sessions
exec [dbo].[dvsys_metadata_validate_all_objects] @RecreateJob = 1, @WithDropExisting = 1