TRUNCATE TABLE TMP_DIRCASA;
DECLARE @VCANT INTEGER;

INSERT INTO TMP_DIRCASA
SELECT P.BusinessEntityID, P.PersonType, P.LastName, AD.AddressLine1, AD.City 
FROM PERSON.PERSON P
	INNER JOIN PERSON.BusinessEntity BE
	ON (P.BusinessEntityID = BE.BusinessEntityID)
		INNER JOIN PERSON.BusinessEntityAddress BEA
		ON (BE.BusinessEntityID = BEA.BusinessEntityID AND BEA.AddressTypeID = 2)
			INNER JOIN PERSON.Address AD ON (BEA.AddressID = AD.AddressID AND AD.City = 'Redmond')
--WHERE BEA.AddressTypeID = 2 AND AD.City = 'Redmond' -también se puede hacer con este where las restricciones.-

SELECT @VCANT = COUNT(1)
FROM TMP_DIRCASA;

IF (@VCANT > 1000)
BEGIN
	PRINT 'MAYOR'
END
ELSE
BEGIN
	PRINT 'MENOR'
END;

SELECT B.*, AD.AddressLine1, AD.City
FROM TMP_DIRCASA B
	LEFT JOIN PERSON.BusinessEntityAddress BEA
		ON (B.BusinessEntityID = BEA.BusinessEntityID AND BEA.AddressTypeID = 5)
			LEFT JOIN PERSON.Address AD ON (BEA.AddressID = AD.AddressID AND AD.City = 'Redmond')