CREATE PROCEDURE Sales.uspGetContact
	@pLastName VARCHAR(50), --input
	@pID INTEGER OUTPUT AS --output
BEGIN
	SET @pID = 0 --asignación manual
	SELECT TOP 1 @pID = BEC.PersonID
	FROM Purchasing.Vendor V
		INNER JOIN Person.BusinessEntityContact BEC ON (V.BusinessEntityID = BEC.BusinessEntityID)
			INNER JOIN Person.Person P ON (BEC.PersonID = P.BusinessEntityID)
	WHERE P.LastName = @pLastName
	ORDER BY P.FirstName ASC
	END
END

CREATE PROCEDURE Sales.uspTempEjecucion AS
BEGIN
	DECLARE @pCodigo INTEGER
	SET @pCodigo = 0
	EXEC Sales.uspGetContacts 'Whitney', @pCodigo OUTPUT

	IF (@pCodigo = 0)
	BEGIN
		PRINT 'No existe'
	END
	ELSE
	BEGIN
		PRINT @pCodigo
	END
END