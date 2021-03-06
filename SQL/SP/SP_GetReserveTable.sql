SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George Liu
-- Create date: 2015/10/27
-- Description:	取得訂位桌次
-- Parameter:
--			@intRestaurant_ID 訂位餐廳編號
--			@intReservation_Peoplenumber 訂位人數
--			@timeRestaurantOrderTime_Time 訂位時間
--			@dateReservation_Date 訂位日期
-- OutPut:
--			@outRestaurantTable_Name 桌位名稱
--			@outRestaurantTable_People 桌位容納人數
-- =============================================
IF OBJECT_ID(N'dbo.SP_GetReserveTable', 'p') IS NOT NULL
DROP PROCEDURE dbo.SP_GetReserveTable
GO
CREATE PROCEDURE [dbo].[SP_GetReserveTable]
	@intRestaurant_ID AS int,
	@intReservation_Peoplenumber AS int,
	@timeRestaurantOrderTime_Time AS Time(7),
	@dateReservation_Date AS Date,
	@outRestaurantTable_Name AS nvarchar(10) OUTPUT,
	@outRestaurantTable_People AS int OUTPUT
AS
BEGIN

SET NOCOUNT ON;

SELECT
TOP 1
	@outRestaurantTable_Name = RT.RestaurantTable_Name,
	@outRestaurantTable_People = RT.RestaurantTable_People
FROM RestaurantTable AS RT
INNER JOIN Restaurant AS R
	ON R.Restaurant_ID = RT.Restaurant_ID
	AND R.Restaurant_ID = @intRestaurant_ID
INNER JOIN RestaurantOrderTime AS RO
	ON RO.Restaurant_ID = R.Restaurant_ID
	AND RO.RestaurantOrderTime_Open = 1
LEFT JOIN Reservation AS RV
	ON RV.RestaurantOrderTime_Time = RO.RestaurantOrderTime_Time
	AND RV.Restaurant_ID = RT.Restaurant_ID
	AND RV.RestaurantTable_Name = RT.RestaurantTable_Name
	AND RV.Reservation_Date = @dateReservation_Date
WHERE RestaurantTable_People >= @intReservation_Peoplenumber
AND RV.Reservation_ID IS NULL
AND CONVERT(
CHAR(5),
RO.RestaurantOrderTime_Time,
108
) = @timeRestaurantOrderTime_Time
ORDER BY RT.RestaurantTable_People, RT.RestaurantTable_Name

END