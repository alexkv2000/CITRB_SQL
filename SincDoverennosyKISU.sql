DECLARE @per nvarchar(256)
DECLARE @count int
DECLARE @name_ nvarchar(256)

-- CREATE TABLE #tmp_(
-- Row_ int,
-- ID_SED nvarchar(256),
-- ID_PERS_FIO nvarchar(256),
-- Name nvarchar(256)
-- )
--INSERT INTO #tmp_ (row_, ID_SED, ID_PERS_FIO, Name)
select ROW_NUMBER() OVER(ORDER BY ID_SED DESC) as row_, ID_SED, ID_PERS_FIO, LocaleStateName.Name INTO #tmp_
	From OPENQUERY(ORACLECIS, 'Select ID_SED, STATUS, ID_PERS_FIO FROM INTEG.DV_LOAD_GAZ_MAN ') DV_LOAD_GAZ_MAN
	JOIN [dbo].[dvtable_{91B2C5F7-9324-4CEF-9AFE-A457C8310F06}] SysInfo with(nolock)-- Системные свойства
		on SysInfo.InstanceID = DV_LOAD_GAZ_MAN.ID_SED
	JOIN [dbo].[dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}] users with(nolock) --Пользователь
		on users.SyncTag = DV_LOAD_GAZ_MAN.ID_PERS_FIO
	JOIN [dbo].[dvtable_{DA37CA71-A977-48E9-A4FD-A2B30479E824}] LocaleStateName with(nolock) -- СТАТУС(локализация состояния доверенности)
		on LocaleStateName.ParentRowID = SysInfo.[State] and LocaleStateName.LocaleID = 1049
	WHERE DV_LOAD_GAZ_MAN.[STATUS] != LocaleStateName.[Name]

-- select * from #tmp_
SET @count = (select count(ID_SED) From #tmp_)

WHILE @count>0
BEGIN
	SET @per = (select ID_PERS_FIO from  #tmp_ where row_= @count)
	SET @name_ = (select name from  #tmp_ where row_= @count)

	UPDATE [ORACLECIS]..[INTEG].[DV_LOAD_GAZ_MAN]
	SET [STATUS] = @name_
	WHERE [ID_PERS_FIO] = @per and [ID_SED] = (select ID_SED from #tmp_ where row_= @count)

	SET @count = @count -1
END

DROP TABLE #tmp_



select *
	From OPENQUERY(ORACLECIS, 'Select * FROM INTEG.DV_LOAD_GAZ_MAN ') DV_LOAD_GAZ_MAN
where
    Last_Name like '%Еры%'