USE [EC_IT143_DA];
GO

CREATE FUNCTION dbo.fn_get_last_name (@FullName VARCHAR(100))
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN LTRIM(SUBSTRING(@FullName, CHARINDEX(' ', @FullName + ' '), LEN(@FullName)))
END;
GO