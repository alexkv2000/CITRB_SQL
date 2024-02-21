;with Files(size) as
	 (
		select binar.size
		from [dvtable_{30eb9b87-822b-4753-9a50-a1825dca1b74}] tMain  with(nolock)
		join [dbo].[dvtable_{91B2C5F7-9324-4CEF-9AFE-A457C8310F06}] SysInf with(nolock) on tMain.InstanceID=SysInf.InstanceID
		join dvsys_instances_date dates with(nolock) ON dates.InstanceID = tMain.InstanceID
		join [dvtable_{A6FA8BAF-2EA4-4071-AA3E-5C4E71646A90}] tFiles  with(nolock) on tMain.InstanceID = tFiles.InstanceID
		join [dvtable_{F831372E-8A76-4ABC-AF15-D86DC5FFBE12}] tVersions with(nolock) on tVersions.InstanceID = tFiles.FileId
		join [dvsys_files] tFiles2 with(nolock) on tFiles2.FileID = tVersions.FileID
		join [dbo].[dvsys_binaries] binar with(nolock) on binar.ID = tFiles2.BinaryID
 		where dates.CreationDateTime BETWEEN '2013-01-01 00:00:00.000' AND '2019-12-01 00:00:00.000'
 		--< '2019-01-01 00:00:39.607'		-- дата создание меньше
-- 			--and SysInf.Kind = 'F54E6D37-86ED-4A7F-BE0B-2F06D941B6A0'	-- вид документа
-- 			and tMain.ExternalStorage = 'true'						-- в карточке стоит пометка внешнее хранилище
-- 			and binar.[Path] is null									-- не был выгружен(путь к файлу на внешнем хранилище)
	)
	select
	count(f.size) as 'Кол-во файлов'
			,sum(f.size)/POWER(1000.0,3) as 'общая сумма в Гб'
	from Files f


--
SELECT
	--ROW_NUMBER() OVER(ORDER BY kinds_info.Name) as RowIndex,
	card_sys_info.InstanceID
	--card_main_info.CreationDate
FROM
	[dvtable_{30EB9B87-822B-4753-9A50-A1825DCA1B74}] card_main_info
		INNER JOIN [dbo].[dvtable_{91b2c5f7-9324-4cef-9afe-a457c8310f06}] card_sys_info
			ON card_sys_info.InstanceID = card_main_info.InstanceID
		INNER JOIN [dbo].[dvtable_{c7ba000c-6203-4d7f-8c6b-5cb6f1e6f851}] kinds_info
			ON kinds_info.RowID = card_sys_info.Kind
WHERE
	(card_main_info.CreationDate between '2023.01.01' AND '2024.01.01' OR card_main_info.CreationDate IS NULL)
AND
	card_sys_info.Kind IN
	(
		'C2F4F770-8638-4555-9103-682509DA223D',		--Адаптация
		'FEE5F7A0-8622-4DF4-A9F6-EC4AE9B69D0B',		--Внутренние документы
		'F54E6D37-86ED-4A7F-BE0B-2F06D941B6A0',		--Входящий документ
		'6B048145-B83E-4BCD-9C23-71D21505331A',		--Заявка ДБУ
		'D08426AA-3F7F-431F-97F6-E00BD019D4B4',		--Заявка на организацию приема
		'21303560-87BC-4EE3-805F-47B8D7A3FA5A',		--Заявка на пропуск
		'3823776D-A732-43FD-8152-B24843F8555C',		--Заявка на ЭЦП
		'2E425AF6-CF72-428B-A232-AB5DDE5DC482',		--Исходящий документ
		'B9903A56-ED0D-4CC0-AECF-32DA0476102C',		--Кадровый документ
		'D91AE4FB-B782-43C6-9980-E490EF21E3A9',		--ОРД
		'864B37F0-09BC-4B4B-8F8A-F43BE15F95CB',		--Поручение
		'5C9235EC-5797-4D87-8275-3323C94CC579',		--Программа визита
		'523AED8C-435C-4F10-B6EA-D2F1590D6DC1',		--Финансовый документ

		'E7A15086-FDF7-4879-B205-EC286185D410',		--Акт
		'88A55BB2-0F39-4202-9D2B-C3711722C22C',		--Договор
		'8B37E125-1405-4F43-91CB-3EE9B9A2C76D',		--Договор группы
		'EFB5D5A1-D3A2-46B5-B356-2D6005C58835',		--Оснастка
		'980232C7-201E-4FDC-BB25-FFBB87A70552'		--Электронные заявки
	)
ORDER BY kinds_info.Name


--select top 10 * from [dbo].[dvsys_binaries] where Path is null
select * from dvsys_globalinfo
dvsys_help_set_version