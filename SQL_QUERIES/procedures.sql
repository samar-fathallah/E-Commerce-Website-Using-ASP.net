CREATE or alter PROC userLogiN
@username varchar(20), 
@password varchar(20),
@success BIT OUTPUT,
@TYPE BIT OUTPUT 
AS 
BEGIN 
IF EXISTS (SELECT * FROM Users WHERE username=@username)
BEGIN
SET @success='1'
IF EXISTS (SELECT * FROM Customer WHERE username=@username )
SET @TYPE='0'
IF EXISTS (SELECT * FROM Vendor WHERE username=@username )
SET @TYPE='1'
IF EXISTS (SELECT * FROM Admins WHERE username=@username )
SET @TYPE='2'
IF EXISTS (SELECT * FROM Delivery WHERE username=@username)
SET @TYPE='3'

END
ELSE 
SET @success='0'
SET @TYPE='-1'

END
GO 
CREATE PROC addMobile
@username varchar(20), 
@mobile_number varchar(20)
AS
BEGIN
INSERT INTO User_mobile_numbers VALUES (@username,@mobile_number)
END 
GO
CREATE PROC addAddress
@username varchar(20), 
@address varchar(100)
AS 
BEGIN
INSERT INTO User_Addresses VALUES (@username,@address)
END 
GO 
CREATE PROC customerRegister
       @username VARCHAR(20),
       @first_name VARCHAR(20),
       @last_name VARCHAR(20),
       @password VARCHAR(20),
       @email VARCHAR(50)
AS 
BEGIN
IF @username IS NULL or @first_name IS NULL or @last_name IS NULL or @password IS NULL or @email IS NULL
print 'One of the inputs is null'
Else
INSERT INTO users(username, first_name, last_name, password, email) VALUES(@username, @first_name, @last_name, @password, @email)
INSERT INTO Customer VALUES (@username,0)
END
GO
CREATE PROC vendorRegister
       @username VARCHAR(20),
       @first_name VARCHAR(20),
       @last_name VARCHAR(20),
       @password VARCHAR(20),
       @email VARCHAR(50),
       @company_name VARCHAR(20),
       @bank_acc_no VARCHAR(20)
AS 
BEGIN
IF @username IS NULL or @first_name IS NULL or @last_name IS NULL or @password IS NULL or @email IS NULL or @company_name IS NULL or @bank_acc_no IS NULL
print 'One of the inputs is null'
Else
INSERT INTO users(username, first_name, last_name, password, email) VALUES(@username, @first_name, @last_name, @password, @email)
INSERT INTO Vendor(username,activated,company_name,bank_acc_no) VALUES (@username,0,@company_name,@bank_acc_no)
END


/* registered User page 1 */
GO
CREATE PROC showProducts
AS
BEGIN
        SELECT *
        FROM Product
END
GO




CREATE PROC ShowProductsbyPrice
AS
BEGIN
        SELECT *
        FROM Product
        ORDER BY price
END


GO

CREATE PROC searchbyname
        @name VARCHAR(20)
AS
BEGIN
        SELECT *
        FROM Product
        where product_name = @name
END
GO
CREATE PROC AddQuestion
        @serial INT,
        @customer varchar(20), 
        @Question varchar(50)
AS
BEGIN
     INSERT INTO Customer_Question_Product(serial_no,customer_name,question)
     VALUES(@serial,@customer,@Question)
END

GO

CREATE PROC addToCart
        @customername VARCHAR(20), 
        @serial INT
AS
BEGIN
        INSERT INTO CustomerAddstoCartProduct
        VALUES (@serial,@customername)
		
END

GO

CREATE PROC removefromCart
        @customername VARCHAR(20), 
        @serial INT
AS
BEGIN   
        DELETE FROM CustomerAddstoCartProduct
        WHERE serial_no= @serial AND customer_name = @customername       
END
GO
CREATE PROC createWishlist
        @customername varchar(20), 
        @name varchar(20)
AS
BEGIN
        INSERT INTO Wishlist VALUES (@customername , @name)
END

GO

CREATE PROC AddtoWishlist
       @customername varchar(20), 
       @wishlistname varchar(20), 
       @serial int
AS
BEGIN
        INSERT INTO Wishlist_Product VALUES(@customername,@wishlistname,@serial)      
END

GO

CREATE PROC removefromWishlist
       @customername varchar(20), 
       @wishlistname varchar(20), 
       @serial int
AS
BEGIN   
        DELETE FROM Wishlist_Product
        WHERE serial_no= @serial AND wish_name = @wishlistname     
