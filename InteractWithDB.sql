-- Get a list of tables and views in the current database
-- A second comment line
SELECT table_catalog [database] ,table_schema [schema] ,table_name name ,table_type type
FROM INFORMATION_SCHEMA.TABLES
GO

USE AdventureWorksLT

SELECT *
FROM SalesLT.ProductDescription
GO

SELECT *
FROM SalesLT.Customer
WHERE lastname LIKE 'A%'
GO

-- List columns in all tables whose name is like 'TableName'
SELECT
    TableName = tbl.TABLE_SCHEMA + '.' + tbl.TABLE_NAME
    ,ColumnName = col.COLUMN_NAME
    ,ColumnDataType = col.DATA_TYPE
FROM INFORMATION_SCHEMA.TABLES tbl
    INNER JOIN INFORMATION_SCHEMA.COLUMNS col
    ON col.TABLE_NAME = tbl.TABLE_NAME
        AND col.TABLE_SCHEMA = tbl.TABLE_SCHEMA

WHERE tbl.TABLE_TYPE = 'BASE TABLE' AND tbl.TABLE_NAME LIKE '%Customer%'
GO

-- Get the space used by table Customer
SELECT TABL.name AS table_name
    ,INDX.name AS index_name
    ,SUM(PART.rows) AS rows_count
    ,SUM(ALOC.total_pages) AS total_pages
    ,SUM(ALOC.used_pages) AS used_pages
    ,SUM(ALOC.data_pages) AS data_pages
    ,(SUM(ALOC.total_pages)*8/1024) AS total_space_MB
    ,(SUM(ALOC.used_pages)*8/1024) AS used_space_MB
    ,(SUM(ALOC.data_pages)*8/1024) AS data_space_MB
FROM sys.tables AS TABL
    INNER JOIN sys.indexes AS INDX
    ON TABL.object_id = INDX.object_id
    INNER JOIN sys.partitions AS PART
    ON INDX.object_id = PART.object_id
        AND INDX.index_id = PART.index_id
    INNER JOIN sys.allocation_units AS ALOC
    ON PART.partition_id = ALOC.container_id
WHERE TABL.name LIKE '%Customer%'
    AND INDX.object_id > 255
    AND INDX.index_id <= 1
GROUP BY TABL.name,
INDX.object_id,
INDX.index_id,
INDX.name
ORDER BY Object_Name(INDX.object_id),
(SUM(ALOC.total_pages)*8/1024) DESC
GO

-- Get a list of databases
SELECT name
FROM sys.databases
GO


-- Create a new database called 'CourseViewers'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
FROM sys.databases
WHERE name = N'CourseViewers'
)
CREATE DATABASE CourseViewers
GO

USE CourseViewers
GO

CREATE SCHEMA Pluralsight
GO

-- Create a new table called 'Users' in schema 'Pluralsight'
-- Drop the table if it already exists
IF OBJECT_ID('Pluralsight.Users', 'U') IS NOT NULL
DROP TABLE Pluralsight.Users
GO
-- Create the table in the specified schema
CREATE TABLE Pluralsight.Users
(
    UserId    int            IDENTITY(1,1)
    -- primary key column
    ,FirstName [nvarchar](50) NOT NULL
    ,LastName  [nvarchar](50) NOT NULL
    -- specify more columns here
);
GO

-- Select rows from a Table or View 'Users' in schema 'Pluralsight'
SELECT *
FROM Pluralsight.Users
--WHERE 	/* add search conditions here */
GO

-- Insert rows into table 'Users'
INSERT INTO Pluralsight.Users
VALUES
    ( 'Julie' ,'Lerman')
    ,('Darth' ,'Vader')
GO
