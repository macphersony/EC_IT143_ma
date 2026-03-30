--Q: How can I display a simple message?
--A: Let's write a Select statement and see what SQL Server says


CREATE VIEW v_hello_world
AS
SELECT 'Hello World' AS message;


SELECT *
INTO t_hello_world
FROM v_hello_world;


DROP TABLE IF EXISTS t_hello_world;

CREATE TABLE t_hello_world (
    message VARCHAR(50) NOT NULL PRIMARY KEY );



TRUNCATE TABLE t_hello_world;

INSERT INTO t_hello_world (message)
SELECT message
FROM v_hello_world;
