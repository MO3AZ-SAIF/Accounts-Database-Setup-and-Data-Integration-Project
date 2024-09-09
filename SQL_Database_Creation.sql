-- Create Accounts Database
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'accounts' )
BEGIN
		CREATE DATABASE accounts	
END
GO

USE accounts
GO

-- Create Tables
IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'accountsCountry' )
BEGIN
		CREATE TABLE accountsCountry (
			country_code NVARCHAR(3) PRIMARY KEY,
			short_name NVARCHAR(50),
			table_name NVARCHAR(50),
			long_name NVARCHAR(100),
			currency_unit NVARCHAR(50)
		);
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'accountsSeries' )
BEGIN
		CREATE TABLE accountsSeries (
			series_code NVARCHAR(50) PRIMARY KEY,
			topic NVARCHAR(50),
			indicator_name NVARCHAR(100),
			short_definition TEXT
		);
END
GO
IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'accountsData' )
BEGIN
		CREATE TABLE accountsData (
			country_name NVARCHAR(50),
			country_code NVARCHAR(3),
			series_code NVARCHAR(50),
			indicator_name NVARCHAR(100),
			year_1995 NVARCHAR(50),
			year_2000 NVARCHAR(50),
			year_2005 NVARCHAR(50),
			year_2010 NVARCHAR(50),
			year_2014 NVARCHAR(50)
		);
END
GO

-- Create Foreign Keys and Relationships
IF NOT EXISTS(SELECT * FROM sys.foreign_keys WHERE name = 'fk_country_code' )
BEGIN
	ALTER TABLE accountsData
	ADD CONSTRAINT fk_country_code FOREIGN KEY (country_code) REFERENCES accountsCountry(country_code)
END
GO

IF NOT EXISTS(SELECT * FROM sys.foreign_keys WHERE name = 'fk_series_code' )
BEGIN
	ALTER TABLE accountsData
	ADD CONSTRAINT fk_series_code FOREIGN KEY (series_code) REFERENCES accountsSeries(series_code)
END
GO
