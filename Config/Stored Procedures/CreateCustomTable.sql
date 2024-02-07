
CREATE PROCEDURE [Config].[CreateCustomTable]
    @TableName NVARCHAR(128),
    @SchemaName NVARCHAR(128) = 'dbo', -- defaulting to dbo schema
    @ColumnsDefinition NVARCHAR(MAX), -- e.g., "Id INT, Name NVARCHAR(100)"
    @IndexType BIT -- 0 for Clustered, 1 for Non-Clustered
AS
BEGIN
	SET NOCOUNT ON

-- Check if the Table name has been provided 
	IF @TableName IS NULL OR @TableName = '' OR ISNUMERIC(@TableName) = 1
	BEGIN
		RAISERROR ('Table name has not been provided', 16, 1);
		RETURN 1;
	END

-- Check if the Schema name has been provided 
	IF @SchemaName IS NULL OR @SchemaName = '' OR ISNUMERIC(@TableName) = 1
	BEGIN
		RAISERROR ('Schema name has not been provided', 16, 1);
		RETURN 2;
	END

-- Check if the Column Definition name has been provided 
	IF @ColumnsDefinition IS NULL OR @ColumnsDefinition = '' OR ISNUMERIC(@TableName) = 1
	BEGIN
		RAISERROR ('Column Definition has not been provided', 16, 1);
		RETURN 3;
	END


    DECLARE @TSQL NVARCHAR(MAX)
    DECLARE @FullTableName NVARCHAR(255) = QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName)
    DECLARE @IndexSQL NVARCHAR(MAX) = ''

    BEGIN TRY
        -- Prepare table creation statement Dynamic TSQL
        SET @TSQL = 'CREATE TABLE ' + @FullTableName + '(' + @ColumnsDefinition + ')'
        
		-- Execute table creation
        EXEC sp_executesql @TSQL

        -- Prepare index creation statement based on @IndexType
        IF @IndexType = 0 -- 0 Clustered & 1 for non clustered
        BEGIN
            -- Assuming there's a column named 'ID' for the index
            SET @IndexSQL = 'CREATE CLUSTERED INDEX IX_' + @TableName + '_ID ON ' + @FullTableName + '(ID)'
        END
        ELSE
        BEGIN
            -- Non-clustered index, also assuming there's a column named 'ID'
            SET @IndexSQL = 'CREATE NONCLUSTERED INDEX IX_' + @TableName + '_ID ON ' + @FullTableName + '(ID)'
        END

        -- Execute index creation if columns are defined appropriately
        IF CHARINDEX('ID', @ColumnsDefinition) > 0
        BEGIN
            EXEC sp_executesql @IndexSQL
        END
        ELSE
        BEGIN
            -- Using RAISERROR for created Index
            RAISERROR ('Index column ''Id'' not found in column definitions. Index not created.', 16, 1)
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END