END
GO
CREATE PROC showWishlistProduct
        @customername varchar(20), 
        @name varchar(20)
AS
BEGIN   
        SELECT p.*
        FROM Product p
        INNER JOIN Wishlist_Product w ON w.serial_no = p.serial_no 
        WHERE w.wish_name = @name AND w.username = @customername
END
GO
CREATE PROC viewMyCart
        @customer varchar(20)
AS
BEGIN   
        SELECT p.*
        FROM Product p
        INNER JOIN CustomerAddstoCartProduct c ON c.serial_no = p.serial_no 
        WHERE c.customer_name = @customer
END

GO

CREATE PROC calculatepriceOrder
        @customername varchar(20),
        @sum decimal(10,2) OUTPUT
AS
BEGIN   
        SELECT @sum = SUM(p.final_price)
        FROM Product p
        INNER JOIN CustomerAddstoCartProduct c ON c.serial_no = p.serial_no 
        WHERE c.customer_name = @customername
END

GO
CREATE OR ALTER PROC productsinorder
        @customername varchar(20), 
        @orderID int
AS
BEGIN   
UPDATE product 
SET customer_order_id= @orderID,customer_username=@customername
WHERE serial_no=ANY(SELECT c.serial_no FROM CustomerAddstoCartProduct c WHERE c.customer_name=@customername)
        SELECT P.*
        FROM CustomerAddstoCartProduct c
        INNER JOIN Product P ON c.serial_no = P.serial_no
       /* where customer_order_id= @orderID*/

        DELETE FROM CustomerAddstoCartProduct
		WHERE serial_no= ANY(SELECT c.serial_no FROM CustomerAddstoCartProduct c WHERE c.customer_name=@customername) 
		AND customer_name <> @customername
END

GO
CREATE PROC emptyCart
        @customername varchar(20)
AS
BEGIN   
        DELETE FROM CustomerAddstoCartProduct
        WHERE customer_name= @customername 
END
GO
CREATE PROC makeOrder
 @customername varchar(20)
 AS 
 BEGIN
 DECLARE @sum INT
 
EXEC calculatepriceOrder @sum OUTPUT

EXEC emptyCart 
INSERT INTO Orders(order_date,total_amount,customer_name) VALUES (CURRENT_TIMESTAMP,@sum,@customername)

END
go
alter proc makeOrder
 @customername varchar(20)

 AS 
 DECLARE @sum INT
 BEGIN
 
EXEC calculatepriceOrder @customername ,@sum OUTPUT

INSERT INTO Orders(order_date,total_amount,customer_name) VALUES (CURRENT_TIMESTAMP,@sum,@customername)
/*EXEC emptyCart @customername*/
END
GO
CREATE OR ALTER PROC cancelOrder
@orderid INT
AS
DECLARE @status varchar(20)
SELECT @status = order_status
FROM Orders
WHERE order_no = @orderid

IF (@status = 'not processed' OR @status = 'in process')
BEGIN

DECLARE @giftcardcode VARCHAR(10)
SELECT @giftcardcode = Gift_Card_code_used
FROM Orders
WHERE order_no = @orderid

DECLARE @total_amount DECIMAL(10,2)
SELECT @total_amount = total_amount
FROM Orders
WHERE order_no = @orderid

DECLARE @payment_type VARCHAR(20)
SELECT @payment_type = payment_type
FROM Orders
WHERE order_no = @orderid

DECLARE @customer_name VARCHAR(20)
SELECT @customer_name = customer_name
FROM Orders
WHERE order_no = @orderid

DECLARE @partial_amount DECIMAL(10,2)
IF (@payment_type = 'cash')
BEGIN
SELECT @partial_amount = cash_amount
FROM Orders
WHERE order_no = @orderid
END

ELSE
BEGIN
SELECT @partial_amount = credit_amount
FROM Orders
WHERE order_no = @orderid
END

DECLARE @points INT
SET @points = @total_amount - @partial_amount

IF EXISTS(
SELECT *
FROM Giftcard
WHERE code = @giftcardcode and expiry_date>CURRENT_TIMESTAMP
)
BEGIN
UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points + @points
WHERE customer_name = @customer_name

UPDATE Customer
SET points = points + @points
WHERE username = @customer_name
END

UPDATE Product
SET customer_username = null , customer_order_id = null ,rate = null, available = 1
WHERE customer_order_id = @orderid

DELETE FROM Admin_Delivery_Order
WHERE order_no = @orderid

