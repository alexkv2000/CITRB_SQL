-- ссылка на документ из Диадок
-- DVDiadoc@gaz.ru
-- DvD_P@55w0rd!N3W
DECLARE @URL VARCHAR(MAX) = 'https://diadoc.kontur.ru/d45c0635-f2aa-4624-abcc-290e56b38f22/Document/Show?letterId=56c85a0d-db46-4cc2-8b1e-aaa4fb1209c4&documentId=8e56663d-93da-4a2f-9ad5-2e4fdc91b593'

DECLARE @BoxId VARCHAR(100) = REPLACE(SUBSTRING(@URL, 26, 36), '-', '') + '@diadoc.ru'
DECLARE @MessageId VARCHAR(100) = SUBSTRING(@URL, 86, 36)

SELECT
	*
FROM
	DvIntegDiadocMessages
		INNER JOIN DvIntegDiadocDocuments
			ON DvIntegDiadocDocuments.IntegMessageId = DvIntegDiadocMessages.RowID
WHERE
	DiadocMessageId = @MessageId
	AND BoxSource = @BoxId

-- Дальше если нужно загрузить сам документ (ID) в DV
SELECT RowID
INTO #MessagesToReload
FROM DvIntegDiadocMessages
WHERE DiadocMessageId IN
(
    '56c85a0d-db46-4cc2-8b1e-aaa4fb1209c4'
)
SELECT DvIntegDiadocDocuments.RowID
INTO #DocsToRefresh
FROM DvIntegDiadocDocuments INNER JOIN #MessagesToReload ON #MessagesToReload.RowID = DvIntegDiadocDocuments.IntegMessageId
SELECT DvIntegDiadocPatches.RowID
INTO #PatchesToRefresh
FROM DvIntegDiadocPatches INNER JOIN #MessagesToReload ON #MessagesToReload.RowID = DvIntegDiadocPatches.IntegMessageId
SELECT RowID
INTO #LogsToDelete
FROM DvIntegDiadocLogs
WHERE IntegEntityId IN
(
     SELECT * FROM #DocsToRefresh
     UNION
     SELECT * FROM #PatchesToRefresh
)

UPDATE DvIntegDiadocPatches SET IsProcessed = NULL WHERE RowID IN (SELECT * FROM #PatchesToRefresh)
DELETE FROM DvIntegDiadocLogs WHERE RowID IN (SELECT * FROM #LogsToDelete)
UPDATE DvIntegDiadocMessages SET DvStatus = 'ToProcess' WHERE RowID IN (SELECT * FROM #MessagesToReload)

DROP TABLE #MessagesToReload
DROP TABLE #DocsToRefresh
DROP TABLE #PatchesToRefresh
DROP TABLE #LogsToDelete