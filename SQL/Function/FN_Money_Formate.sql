-- =============================================
-- Author:		George Liu
-- Create date: 2015/10/25
-- Description:	格式化金錢
-- Parameter:
--			@intMoney 金錢
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.FN_Money_Formate', N'FN') IS NOT NULL
DROP FUNCTION dbo.FN_Money_Formate
GO
CREATE FUNCTION [dbo].[FN_Money_Formate]
( @intMoney AS int 
)
RETURNS varchar(14)
AS
BEGIN
DECLARE @strResult  varchar(14)

SET @strResult = REPLACE(CONVERT(VARCHAR(14), CONVERT(MONEY, @intMoney), 1),'.00','') 
RETURN @strResult
END