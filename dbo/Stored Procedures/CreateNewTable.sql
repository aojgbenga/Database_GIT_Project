CREATE PROCEDURE CreateNewTable
    @TableName NVARCHAR(128),
    @ColumnDefinitions NVARCHAR(MAX)
AS
BEGIN
    -- Check if the table already exists
    IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@TableName) AND type in (N'U'))
    BEGIN
        RAISERROR ('Table %s already exists.', 16, 1, @TableName)
        RETURN
    END

    -- Dynamic SQL to create a table
    DECLARE @SQL NVARCHAR(MAX)
    SET @SQL = 'CREATE TABLE ' + @TableName + '(' + @ColumnDefinitions + ')'
    EXEC sp_executesql @SQL
END
