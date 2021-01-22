--CREATE TRIGGER tiu.aviso1 ........
ALTER TRIGGER Sales.tiu_aviso1 ON Sales.Customer AFTER INSERT, UPDATE AS
-- Hay dos objetos:
	-- INSERTED --> NUEVO
	-- DELETED --> VIEJO O ANTERIOR
DECLARE @valorAnterior int
DECLARE @valorNuevo int

SELECT @valorAnterior = PersonID
FROM DELETED 

SELECT @valorNuevo = PersonID
FROM INSERTED

	IF UPDATE(PersonID) --Esto valida si se está actualizando el cambio
	BEGIN
		PRINT 'Se modifica dato de PersonID.'
		PRINT @valorAnterior;
		PRINT @valorNuevo;
	END
	ELSE
	BEGIN
		PRINT 'No se modifica el campo correcto.'
	END
	

SELECT *
FROM Sales.Customer

UPDATE Sales.Customer
SET PersonID = 30
WHERE CustomerID = 15