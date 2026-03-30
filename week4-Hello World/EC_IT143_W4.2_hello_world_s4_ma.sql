--Q: How can I display a simple message?
--A: Let's write a Select statement and see what SQL Server says

--SELECT 'Hello World' AS my_message



CREATE VIEW v_hello_world
AS
SELECT 'Hello World' AS message;