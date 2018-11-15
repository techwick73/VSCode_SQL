SELECT c.FirstName ,c.LastName ,c.CompanyName
FROM SalesLT.Customer AS C


EXEC sp_helptext @objname=N'ufnGetCustomerInformation'

SELECT
    O.name
    ,O.type_desc
FROM
    sys.all_objects AS O
WHERE (O.type='P' OR O.type='FN' OR O.type='TF' OR O.type='IF')
    AND O.is_ms_shipped=0

SELECT [Name] ,[Type_Desc]
FROM [sys].[all_objects]
WHERE ([Type] = 'P' OR [Type]='FN' OR [Type]='TF' OR [Type]='IF')
    AND [Is_MS_Shipped] = 0

