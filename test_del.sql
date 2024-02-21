
		select
			CASE WHEN Doc.AuthorCust is null
			    THEN 'Не задано'
			    ELSE Employees.DisplayString
			END, LE.Name, Debts.Name, CardKinds.Name, DocType.Name, LocStates.Name
		from [dvtable_{30eb9b87-822b-4753-9a50-a1825dca1b74}] Doc WITH (NOLOCK)
			 JOIN [dbo].[dvtable_{C7BA000C-6203-4D7F-8C6B-5CB6F1E6F851}] as CardKinds WITH (NOLOCK) ON CardKinds.RowID = Doc.Kind
			 JOIN [dbo].[dvtable_{DA37CA71-A977-48E9-A4FD-A2B30479E824}] as LocStates WITH (NOLOCK) ON LocStates.ParentRowID = Doc.State and LocaleID = 1049
			 JOIN [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as LE WITH (NOLOCK) ON LE.RowID = Doc.LegalEntity
			 JOIN [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Debts WITH (NOLOCK) ON Debts.RowID = Doc.ResponsDepartment
			 JOIN [dbo].[dvtable_{1b1a44fb-1fb1-4876-83aa-95ad38907e24}] as DocType WITH (NOLOCK) ON DocType.RowID = Doc.Type
			 LEFT JOIN [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] Employees WITH (NOLOCK) ON Employees.RowID = Doc.AuthorCust
		where

		 Doc.State is not null
		  and
		LocStates.Name <> 'Подготовка'


		Select * from [gaz_dev2.dbo]
