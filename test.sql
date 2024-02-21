select RowID
     , LastName + ' ' + FirstName + ' ' + MiddleName as FIO
     , IDIssuedBy
     , Comments
     , SysAccountName
    from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
    --where RowID='3458D933-C242-4BDF-BFF6-CE50185DDD21'
where LastName = 'Булычова' and  FirstName = 'Юлия' and  MiddleName = 'Сергеевна'


select *
    from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
    where RowID='3458D933-C242-4BDF-BFF6-CE50185DDD21'
where LastName = 'Смирнова' and  FirstName = 'Елена' and  MiddleName = 'Анатольевна'

select t_link.*
    from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
LEFT JOIN [dbo].[dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}] as t_link
                    ON t_link.EmployeeID = [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}].RowID
where [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}].RowID='3458D933-C242-4BDF-BFF6-CE50185DDD21'

select * from [dbo].[dvtable_{4D449FB3-B2D5-4596-8CF9-9A3F3189B025}]
         left join [dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}]
         ON [dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}].ParentRowID = [dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}].RowID
where EmployeeID = '3458D933-C242-4BDF-BFF6-CE50185DDD21'


select	tSec.[RowID] as [RowID]
from	[dbo].[dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}] as [tSec] with(nolock)
where tSec.[AccountName] = 'GAZ\helen' and (tSec.[RowID] <> '3458d933-c242-4bdf-bff6-ce50185ddd21' or tSec.[RowID] is null)

-- [dbo].[dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}] RowID <>'3458d933-c242-4bdf-bff6-ce50185ddd21' - Секция "Разрешенные дочерние типы"

--возвращает справочник сотрудников
declare @p3 bigint
set @p3=14119628793
exec dvsys_card_get_info @UserID='8ADA0602-57AD-4247-ADDE-D56633F5D793',@InstanceID='6710B92A-E148-4363-8A6F-1AA0EB18936C',@dbts=@p3 output
select @p3
--CardType = 6710B92A-E148-4363-8A6F-1AA0EB18936C

exec [dbo].[dvsp_section_get_rows_data_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}] @UserID='8ADA0602-57AD-4247-ADDE-D56633F5D793',@InstanceID='6710B92A-E148-4363-8A6F-1AA0EB18936C',@ParentID='B1AABDE3-5F16-481E-9E59-7C572E317D77',@ReadType=3,@Timestamp=0

exec dvsp_row_set_data_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}
    @UserID='8ADA0602-57AD-4247-ADDE-D56633F5D793'
    ,@SessionID='B268CB0D-4863-EE11-AEB2-A0369F3F6F70'
    ,@RowID='2C89FA6B-2956-4B8A-8E53-9E0F386B8A75'
    ,@ChangeServerID='00000000-0000-0000-0000-000000000000'
    ,@Manager='3458D933-C242-4BDF-BFF6-CE50185DDD21' --Смирнова Е.А.
    ,@BitMask=0x400000000000
select * from [dbo].[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}]
where Manager='3458D933-C242-4BDF-BFF6-CE50185DDD21'

declare @p8 uniqueidentifier
set @p8='F2B649CF-1025-49EC-B40C-53F3EFEA6C2B'
exec dvsp_row_create_data_{29efe146-4fc2-41c7-b2f1-a0776f6fbacb}
    @UserID='8ADA0602-57AD-4247-ADDE-D56633F5D793'
    ,@SessionID='B268CB0D-4863-EE11-AEB2-A0369F3F6F70'
    ,@RowID='F2B649CF-1025-49EC-B40C-53F3EFEA6C2B'
    ,@InstanceID='679420A4-B625-E711-80C0-0A94EF22EF40'
    ,@ParentRowID='00000000-0000-0000-0000-000000000000'
    ,@ParentTreeRowID='00000000-0000-0000-0000-000000000000'
    ,@OwnServerID='00000000-0000-0000-0000-000000000000'
    ,@RowIDNew=@p8 output
    ,@DocType='E2A33213-FAFD-4D4A-859F-80D41D9025B2'
    ,@BitMask=0x01
