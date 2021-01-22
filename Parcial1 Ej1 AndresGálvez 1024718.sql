CREATE TRIGGER Sales.ti_IngresarOrdenCarrito ON Sales.ShoppingCartItem AFTER INSERT AS
DECLARE @shoppingCartID INT, @productQ INT, @itemID INT, @productID INT, @inventoryQuantity INT

SELECT @shoppingCartID = I.ShoppingCartID, @productQ = I.Quantity, @productID = I.ProductID, @itemID = ShoppingCartItemID
FROM INSERTED I

SELECT @inventoryQuantity = Quantity 
FROM Production.ProductInventory 
WHERE  ProductID = @productID

IF EXISTS (SELECT * FROM Sales.ShoppingCartItem WHERE (ShoppingCartID = @shoppingCartID AND ProductID = @productQ AND ShoppingCartItemID != @itemID))
BEGIN
   PRINT 'Transacción rechazada. Orden existente.'
   ROLLBACK TRANSACTION
END

IF (@productQ > @inventoryQuantity)
BEGIN
	PRINT 'Transacción rechazada. Inventario insuficiente.'
    ROLLBACK TRANSACTION
END