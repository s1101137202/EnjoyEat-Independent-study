-- =============================================
-- Author:		George Liu
-- Create date: 2015/10/26
-- Description:	取得代碼檔
-- Parameter:
--			@strTypeCode_Parent 代碼類型
--			@intTypeCode_ID 代碼編號
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.FN_TypeCode', N'FN') IS NOT NULL
DROP FUNCTION dbo.FN_TypeCode
GO
CREATE FUNCTION [dbo].[FN_TypeCode]
( @strTypeCode_Parent AS varchar(50) ,
  @intTypeCode_ID AS int 
)
RETURNS nvarchar(50)
AS
BEGIN
DECLARE @strResult nvarchar(50)
SET @strResult  = '';
SELECT @strResult =  TypeCode_Name 
FROM TypeCode
WHERE  TypeCode_Parent  = @strTypeCode_Parent
AND TypeCode_ID = @intTypeCode_ID;

  RETURN @strResult
END