select @p8
select * from [dbo].[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}]
where DocType='E2A33213-FAFD-4D4A-859F-80D41D9025B2'

exec dvsp_row_delete_{29efe146-4fc2-41c7-b2f1-a0776f6fbacb}
    @UserID='8ADA0602-57AD-4247-ADDE-D56633F5D793'
    ,@RowID='49465DEA-5DE1-4561-9D3C-3687D50F1ED9'
SELECT * FROM [dbo].[dvtable_{29efe146-4fc2-41c7-b2f1-a0776f6fbacb}] WHERE RowID='2C89FA6B-2956-4B8A-8E53-9E0F386B8A75'



declare @p4 bit
set @p4=NULL
exec dvsp_row_check_delete_{29efe146-4fc2-41c7-b2f1-a0776f6fbacb}
    @UserID='8ADA0602-57AD-4247-ADDE-D56633F5D793'
    ,@SessionID='B268CB0D-4863-EE11-AEB2-A0369F3F6F70'
    ,@RowID='49465DEA-5DE1-4561-9D3C-3687D50F1ED9'
    ,@LockedChildren=@p4 output
select @p4


select *
    from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as tt where tt. ='8ADA0602-57AD-4247-ADDE-D56633F5D793'

select *
    from [dbo].[dvtable_{29efe146-4fc2-41c7-b2f1-a0776f6fbacb}] as tt
where InstanceID = '489B1B5C-0542-E711-80C1-0A94EF22EF40'
or DocType = '489B1B5C-0542-E711-80C1-0A94EF22EF40'
or RowID = '489B1B5C-0542-E711-80C1-0A94EF22EF40'



select *
    from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
    --where RowID='3458D933-C242-4BDF-BFF6-CE50185DDD21'
    --where InstanceID = '6710B92A-E148-4363-8A6F-1AA0EB18936C'
where LastName = 'Смирнова' and  FirstName = 'Елена' and  MiddleName = 'Анатольевна'
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
select *
    from [dbo].[dvtable_{1B1A44FB-1FB1-4876-83AA-95AD38907E24}]
where InstanceID='4538149D-1FC7-4D41-A104-890342C6B4F8'
and name like '%' + 'Программа визита'
--RowID = 2000B7DD-9B6C-41C0-9953-B53AD4C3C224
--InstanceID = 4538149D-1FC7-4D41-A104-890342C6B4F8
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

with tree(Name, RowID, level, pathstr)
         as (select Name, RowID, 0, CAST(t_Group.Name as varchar(550))
             from [dbo].[dvtable_{1B1A44FB-1FB1-4876-83AA-95AD38907E24}] as t_Group
             where ParentTreeRowID = '00000000-0000-0000-0000-000000000000'
             union all
             select t_Group_r.Name, t_Group_r.RowID, tree.level + 1, CAST(tree.pathstr + ' |_ '+  t_Group_r.Name as varchar(550))
             from [dbo].[dvtable_{1B1A44FB-1FB1-4876-83AA-95AD38907E24}] as t_Group_r
                      inner join tree on tree.RowID = t_Group_r.ParentTreeRowID)
select RowID, space(level)+ Name as Name, pathstr, *
from tree
where Name ='Программа визита'
order by pathstr

select *
from tree
where name like '%' + 'Программа визита'

==========
select * from [dbo].[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}] as groups
        where RowID in (
        select ParentRowID
use gaz_dev2

select * from [dbo].[dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}] --17291 запись 3375
 select *   from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]

select * from [docdev2_ref] --удалить
Select * from [gaz_dev2.dbo] -- 17291 - 3182 = 14109

--3182 - удалено!! = 14109
delete from [gaz_dev2.dbo]

select RowID from [docdev2_ref]) --3377



--drop table [gaz_dev2.dbo]
