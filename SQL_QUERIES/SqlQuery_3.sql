CREATE PROC specifydeliverytype
@orderID int, @deliveryID int
AS
DECLARE @days INT
BEGIN
SELECT @days=time_duration
FROM Delivery
WHERE id=@deliveryID 

UPDATE Orders 
SET delivery_id=@deliveryID
WHERE order_no=@orderID
SELECT
END