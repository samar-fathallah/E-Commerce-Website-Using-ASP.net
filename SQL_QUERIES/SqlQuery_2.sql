/*CREATE FUNCTION  checkOfferonProduct
(@serial int)
RETURNS BIT
BEGIN

DECLARE  @activeoffer BIT
IF(EXISTS (SELECT * FROM OfferOnProduct WHERE serial_no=@serial)
SET @activeoffer = ‘1’
ELSE
SET @activeoffer= ‘0’
RETURN @activeoffer
END
*/



/*CREATE PROC checkTodaysDealOnProduct
@serial_no INT
@activeDeal BIT OUTPUT
AS
BEGIN


IF(EXISTS (SELECT * FROM Todays_Deals_Product WHERE serial_no=@serial_no))
SET @activeDeal='1'
ELSE
SET @activeDeal= '0'

END
*/

