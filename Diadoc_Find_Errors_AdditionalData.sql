SELECT
	*
FROM SyncEventsTableErrors
	INNER JOIN SyncEventsTable
		ON SyncEventsTable.RowID = SyncEventsTableErrors.EventID
WHERE
	SyncEventsTable.AdditionalData = ''