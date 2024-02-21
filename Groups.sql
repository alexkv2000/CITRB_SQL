--Выгрузка всех групп пользователей
Create Table #userActive (
    RowID uniqueidentifier,
    FIO nvarchar(99),
    IDIssuedBy nvarchar(256),
    Comments nvarchar(1024),
    SysAccountName nvarchar(128)
)
INSERT INTO #userActive
select RowID
     , LastName + ' ' + FirstName + ' ' + MiddleName as FIO
     , IDIssuedBy
     , Comments
     , SysAccountName
    from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
    where Status = 0 --0 активный 5-уволен
    order by IDIssuedBy

--select * from #userActive

select t_link.ParentRowID, #userActive.RowID as RowIDUser,  #userActive.FIO, IDIssuedBy as 'ЮрЛицо', #userActive.Comments as CommentsUser, SysAccountName as 'Account', t_link.RowID as RowID_Group, t_link.ParentTreeRowID as PTRID_Group, Name as 'Группа', t_group.Comments as 'Комментарий группы' from #userActive
--select * from #userActive
LEFT JOIN [dbo].[dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}] as t_link
                    ON t_link.EmployeeID = #userActive.RowID

LEFT join  [dbo].[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}] as t_group
                    ON t_group.RowID = t_link.ParentRowID
--where FIO = 'Квочкин Алексей Юрьевич'

DROP TABLE #userActive


---------------------------------------------------------------
--======================================
--Поиск Группы пользователя по ФИО
declare @LName varchar(40);
    SET @LName = N'Мергазымова';
declare @FName varchar(40);
    SET @FName = N'Ольга';
declare @MName varchar(40);
    SET @MName = N'Владимировна';


with tree(RowID,ParentTreeRowID, Name, Comments)
         as (
    select RowID,ParentTreeRowID, Name, Comments
    from [dbo].[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}]
        where RowID in (
        select ParentRowID
        from [dbo].[dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}]
            where EmployeeID=(
                select RowID
                from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
                    where LastName = @LName and FirstName  = @FName  and MiddleName = @MName and AccountName is not null)))
    select RowID,ParentTreeRowID, @LName + ' ' + substring(@FName,1,1) + '.' + substring(@MName,1,1) + '.' as FIO, Name, Comments
from tree

--Подчиненные секции группы. Поиск по ID пользователя
--======================================
select ParentRowID
from [dbo].[dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}]
where EmployeeID='DA6B234E-17E7-4692-AB74-9C7785BE6F73'

---------------------------------------------------------------
--======================================
--Дерево групп
with tree(Name, RowID, level, pathstr)
         as (select Name, RowID, 0, CAST(t_Group.Name as varchar(550))
             from [dbo].[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}] as t_Group
             where ParentTreeRowID = '00000000-0000-0000-0000-000000000000'
             union all
             select t_Group_r.Name, t_Group_r.RowID, tree.level + 1, CAST(tree.pathstr + ' |_ '+  t_Group_r.Name as varchar(550))
             from [dbo].[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}] as t_Group_r
                      inner join tree on tree.RowID = t_Group_r.ParentTreeRowID)
select RowID, space(level)+ Name as Name, pathstr
from tree
where Name LIKE '%согласующие (транспорт)%' -- +  ?
order by pathstr