--CREATE PROCEDURE para crearlo.
ALTER PROCEDURE Sales.uspGetContacts
	@pLastName VARCHAR(50), @pTipo INTEGER AS --Parámetros (el as siempre se escribe)
BEGIN
	IF(@PTipo = 1)
	BEGIN
		SELECT TOP 1 V.Name, P.FirstName, P.LastName, CT.Name AS TypeContact
		FROM Purchasing.Vendor V
			INNER JOIN Person.BusinessEntityContact BEC ON (V.BusinessEntityID = BEC.BusinessEntityID)
				INNER JOIN Person.Person P ON (BEC.PersonID = P.BusinessEntityID)
					INNER JOIN Person.ContactType CT ON (BEC.ContactTypeID = CT.ContactTypeID)
		WHERE P.LastName = @pLastName
		ORDER BY P.FirstName ASC
	END
	ELSE
	BEGIN
		PRINT 'No es 1'	
	END
END

EXEC Sales.uspGetContacts 'Perko', 13434