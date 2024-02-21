/* сравнение SyncTag рабочей БД с Doc-dev553
Подключение должно быть из тестовой БД, т.к. с рабочей Link не настроен (нет доступа) */

use gaz_dev2
select prod.RowID,
       prod.[Name],
       prod.FullName,
       prod.Telex,
       dev553.SyncTag
from [dbo].[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}] dev553
LEFT JOIN
openquery([DOCPROD\SQLPROD], 'select * from gaz.dbo.[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}]') as prod
ON
    prod.RowID = dev553.RowID

/*
select p.RowID, p.Name, p.FullName, p.SyncTag
from openquery([DOCPROD\SQLPROD], 'select * from gaz.dbo.[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}]') as p
*/