DELETE FROM Orders
WHERE order_no = @orderid
END

ELSE
BEGIN
PRINT 'Cannot cancel order'
END
GO
returnProduct
go
create OR ALTER proc returnProduct
@serialno int,
@orderid int
as

declare @total_amount decimal(10,2)
select @total_amount = total_amount
from Orders
where order_no = @orderid

declare @price decimal(10,2)
select @price = final_price
from Product
where serial_no = @serialno and customer_order_id = @orderid

declare @paid decimal(10,2)
if ( (select payment_type from Orders where order_no = @orderid) = 'cash' )
begin
select @paid = cash_amount
from Orders
where order_no = @orderid
end
else
begin
select @paid = credit_amount
from Orders
where order_no = @orderid
end

declare @diff_in_points int
set @diff_in_points = @total_amount - @paid

if(@diff_in_points<0)
begin
set @diff_in_points = 0
end

else if(@diff_in_points>@price)
begin
set @diff_in_points = @price
end

declare @giftcard_code varchar(10)
select @giftcard_code = Gift_Card_code_used
from Orders
where order_no = @orderid

declare @customer_name varchar(20)
select @customer_name = customer_name
from Orders
where order_no = @orderid

if (@giftcard_code is not null)
begin

declare @expiry_date datetime
select @expiry_date = expiry_date
from Giftcard
where code = @giftcard_code

if (@expiry_date>CURRENT_TIMESTAMP)
begin

update Admin_Customer_Giftcard
set remaining_points = remaining_points + @diff_in_points
where code = @giftcard_code and customer_name = @customer_name

update Customer
set points = points + @diff_in_points
where username = @customer_name

end

end

update Orders
set total_amount = total_amount - @price
where order_no = @orderid

update Product
set customer_username = null , customer_order_id = null ,rate = null, available = 1
where serial_no = @serialno and customer_order_id = @orderid

GO
CREATE PROC ShowproductsIbought
        @customername varchar(20)
AS
BEGIN  
        SELECT *
        FROM Product
        WHERE customer_USERname= @customername  
END
GO
CREATE PROC rate
        @serialno int, 
        @rate int , 
        @customername varchar(20)
AS
BEGIN  
       UPDATE product 
       SET rate = @rate
       where serial_no = @serialno AND customer_username = @customername
END
GO
CREATE OR ALTER PROC SpecifyAmount
@customername varchar(20), 
@orderID int, 
@cash decimal(10,2), 
@credit decimal(10,2)
AS 
DECLARE @total decimal(10,2)
BEGIN 
SELECT @total=total_amount
FROM Orders
WHERE order_no=@orderID

IF (@cash=0 AND @CASH IS NULL) 
UPDATE Orders
SET payment_type='CREDIT'
WHERE order_no=@orderID
ELSE 
IF(@credit=0 OR @CREDIT IS NULL)
UPDATE Orders
SET payment_type='CASH'
WHERE order_no=@orderID
ELSE
UPDATE Orders
SET payment_type='PARTIALLY ',cash_amount=@cash,credit_amount=@credit
WHERE order_no=@orderID
IF @total>@cash and @cash <> 0
UPDATE Customer
SET points=points-(@total-@cash)
WHERE username=@customername
IF @total>@credit and @credit <> 0
UPDATE Customer
SET points=points-(@total-@credit)
WHERE username=@customername

END
GO
CREATE PROC AddCreditCard
        @creditcardnumber varchar(20), 
        @expirydate date , 
        @cvv varchar(4), 
        @customername varchar(20) 

AS 
BEGIN
       INSERT INTO Credit_Card VALUES(​@creditcardnumber​,@expirydate, @cvv)
	  
       INSERT INTO Customer_CreditCard VALUES(​@customername,@creditcardnumber)
END
GO
CREATE PROC ChooseCreditCard
        @creditcard varchar(20),
        @orderid int

AS
BEGIN
       UPDATE Orders​ 
       SET creditCard_number = @creditcard
       WHERE order_no = @orderid       
END
GO
CREATE PROC vewDeliveryTypes

AS 
BEGIN
SELECT DISTINCT TYPE 
        FROM Delivery
END
GO
CREATE PROC specifydeliverytype
@orderID int, 
@deliveryID int
AS
DECLARE @days INT
BEGIN
SELECT @days=time_duration
FROM Delivery
WHERE id=@deliveryID 

UPDATE Orders 
SET delivery_id=@deliveryID,remaining_days=@days
WHERE order_no=@orderID

END
GO
create proc trackRemainingDays
@orderid int,
@customername varchar(20),
@days int OUTPUT
AS
BEGIN
update Orders
set remaining_days = DATEDIFF(day, CURRENT_TIMESTAMP, time_limit)
where customer_name=@customername AND order_no=@orderid

select @days=remaining_days
from Orders
where customer_name=@customername AND order_no=@orderid
END
go
create  or alter proc recommend
@customername varchar(20)
AS
select *
from Product
where serial_no in
(
select serial_no
from Product
where serial_no in
(
select top 3 p.serial_no
from Product p inner join Wishlist_Products w
on p.serial_no=w.serial_no
where p.category in 
(
select top 3 category
from product p
inner join CustomerAddstoCartProduct c on c.serial_no=p.serial_no
where c.customer_name=@customername
group by p.category
order by count(serial_no) DESC
)

group by p.serial_no
order by count(*) desc
)

union

select serial_no 
from Product
where serial_no in(
select top 3 serial_no 
from Wishlist_Products
where username in(
select top 3 c2.customer_name
from CustomerAddstoCartProduct c1 inner join CustomerAddstoCartProduct c2
on c1.serial_no=c2.serial_no
where c1.customer_name=@customername and c2.customer_name<>@customername
group by c2.customer_name
order by count(c2.serial_no) desc
)
group by serial_no
order by count(*) desc
)
)
go

go
CREATE PROC postProduct
        @vendorUsername varchar(20), 
        @product_name varchar(20) ,
        @category varchar(20), 
        @product_description text , 
        @price decimal(10,2), 
        @color varchar(20)

AS 
BEGIN
        INSERT INTO Product(product_name,category,product_description,price,color,vendor_username)
		VALUES(@product_name,@category,@product_description,@price,@color,@vendorUsername)

END

GO

CREATE PROC vendorviewProducts
        @vendorname varchar(20)
AS
BEGIN
        SELECT *
        FROM Product
        WHERE vendor_username = @vendorname
 
END

GO
CREATE PROC EditProduct
        @vendorname varchar(20), 
        @serialnumber int, 
        @product_name varchar(20),
        @category varchar(20), 
        @product_description text , 
        @price decimal(10,2), 
        @color varchar(20)

AS 
BEGIN
        UPDATE product
        SET product_name = @product_name,
        category = @category,
       product_description=@product_description,
        ​price​ = @price,
        color = @color,
        vendor_username = @vendorname
        WHERE ​serial_no​ = @serialnumber
END
GO


CREATE PROC deleteProduct
        @vendorname varchar(20), 
        @serialnumber int
AS
BEGIN   
        DELETE FROM product
        WHERE serial_no= @serialnumber AND vendor_username = @vendorname      
END

GO
CREATE PROC viewQuestions
        @vendorname varchar(20)
AS
BEGIN   
       SELECT c.question 
       FROM Customer_Question_Product c
       INNER JOIN product p on p.serial_no = c.serial_no​
       WHERE p.vendor_username = @vendorname      
END

GO

CREATE PROC answerQuestions
        @vendorname varchar(20), 
        @serialno int, 
        @customername varchar(20), 
        @answer text

AS
BEGIN
        UPDATE Customer_Question_Product
        SET answer = @answer
        WHERE serial_no = @serialno AND  customer_name = @customername
END
GO

CREATE PROC addOffer
        @offeramount int, 
        @expiry_date datetime

AS 
BEGIN
        INSERT INTO offer(offer_amount,expiry_date)
        VALUES(@offeramount,@expiry_date )
END
GO
CREATE PROC  checkOfferonProduct
@serial int,
@activeoffer BIT OUTPUT
AS
BEGIN


IF(EXISTS (SELECT * FROM OfferOnProduct WHERE serial_no=@serial))
SET @activeoffer = '1'
ELSE
SET @activeoffer= '0'
END

GO
CREATE PROC checkandremoveExpiredoffer
        @offerid int 

AS 
BEGIN
        DELETE FROM offer
        WHERE offer_id = @offerid AND CURRENT_TIMESTAMP > expiry_date
END


GO

CREATE PROC applyOffer
        @vendorname varchar(20), 
        @offerid int, 
        @serial int 

AS
BEGIN
  DECLARE @amount INT 
  SELECT @amount=offer_amount
  FROM offer
  WHERE offer_id = @offerid

  UPDATE product 
  SET final_price=price-@amount
  WHERE serial_no=@serial
  
  INSERT INTO offersOnProduct VALUES (​@offerid, @serial) 
END

