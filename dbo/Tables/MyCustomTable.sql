CREATE TABLE [dbo].[MyCustomTable] (
    [Id]          INT            NULL,
    [Name]        NVARCHAR (100) NULL,
    [DateOfBirth] DATE           NULL
);


GO
CREATE CLUSTERED INDEX [IX_MyCustomTable_ID]
    ON [dbo].[MyCustomTable]([Id] ASC);

