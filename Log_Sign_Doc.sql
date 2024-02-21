/*Логирование подписание*/
SELECT
	MassSignLogs.[UserID],
	emps.[DisplayString],
	MassSignLogs.[Date],
	MassSignLogs.[Log]
FROM
	MassSignLogs
		INNER JOIN [dbo].[dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}] emps
			ON emps.[RowID] = MassSignLogs.[UserID]
WHERE USERID --= '09AB7161-CED2-4F71-BCFF-3D41D6880F61' /*'Смирнова'*/ and
      --MassSignLogs.[Date] >= '2023-10-25' or
      --USERID = 'A2BE121C-1F7D-4390-8962-E9BB8301827B' /*'Савина'*/ and
      = '7136C79D-911E-48A0-A3BE-76B52650D1CC' and
      MassSignLogs.[Date] >= '2024-1-10'
ORDER BY
	MassSignLogs.[Date]