select gaz.RowID, gaz.Source, gaz.Destination, gaz.Data, gaz.AdditionalData, gaz.IsProcessed, gaz.ProcessDate, er.Error
from GAZ.dbo.SyncEventsTable gaz
LEFT JOIN SyncEventsTableErrors as er ON er.EventID=gaz.RowID
where (gaz.Source Like 'KYC' --and gaz.IsProcessed = 1
and  FORMAT(gaz.ProcessDate, '%d.%M.%y') = FORMAT(getdate()-0, '%d.%M.%y'))
or (gaz.Source Like 'KYC' --and gaz.IsProcessed = 1
and  gaz.ProcessDate is null)

order by gaz.IsProcessed, gaz.ProcessDate DESC