GO
CREATE PROC activateVendors
        @admin_username varchar(20),
        @vendor_username varchar(20)

AS 
BEGIN
        UPDATE Vendor
        SET activated = 1,
            admin_username = @admin_username
        WHERE username = @vendor_username 
END
GO
CREATE PROC inviteDeliveryPerson
       @delivery_username varchar(20), 
        @delivery_email varchar(50)

AS
BEGIN

        INSERT INTO Users(username,email) VALUES (@delivery_username,@delivery_email)


        INSERT INTO Delivery_Person VALUES (@delivery_username,1)
END

GO
CREATE PROC reviewOrders

AS 
BEGIN
        SELECT *
        FROM orders
END 
GO
CREATE PROC updateOrderStatusInProcess
        @order_no int

AS 
BEGIN
        UPDATE orders
        SET order_status = 'in process'
        WHERE order_no = @order_no
END 
GO

CREATE PROC addDelivery
        @delivery_type varchar(20),
        @time_duration int,
        @fees decimal(5,3),
        @admin_username varchar(20)

AS 
BEGIN
        INSERT INTO Delivery
        VALUES(@delivery_type,@time_duration,@fees,@admin_username)
END 
GO

CREATE PROC assignOrdertoDelivery
       @delivery_username varchar(20),
       @order_no int,
       @admin_username varchar(20)

AS
BEGIN
        INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username)
        VALUES(@delivery_username ,@order_no,@admin_username)
END 
GO

CREATE PROC createTodaysDeal
       @deal_amount int,
       @admin_username varchar(20),
       @expiry_date datetime

AS 
BEGIN
        INSERT INTO Todays_Deals
        VALUES(@deal_amount, @expiry_date, @admin_username​)
        
END 

GO
CREATE PROC checkTodaysDealOnProduct
@serial_no INT,
@activeDeal BIT OUTPUT
AS
BEGIN


IF(EXISTS (SELECT * FROM Todays_Deals_Product WHERE serial_no=@serial_no))
SET @activeDeal='1'
ELSE
SET @activeDeal= '0'

END
GO
CREATE PROC addTodaysDealOnProduct
       @deal_id int, 
       @serial_no int

AS 
BEGIN
  INSERT INTO Todays_Deals_Product VALUES (@deal_id,@serial_no)

  DECLARE @amount INT 
  SELECT @amount=deal_amount
  FROM Todays_Deals
  WHERE deal_id = @deal_id

  UPDATE product 
  SET final_price=price-@amount
  WHERE serial_no=@serial_no
  END
  GO
CREATE PROC removeExpiredDeal
        @deal_iD int

AS 
BEGIN
        DELETE FROM Todays_Deals
        WHERE deal_id = @deal_iD AND CURRENT_TIMESTAMP > expiry_date
		DELETE FROM Todays_Deals_Product
		WHERE deal_id = @deal_iD
        
END

GO
CREATE PROC createGiftCard
       @code varchar(10),
       @expiry_date datetime,
       @amount int,
       @admin_username varchar(20)

AS 
BEGIN
  INSERT INTO Giftcard
  VALUES (@code​, @expiry_date, @amount, @admin_username)
END
GO
CREATE PROC removeExpiredGiftCard
        @code varchar(10)

AS 
BEGIN
        DELETE FROM Giftcard
        WHERE code= @code AND CURRENT_TIMESTAMP > expiry_date
        
END
GO
CREATE PROC checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard BIT OUTPUT
AS
BEGIN


IF(EXISTS (SELECT * FROM Giftcard WHERE code=@code))
SET @activeGiftCard = '1'
ELSE
SET @activeGiftCard = '0'

END
GO
CREATE PROC giveGiftCardtoCustomer
@code varchar(10),
@customer_name varchar(20),
@admin_username varchar(20)
AS
DECLARE @custpoints SMALLINT
DECLARE @cardpoints SMALLINT
BEGIN 

SELECT @cardpoints=c.amount
FROM Giftcard c
WHERE c.code=@code

SELECT @custpoints=c.points
FROM Customer c
WHERE c.username=@customer_name

INSERT INTO Admin_Customer_Giftcard VALUES (@code,@customer_name,@admin_username,@custpoints+@cardpoints)
END
GO
CREATE PROC acceptAdminInvitation
 @delivery_username varchar(20)
AS
BEGIN 
INSERT INTO Delivery_Person(username,is_activated) VALUES (@delivery_username,1)
END 
GO 
CREATE PROC deliveryPersonUpdateInfo
@username varchar(20),
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


