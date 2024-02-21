select Item.Name   as 'Узел справочника',
       Item.RowID  as 'ИД узела справочника',
       Items.Name  as 'Строка справочника',
       Items.RowID as 'id Строки справочника'
from [dbo].[dvtable_{1B1A44FB-1FB1-4876-83AA-95AD38907E24}] Items with (nolock)
         join [dbo].[dvtable_{A1DCE6C1-DB96-4666-B418-5A075CDB02C9}] Item with (nolock)
              on Item.RowID = Items.ParentRowID
Where Item.ParentTreeRowID = '57256340-7509-45F9-9CF2-D5C4D51A1C85'
--- or Item.RowID = '3ECE729E-5438-422C-A25B-EE037BD1AC1F'


--Поиск Узлов к конструкторе справочника
select ItemLib.RowID, ItemLib.InstanceID, ItemLib.ParentRowID, ItemLib.Name
from [dbo].[dvtable_{a1dce6c1-db96-4666-b418-5a075cdb02c9}] as EditLib
         left join [dbo].[dvtable_{1B1A44FB-1FB1-4876-83AA-95AD38907E24}] as ItemLib
                   ON ItemLib.ParentRowID = EditLib.RowID
-- если есть ссылки на друкие таблици как в Доверенностях то :
-- left join [dbo].[dvtable_{F5641A7E-83AF-4C20-9C60-EA2973C4F135}] as tss
--ON tss.InstanceID = tt1.ItemCard
where EditLib.name like '%Инициатор авансирования'
