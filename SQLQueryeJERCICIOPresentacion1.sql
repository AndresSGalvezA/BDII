--Rangos de venta de 0-99 (1), 100-999 (2), 1000-9999 (3), 10000- (4)

SELECT
	CASE 
		WHEN TotalDue BETWEEN 0 AND 99 THEN 1
		WHEN TotalDue BETWEEN 100 AND 999 THEN 2
		WHEN TotalDue BETWEEN 1000 AND 9999 THEN 3
		ELSE 4
	END AS Tipo,
	COUNT( DISTINCT SalesOrderID) AS Cantidad
FROM SALES.SalesOrderHeader
GROUP BY CASE 
		WHEN TotalDue BETWEEN 0 AND 99 THEN 1
		WHEN TotalDue BETWEEN 100 AND 999 THEN 2
		WHEN TotalDue BETWEEN 1000 AND 9999 THEN 3
		ELSE 4
	END
ORDER BY 1 ASC