CREATE TABLE Persona
(
	ID INT NOT NULL,
	Nombre VARCHAR(50),
	[Nombre anterior] VARCHAR(50),
	[Cuenta nombre igual] INT
	CONSTRAINT PK_Persona PRIMARY KEY (ID)
)

INSERT INTO Persona (ID, Nombre) VALUES (1, 'Walter');
INSERT INTO Persona (ID, Nombre) VALUES (2, 'Derly');
INSERT INTO Persona (ID, Nombre) VALUES (3, 'Allan');

INSERT INTO Persona (ID, Nombre) VALUES (4, 'Walter');
INSERT INTO Persona (ID, Nombre) VALUES (5, 'Walter');
INSERT INTO Persona (ID, Nombre) VALUES (6, 'Walter');

SELECT *
FROM Persona

ALTER TRIGGER tiu_valida ON Persona AFTER INSERT, UPDATE AS
DECLARE @valorNuevo VARCHAR(50)

SELECT @valorNuevo = Nombre
FROM INSERTED

	UPDATE Persona
	SET [Cuenta nombre igual] = (SELECT COUNT(1) FROM Persona WHERE Nombre = @valorNuevo)
	FROM Persona P
		INNER JOIN INSERTED I ON P.ID = I.ID;