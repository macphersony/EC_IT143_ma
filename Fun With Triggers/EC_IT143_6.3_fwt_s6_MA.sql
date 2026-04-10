USE [EC_IT143_DA];
GO

-- This replaces your old trigger with the fixed version
CREATE OR ALTER TRIGGER dbo.tr_customers_audit
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    -- This stops an Infinite Loop 
    -- It tells the trigger to stop if it was called by another trigger
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    UPDATE t
    SET last_modified_date = GETDATE(),
        last_modified_by = SUSER_NAME()
    FROM dbo.t_w3_schools_customers t
    INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO