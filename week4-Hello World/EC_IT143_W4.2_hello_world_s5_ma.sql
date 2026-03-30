--Q: How can I display a simple message?
--A: Let's write a Select statement and see what SQL Server says
-- EC_IT143_W4.2_hello_world_s4_xx.sql

--CREATE VIEW v_hello_world
--AS
--SELECT 'Hello World' AS message;


--SELECT *
--INTO t_hello_world
--FROM v_hello_world;


DROP TABLE IF EXISTS t_hello_world;

CREATE TABLE t_hello_world (
    message VARCHAR(50) NOT NULL PRIMARY KEY );
