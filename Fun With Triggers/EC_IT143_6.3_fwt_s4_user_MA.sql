USE [EC_IT143_DA];
GO

CREATE OR ALTER TRIGGER dbo.tr_customers_audit
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    UPDATE t
    SET last_modified_date = GETDATE(),
        last_modified_by = SUSER_NAME() -- This captures the "Who"
    FROM dbo.t_w3_schools_customers t
    INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO