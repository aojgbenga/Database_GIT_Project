CREATE TABLE [dbo].[MrOlu] (
    [ID]          INT            NULL,
    [Name]        NVARCHAR (100) NULL,
    [DateOfBirth] DATE           NULL
);


GO
CREATE CLUSTERED INDEX [IX_MrOlu_ID]
    ON [dbo].[MrOlu]([ID] ASC);

