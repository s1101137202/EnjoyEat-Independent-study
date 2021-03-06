SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George Liu
-- Create date: 2015/11/24
-- Description:	由FB ID取得會員ID
-- Parameter:
--			@strMember_FacebookID 會員FBID
-- OutPut:
--			@outMember_ID 會員ID
-- =============================================
IF OBJECT_ID(N'dbo.SP_GetMemberIDFromFBID', 'p') IS NOT NULL
DROP PROCEDURE dbo.SP_GetMemberIDFromFBID
GO
CREATE PROCEDURE [dbo].[SP_GetMemberIDFromFBID]
	@strMember_FacebookID AS char(30),
	@outMember_ID AS int OUTPUT
AS
BEGIN

SET NOCOUNT ON;

SELECT
	@outMember_ID = Member_ID
FROM Member 
WHERE Member_FacebookID = @strMember_FacebookID

END