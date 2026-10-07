-- Explore All Objects in the Database
SELECT *
FROM INFORMATION_SCHEMA.Tables;


-- Explore All Columns in the Database
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE Table_Name = 'dim_customers';