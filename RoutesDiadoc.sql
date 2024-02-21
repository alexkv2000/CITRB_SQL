SELECT
	doc_main.[Name] AS 'Название маршрута',
	route_kind.[Name] AS 'Вид документа',
	doc_main.[RecUSCod] AS 'Вид номенклатуры',
	doc_main.[ExternalNumber] AS 'Рег. номер договора',
	route_type.[Name] AS 'Тип',
	doc_main.[TelephonNumber] AS 'Код подразделения',
	route_le.[Name] AS 'Юридическое лицо',
	route_le.[INN] AS 'ИНН Юр. лица',
	route_le.[KPP] AS 'КПП Юр. лица',
	route_le_dep.[Name] AS 'Подразделение юр лица',
	route_partner.[Name] AS 'Контрагент',
	route_partner_dep.[Name] AS 'Подразделение контрагента',
	route_b_emp.[Name] AS 'Грузополучатель'
FROM
	[dbo].[dvtable_{91b2c5f7-9324-4cef-9afe-a457c8310f06}] doc_sys
		INNER JOIN [dbo].[dvtable_{30eb9b87-822b-4753-9a50-a1825dca1b74}] doc_main
			ON doc_main.[InstanceID] = doc_sys.[InstanceID]
		LEFT JOIN [dbo].[dvtable_{1b1a44fb-1fb1-4876-83aa-95ad38907e24}] route_kind
			ON route_kind.[RowID] = doc_main.[StatusId]
		LEFT JOIN [dbo].[dvtable_{1b1a44fb-1fb1-4876-83aa-95ad38907e24}] route_type
			ON route_type.[RowID] = doc_main.[Type]
		LEFT JOIN [dbo].[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}] route_le
			ON route_le.[RowID] = doc_main.[LegalEntity]
		LEFT JOIN [dbo].[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}] route_le_dep
			ON route_le_dep.[RowID] = doc_main.[RegSubdivision]
		LEFT JOIN [dbo].[dvtable_{c78abded-db1c-4217-ae0d-51a400546923}] route_partner
			ON route_partner.[RowID] = doc_main.[RecipientPartnerOrg]
		LEFT JOIN [dbo].[dvtable_{c78abded-db1c-4217-ae0d-51a400546923}] route_partner_dep
			ON route_partner_dep.[RowID] = doc_main.[SenderPartnerOrg]
		LEFT JOIN [dbo].[dvtable_{c78abded-db1c-4217-ae0d-51a400546923}] route_b_emp
			ON route_b_emp.[RowID] = doc_main.[cargo_recipient]
WHERE
	doc_sys.Kind = '843F4F0A-6825-4508-969C-EA14E772ADF9'
	--group by route_le.[Name]
	order by route_le.[Name]