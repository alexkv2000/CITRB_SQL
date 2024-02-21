-- �� '�� ���������' ������ 'Id_��������_���������'
SELECT top 100
       link_cards.InstanceID as Id_��������_���������,
       link_cards.CardId as Id_��������_���������,
       link_cards.DocumentType as ���_���������,
       link_cards.OperatorMessageId as Id_���������,
	   link_cards.MessageState as ������_���������,
       le_boxes.BoxId as Id_�����_�����������,
       partners_boxes.BoxId as Id_�����_�����������,
       files.OperatorFileId
FROM  [dbo].[dvtable_{c03530cf-f7a1-4be5-ad5e-8328fdb9d614}] link_cards
             INNER JOIN [dbo].[dvtable_{70de302e-2fca-4562-9fdb-083b9a14b135}] le_boxes
                    ON le_boxes.RowID = link_cards.OrganizationBox
             INNER JOIN [dbo].[dvtable_{f439cb17-eddb-407d-9161-99613048c60e}] partners_boxes
                    ON partners_boxes.RowID = link_cards.PartnerBox
             INNER JOIN [dbo].[dvtable_{7d729392-7a2a-47a8-8865-14521cb2b99d}] files
                    ON files.InstanceID = link_cards.InstanceID
where link_cards.CardId = '33B87086-DC6F-4111-8A7B-349721CFEA78'-- �� ���������
--=============================
-- ������ MessageState = 6
--����� �������� "�������� ������ �����������"--
--�������� MessageState :
-- �������� = 0,
-- ������� �� ������� �� ����������� = 1,
-- ��������� �� ������� ����������� = 2,
-- ������� ����� �� ����������� = 3,
-- �������� ������� �� ����������� = 4,
-- ������ = 5,
-- ������ � �������� = 6, �������� �� !!!
-- ���������� �������� ������� ����������� = 7,
-- ��������� ������������� ��������� = 8,
-- ���������� ��������� � ��������� = 9,
-- ��������� ��������� = 10,
-- ������� ������ �� ������������� = 11,
-- ��������� ������ �� ������������� = 12,
-- ����������� = 13, ������� �� ����������� = 14,
-- ��������� ����� �� ������� ����������� = 15,
-- ��������� ������ �� ��������� = 16
SELECT mes.RowID, mes.InstanceID, mes.CardId, mes.MessageState, mes.Partner, mes.PartnerBox, mes.OperatorMessageId FROM	[dbo].[dvtable_{C03530CF-F7A1-4BE5-AD5E-8328FDB9D614}] as mes
WHERE -- Partner Like 'beb4a02f50bf4aa4be14a0ff685a6d8d' or Partner Like 'BAF39DA5-7B6C-42DB-957E-C070BB7E31A1'
cardid like '33B87086-DC6F-4111-8A7B-349721CFEA78'
--=============================
