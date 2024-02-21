with tree(Name, RowID, level, pathstr)
         as (select Name, RowID, 0, CAST(t_Group.Name as varchar(550))
             from [dbo].[dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}] as t_Group
             where ParentTreeRowID = '00000000-0000-0000-0000-000000000000'
             union all
             select t_Group_r.Name, t_Group_r.RowID, tree.level + 1, CAST(tree.pathstr + ' -> ' +  t_Group_r.Name as varchar(550))
             from [dbo].[dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}] as t_Group_r
                      inner join tree on tree.RowID = t_Group_r.ParentTreeRowID)
select RowID, space(level)+ Name as Name, pathstr
from tree
 where Name LIKE '%Согласующие НКА'
order by pathstr

