SELECT DISTINCT TYPE
FROM SYS.objects
WHERE TYPE = 'U' AND NAME LIKE '%Sales%'

SELECT *
FROM SYS.stats
WHERE object_id = 1922105888

DBCC SHOW_STATISTICS ('Sales.SalesOrderHeader','revision_num_sales') --Mostrar la estadística.

CREATE STATISTICS revision_num_sales ON Sales.SalesOrderHeader (RevisionNumber) --Cuando necesito que se lleve una estadística en este campo.

SELECT *
FROM Persona

SELECT *
FROM Sales.SalesOrderHeader SOH
	INNER JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderDetailID
ORDER BY SOH.SalesPersonID