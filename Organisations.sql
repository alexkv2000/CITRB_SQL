--Дерево Организаций (Type: 0-Организация, 1-Подраздление)
with tree(Name, RowID, level, Type, pathstr)
         as (select Name, RowID, 0, Type, CAST(t_Group.Name as varchar(550))
             from [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as t_Group
             where ParentTreeRowID = '00000000-0000-0000-0000-000000000000'
             union all
             select t_Group_r.Name, t_Group_r.RowID, tree.level + 1, t_Group_r.Type, CAST(tree.pathstr + ' |_ '+  t_Group_r.Name as varchar(550))
             from [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as t_Group_r
                      inner join tree on tree.RowID = t_Group_r.ParentTreeRowID)
select RowID, space(level)+ Name as Name, Type, pathstr
from tree
where Type <= ?
order by pathstr

----------------------------------------
select [RowID],
[InstanceID],
[ParentRowID],
[ParentTreeRowID],
[FirstName],
[MiddleName],
[LastName],
[AccountName],
[IPPhone],
[Email],
[IDIssuedBy] as Organisation,
[Comments],
[DisplayString]
from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
where LastName = ? and FirstName = ? and MiddleName = ? and AccountName is not null
