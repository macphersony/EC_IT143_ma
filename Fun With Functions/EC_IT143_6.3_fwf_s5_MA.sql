USE [EC_IT143_DA];
GO

-- this is If the function already exists, we drop it so we can recreate it
DROP FUNCTION IF EXISTS dbo.fn_get_first_name;
GO

CREATE FUNCTION dbo.fn_get_first_name (@FullName VARCHAR(100))
RETURNS VARCHAR(50)
AS
BEGIN
    -- This logic finds the space and returns everything to the left
    RETURN LEFT(@FullName, CHARINDEX(' ', @FullName + ' ') - 1)
END;
GO