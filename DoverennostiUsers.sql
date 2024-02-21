select
	Employees.RowID,
	Employees.[DisplayString] as 'Пользователь',
	ProxyOrg.[Name] as 'Юр Лицо',
	ProxyUnit.[Name] as 'Подразделение',
	ByProxy.[docBase] as 'Документ основание'
from
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] Employees with(nolock)
left join [dvtable_{6C97802F-D94E-4029-B6F2-AE36561E0B13}] ByProxy with(nolock)
	on Employees.[CardEmployeeID] = ByProxy.[InstanceID]
left join [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] ProxyOrg with(nolock)
	on ByProxy.[Organization] = ProxyOrg.[RowID]
left join [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] ProxyUnit with(nolock)
	on ByProxy.[Unit] = ProxyUnit.[RowID]

where Employees.[Status] not in (5,7)		--Пользователь не уволен
	and ByProxy.[RowID] is not NULL			--Есть строки в таблице По доверенности

order by Employees.[DisplayString]