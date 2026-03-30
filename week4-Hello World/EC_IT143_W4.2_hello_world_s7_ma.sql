

--CREATE PROCEDURE sp_load_hello_world
--AS 
--BEGIN
--    TRUNCATE TABLE t_hello_world;

--    INSERT INTO t_hello_world (message)
--    SELECT message
--    FROM v_hello_world;
--END;

SELECT *
FROM dbo.v_hello_world