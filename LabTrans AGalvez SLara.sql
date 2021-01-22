--Andres Gálvez - 1024718
--Sergio Lara - 1044418

--Crear un proc que aplique un descuento D...
CREATE OR ALTER PROCEDURE Sales.uspDiscount @salesOrder INT, @discount  MONEY
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	BEGIN TRAN
		UPDATE Sales.SalesOrderDetail
		SET UnitPriceDiscount = @discount
		WHERE (SalesOrderID = @salesOrder) AND (OrderQty > 2)
		COMMIT
END

EXEC Sales.uspDiscount 43659, 0.69 

--Al departamento de DWH le han solicitado generar una tabla resumen...
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT MONTH(B.ModifiedDate) Mes, YEAR(B.ModifiedDate) Año, A.Name Nombre, B.OrderQty, B.UnitPrice, C.UnitPriceDiscount
FROM Purchasing.PurchaseOrderDetail B INNER JOIN Production.Product A ON (A.ProductID = B.ProductID)
    INNER JOIN Sales.SalesOrderDetail C ON (C.ProductID = A.ProductID)
WAITFOR DELAY '00:00:59'
SELECT MONTH(B.ModifiedDate) Mes, YEAR(B.ModifiedDate) Año, A.Name Nombre, B.OrderQty, B.UnitPrice, C.UnitPriceDiscount
FROM Purchasing.PurchaseOrderDetail B INNER JOIN Production.Product A ON (A.ProductID = B.ProductID)
    INNER JOIN Sales.SalesOrderDetail C ON (C.ProductID = A.ProductID)
ROLLBACK