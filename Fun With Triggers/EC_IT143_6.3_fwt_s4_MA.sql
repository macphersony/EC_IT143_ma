USE [EC_IT143_DA];
GO

CREATE TRIGGER dbo.tr_customers_audit_date
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
/*****************************************************************************************************************
NAME:    dbo.tr_customers_audit_date
PURPOSE: Automatically updates the last_modified_date and last_modified_by columns.
******************************************************************************************************************/
BEGIN
    UPDATE t
    SET last_modified_date = GETDATE(),
        last_modified_by = SUSER_NAME()
    FROM dbo.t_w3_schools_customers t
    INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO