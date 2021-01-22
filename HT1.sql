--Ejercicio 1.
SELECT P.Name, YEAR(WO.StartDate) AS Año, COUNT(1) AS [Órdenes de trabajo]
FROM Production.WorkOrder WO
	INNER JOIN Production.Product P ON (WO.ProductID = P.ProductID)
GROUP BY P.Name, YEAR(WO.StartDate)
ORDER BY P.Name, YEAR(WO.StartDate)


--Ejercicio 2.
CREATE PROCEDURE Purchasing.upsUpdateShipMethod
	@pAño INTEGER, @pMes INTEGER, @pProducto VARCHAR(50) AS
BEGIN
	UPDATE Purchasing.PurchaseOrderHeader
	SET Purchasing.PurchaseOrderHeader.ShipMethodID = 3
	FROM Purchasing.PurchaseOrderHeader POH
		INNER JOIN Purchasing.PurchaseOrderDetail POD ON (POH.PurchaseOrderID = POD.PurchaseOrderID) 
			INNER JOIN Production.Product P	ON (POD.ProductID = P.ProductID)
	WHERE P.Name = @pProducto AND YEAR(POH.OrderDate) = @pAño AND MONTH(POH.OrderDate) = @pMes
END
----------------------------
EXEC Purchasing.upsUpdateShipMethod 2012, 1, 'External Lock Washer 3'


--Ejercicio 3.
CREATE FUNCTION ufnGetAVG (@SalesOrderID INT) RETURNS INT AS
BEGIN
	DECLARE @PromedioDeArticulos MONEY
	SET @PromedioDeArticulos = 0.00
	SELECT @PromedioDeArticulos = AVG(P.ListPrice) FROM Sales.SalesOrderHeader SOH
		INNER JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
			INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
	WHERE (@SalesOrderID = SOH.SalesOrderID)
	GROUP BY SOH.SalesOrderID
	RETURN @PromedioDeArticulos
END
----------------------------
SELECT SOH.SalesOrderID, SOH.OrderDate, SOH.TotalDue, dbo.ufnGetAVG(SOH.SalesOrderID) AS Average
FROM Sales.SalesOrderHeader SOH