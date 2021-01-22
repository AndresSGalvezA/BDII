--Crear funci�n que regresa el inventario de alg�n producto
--en espec�fico
CREATE FUNCTION ufnGetStock (@pID INT) RETURNS INT AS
BEGIN
	DECLARE @CantidadRetorna INTEGER
	SET @CantidadRetorna = 0
	SELECT @CantidadRetorna = Quantity
	FROM Production.ProductInventory
	WHERE ProductID = @pID AND LocationID = 50

	IF (@CantidadRetorna IS NULL)
	BEGIN
		SET @CantidadRetorna = 0
	END

	RETURN ISNULL(@CantidadRetorna, 0) --Esto hace lo mismo que el if.
END

SELECT ProductID, Name, dbo.ufnGetStock(ProductID) cantidad_existencia
FROM Production.Product