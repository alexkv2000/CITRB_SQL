--Переделанный запрос [GIS_DocumentsEKI] выполняется в 10 раз быстрее
--Добавить индекс
-- USE [GAZ]
-- GO
-- /****** Object:  Index [NonClusteredIndex-20220407-171410]    Script Date: 05.02.2024 15:53:06 ******/
-- CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220407-171410] ON [dbo].[dvtable_{91b2c5f7-9324-4cef-9afe-a457c8310f06}]
-- ( [Kind] ASC )
-- WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO


/****** Object:  View [dbo].[GIS_DocumentsEKI]    Script Date: 05.02.2024 13:27:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
Select top 5000
	MI.InstanceID as CardID
	,MI.ProjectNumber
	,MI.Number
	,MI.RegDate
	,SysInf.[State] as DocState
	,MI.LegalEntity as LEID
	,MI.ResponsDepartment
	,iif(SysInf.Kind = 'FEE5F7A0-8622-4DF4-A9F6-EC4AE9B69D0B', 'Внутренний документ','Организационно-распорядительный') as KindDoc
	,iif(MI.[Type] = '01E53A93-6AC5-47A2-93DC-B242EF8D2433', 'Распоряжение ДР ЯМЗ','Служебная записка ДР ЯМЗ') as TypeDoc
	,TaskMI.InstanceID as TaskID
	,TaskMI.StartTaskDate as DateSendTask
	,TaskMI.Report as TaskReport INTO #DocECI_Info_
from [dbo].[dvtable_{30EB9B87-822B-4753-9A50-A1825DCA1B74}] MI with(nolock)
join [dbo].[dvtable_{91B2C5F7-9324-4CEF-9AFE-A457C8310F06}] SysInf with(nolock)
	on MI.InstanceID=SysInf.InstanceID
join [dbo].[dvtable_{568CE0A6-7096-43CC-9800-E0B268B14CC4}] ReferencesList with(nolock)
	on ReferencesList.[Card] =  SysInf.InstanceID and ReferencesList.[CardType] = 'B9F7BFD7-7429-455E-A3F1-94FFB569C794'
join [dbo].[dvtable_{20D21193-9F7F-4B62-8D69-272E78E1D6A8}] TaskMI with(nolock)
	on TaskMI.ReferenceList = ReferencesList.InstanceID
		and TaskMI.Kind = '317E0BFC-072D-4ED7-B0EB-2D56EBBC72E5' -- вид задания "На согласование"
		and (TaskMI.Report like '%эки%' and TaskMI.Report not like '%без ЭКИ%') -- отчет содержит "ЭКИ"
join [dbo].[dvsys_instances] DocInfo with(nolock)
	on DocInfo.InstanceID = MI.InstanceID
join [dbo].[dvsys_instances] TaskInfo with(nolock)
	on TaskInfo.InstanceID = TaskMI.InstanceID
	where SysInf.Kind in
	(
		'FEE5F7A0-8622-4DF4-A9F6-EC4AE9B69D0B' --Внутренний документ
		,'D91AE4FB-B782-43C6-9980-E490EF21E3A9' --Организационно-распорядительный
	)
	and MI.[Type] in
	(
		'01E53A93-6AC5-47A2-93DC-B242EF8D2433' --Распоряжение ДР ЯМЗ
		,'93EDF7D8-63CE-436A-BD86-AA71DB9A92A8' --Служебная записка ДР ЯМЗ
	)

select distinct
	ECIDocInfo.CardID as DocID
	,ECIDocInfo.KindDoc
	,ECIDocInfo.TypeDoc
	,LocaleStateName.[Name] as [State]
	,dates.CreationDateTime as DocCreationDate
	,DocInfo.[Description] as DocName
	,ECIDocInfo.ProjectNumber
	,ECIDocInfo.Number as RegNumber
	,ECIDocInfo.RegDate
	,LE.[Name] as LE_Name
	,LE.Telex as LE_Code
	,LE.SyncTag as LE_ID
	,Department.[Name] as Department_Name
	,Department.Telex as Department_Code
	,Department.SyncTag as Department_ID
	,ECIDocInfo.TaskReport
FROM #DocECI_Info_ ECIDocInfo
JOIN [dbo].[dvsys_instances] DocInfo with(nolock)
	on DocInfo.InstanceID = ECIDocInfo.CardID and DocInfo.Deleted !=1
JOIN [dbo].[dvsys_instances_date] dates with(nolock)
	ON dates.InstanceID = ECIDocInfo.CardID
JOIN [dbo].[dvtable_{DA37CA71-A977-48E9-A4FD-A2B30479E824}] LocaleStateName with(nolock)
	on ECIDocInfo.DocState = LocaleStateName.ParentRowID and LocaleStateName.LocaleID =1049
JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] LE with(nolock)
	on LE.RowID = ECIDocInfo.LEID
JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] Department with(nolock)
	on Department.RowID = ECIDocInfo.ResponsDepartment
where ECIDocInfo.DateSendTask = (select max(DateSendTask) from #DocECI_Info_ dd where dd.CardID = ECIDocInfo.CardID)
order by DocID

DROP TABLE #DocECI_Info_