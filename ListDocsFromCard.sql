SELECT
       doc_mi.InstanceID AS Id_карточки,
       doc_mi.Name AS Название_карточки,
       doc_mi.CreationDate AS Дата_создания_карточки,
       v_files.FileID AS Id_файла,
       files.Name AS Имя_файла,
       file_binaries.Data AS Бинарник_файла
FROM [dvtable_{30EB9B87-822B-4753-9A50-A1825DCA1B74}] doc_mi
       INNER JOIN [dvtable_{91B2C5F7-9324-4CEF-9AFE-A457C8310F06}] doc_sys
             ON doc_sys.InstanceID = doc_mi.InstanceID
       INNER JOIN [dbo].[dvtable_{a6fa8baf-2ea4-4071-aa3e-5c4e71646a90}] doc_files
             ON doc_files.InstanceID = doc_mi.InstanceID
       INNER JOIN [dbo].[dvtable_{f831372e-8a76-4abc-af15-d86dc5ffbe12}] v_files
             ON v_files.InstanceID = doc_files.FileId
       INNER JOIN [dbo].[dvsys_files] files
             ON files.FileID = v_files.FileID
       INNER JOIN [dbo].[dvsys_binaries] file_binaries
             ON file_binaries.ID = files.BinaryID
where doc_mi.InstanceID = ?

--'6C6C4CA9-EF28-4004-AAE6-00000DF69C02'