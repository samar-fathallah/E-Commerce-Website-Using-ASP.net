CREATE PROC checkGiftCardOnCustomer
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
CREATE PROC giveGiftCardtoCustomer@code varchar(10),@customer_name varchar(20),@admin_username varchar(20)ASDECLARE @custpoints SMALLINTDECLARE @cardpoints SMALLINTBEGIN SELECT @cardpoints=c.pointsFROM Giftcard cWHERE c.code=@codeSELECT @custpoints=c.pointsFROM Customer cWHERE c.username=@customer_nameINSERT INTO Admin_Customer_Giftcard VALUES (@code,@customer_name,@admin_username,@custoints+@cardpoints)ENDGOCREATE PROC acceptAdminInvitation @delivery_username varchar(20)ASBEGIN INSERT INTO Delivery_Person(username) VALUES (@delivery_username)END GO CREATE PROC deliveryPersonUpdateInfo@username varchar(20),
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

