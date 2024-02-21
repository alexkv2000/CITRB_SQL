

update KISUDov1
SET KISUDov1.[STATUS] = LocaleStateName.[Name]

--select KISUDov1.ID_SED, KISUDov1.STATUS, LocaleStateName.[Name]
From OPENQUERY(ORACLECIS, 'Select * FROM INTEG.DV_LOAD_GAZ_MAN ') KISUDov1
JOIN OPENQUERY(ORACLECIS, 'Select ID_SED, STATUS FROM INTEG.DV_LOAD_GAZ_MAN ') KISUDov ON KISUDov.ID_SED = KISUDov1.ID_SED
JOIN [dbo].[dvtable_{91B2C5F7-9324-4CEF-9AFE-A457C8310F06}] SysInfo with(nolock)-- Системные свойства
	on SysInfo.InstanceID = KISUDov1.ID_SED
JOIN [dbo].[dvtable_{DA37CA71-A977-48E9-A4FD-A2B30479E824}] LocaleStateName with(nolock) -- СТАТУС(локализация состояния доверенности)
		on LocaleStateName.ParentRowID = SysInfo.[State] and LocaleStateName.LocaleID = 1049
WHERE KISUDov.[STATUS] != LocaleStateName.[Name]