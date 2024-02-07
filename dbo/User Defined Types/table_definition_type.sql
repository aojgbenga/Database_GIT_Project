CREATE TYPE [dbo].[table_definition_type] AS TABLE (
    [ColumnName]        VARCHAR (255) NULL,
    [ColumnOrder]       INT           NULL,
    [IsNullable]        VARCHAR (3)   NULL,
    [DataType]          VARCHAR (255) NULL,
    [MaxLength]         INT           NULL,
    [Precision]         INT           NULL,
    [Scale]             INT           NULL,
    [DateTimePrecision] INT           NULL,
    [IsIdentity]        BIT           NULL);

