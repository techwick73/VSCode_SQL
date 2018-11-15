USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
  SELECT name
FROM sys.databases
WHERE name = N'AdventureWorksLT'
)
CREATE DATABASE AdventureWorksLT
ON (FILENAME='C:\Lab\cross-platform-sql-server-management-developers-vs-code\adventureworkslt.mdf')
FOR ATTACH
GO
