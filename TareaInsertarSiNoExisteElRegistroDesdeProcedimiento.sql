CREATE PROCEDURE Sales.uspGetOrCreateContact 
	@pLastName VARCHAR(50),
	@pCodigo INTEGER OUTPUT AS
BEGIN
	SET @pCodigo = 0
	EXEC Sales.uspGetContact @pLastName, @pCodigo OUTPUT

	IF (@pCodigo = 0)
	BEGIN
		INSERT INTO Person.Person(LastName)
		VALUES (@pLastName)
		PRINT 'Registro insertado.'
	END
END
