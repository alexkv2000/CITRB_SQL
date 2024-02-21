select
	Employees.RowID,
	Employees.[DisplayString] as '������������',
	STRING_AGG (CONVERT(NVARCHAR(max),ItemType.[Name]), '; ') as '���������, ��������� ��� �����������'
from
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] Employees with(nolock)
left join [dvtable_{29EFE146-4FC2-41C7-B2F1-A0776F6FBACB}] DocTypes with(nolock)
	on Employees.[CardEmployeeID] = DocTypes.[InstanceID]
left join [dvtable_{1B1A44FB-1FB1-4876-83AA-95AD38907E24}] ItemType with(nolock)
	on DocTypes.[DocType] = ItemType.[RowID]

where Employees.[Status] not in (5,7)			--������������ �� ������
	and ItemType.RowID is not NULL				--���� �������� ������ � ������� � ����������� ��� �����������

group by Employees.[RowID], Employees.[DisplayString]
order by Employees.[DisplayString]