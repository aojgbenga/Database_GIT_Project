CREATE TABLE [dbo].[OrderTable1] (
    [ID]          INT            NULL,
    [OrderName]   NVARCHAR (100) NULL,
    [OrderNumber] INT            NULL,
    [OrderDate]   DATE           NULL
);


GO
CREATE CLUSTERED INDEX [IX_OrderTable1_ID]
    ON [dbo].[OrderTable1]([ID] ASC);

