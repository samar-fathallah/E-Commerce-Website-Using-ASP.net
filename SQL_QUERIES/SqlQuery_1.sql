﻿CREATE PROC checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard BIT OUTPUT 
AS 
BEGIN
IF EXISTS (SELECT code FROM Giftcard WHERE code=@code) 
BEGIN
   @activeGiftCard=1
END
ELSE
BEGIN
   @activeGiftCard=0
END
PRINT @activeGiftCard
END 
GO
/*CREATE PROC checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard BIT OUTPUT
AS
BEGIN


IF(EXISTS (SELECT * FROM Giftcard WHERE code=@code))
SET @activeGiftCard = ‘1’
ELSE
SET @activeGiftCard = ‘0’

END
*/
CREATE PROC giveGiftCardtoCustomer
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
BEGIN 
UPDATE Users 
SET password=@password,first_name=@first_name,last_name=@last_name,email=@email
WHERE username=@username
END 
GO
CREATE PROC viewmyorders
@deliveryperson varchar(20)
AS 
BEGIN
SELECT O.*
FROM Orders O
INNER JOIN Admin_Delivery_Order A ON A.order_no= O.order_no
WHERE A.delivery_username=@deliveryperson
END 
GO
CREATE PROC specifyDeliveryWindow 
@delivery_username varchar(20),
@order_no int,
@delivery_window varchar(50)
AS 
BEGIN
UPDATE Admin_Delivery_Order
SET delivery_window=@delivery_window
WHERE delivery_username=@delivery_username AND order_no=@order_no
END
GO
CREATE PROC updateOrderStatusOutforDelivery
@order_no int
AS
BEGIN
UPDATE Orders 
SET order_status='out for delivery'
WHERE order_no=@order_no
END
GO
CREATE PROC updateOrderStatusDelivered 
@order_no int
AS
BEGIN
UPDATE Orders 
SET order_status='Delivered'
WHERE order_no=@order_no
END
