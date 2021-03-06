-- =============================================
-- Author:		George Liu
-- Create date: 2015/10/26
-- Description:	取出該餐廳所有分類並用逗號分隔
-- Parameter:
--			@intId 餐廳編號
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.FN_RestaurantClassification', N'FN') IS NOT NULL
DROP FUNCTION dbo.FN_RestaurantClassification
GO
CREATE FUNCTION [dbo].[FN_RestaurantClassification]
( @intRestaurant_ID AS int 
)
RETURNS nvarchar(200)
AS
BEGIN
DECLARE @strResult  nvarchar(MAX)

SELECT
	@strResult = COALESCE(@strResult + ',' + RestaurantClassification_Name, RestaurantClassification_Name)
FROM Restaurant
INNER JOIN RestaurantClassificationRecord AS RCR
	ON Restaurant.Restaurant_ID = RCR.Restaurant_ID
INNER JOIN RestaurantClassification AS RC
	ON RCR.RestaurantClassification_ID = RC.RestaurantClassification_ID
WHERE Restaurant.Restaurant_ID = @intRestaurant_ID;

RETURN @strResult
END