--подключенные сервера WF
select * from [dvtable_{b4a2559b-45fd-4aba-919f-0f170ccddb5d}]

1)	DELETE FROM [dbo].[dvtable_{b4a2559b-45fd-4aba-919f-0f170ccddb5d}];
2)	delete from dvsys_sessions;
3)	delete from dvsys_locks;
4)	exec [dbo].[dvsys_metadata_validate_all_objects] @RecreateJob = 1, @WithDropExisting = 1