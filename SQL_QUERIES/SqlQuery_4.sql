CREATE PROC userLogiN
@username varchar(20), 
@password varchar(20),
@success BIT OUTPUT,
@TYPE BIT OUTPUT 
AS 
BEGIN 
IF EXISTS (SELECT * FROM Users WHERE username=@username)
BEGIN
SET @success='1'
IF EXISTS (SELECT * FROM Customer WHERE username=@username) AND @success='1'
SET @TYPE='0'
IF EXISTS (SELECT * FROM Vendor WHERE username=@username)AND @success='1'
SET @TYPE='1'
IF EXISTS (SELECT * FROM Admins WHERE username=@username)AND @success='1'
SET @TYPE='2'
IF EXISTS (SELECT * FROM Delivery WHERE username=@username)AND @success='1'
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
INSERT INTO users(username, first_name, last_name, password, email,company_name,bank_acc_no) VALUES(@username, @first_name, @last_name, @password, @email, @company_name,@bank_acc_no)
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
     INSERT INTO Customer_Question_Product 
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
        WHERE serial_no= @serial AND customer_name = @customername AND wish_name = @wishlistname     
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
        WHERE c.username = @customer
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
        WHERE c.username = @customername
END

GO
CREATE PROC productsinorder
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
        where customer_order_id= @orderID

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
GO
CREATE PROC cancelOrder
        @orderid int
AS
BEGIN  
        DELETE FROM orders
        where order_no = @orderid AND (order_status = 'not processed' OR order_status = 'in process')
END

GO
CREATE PROC ShowproductsIbought
        @customername varchar(20)
AS
BEGIN  
        SELECT *
        FROM Product
        WHERE customer_name= @customername  
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
CREATE PROC SpecifyAmount
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

IF (@cash=0) 
UPDATE Orders
SET payment_type='CREDIT'
WHERE order_no=@orderID
ELSE 
IF(@credit=0)
UPDATE Orders
SET payment_type='CASH'
WHERE order_no=@orderID
ELSE 
UPDATE Orders
SET payment_type='PARIALLY CREDIT CARD',cash_amount=@cash,credit_amount=@credit
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
@orderID int, @deliveryID int
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

create proc firstRequire
@customername varchar(20)
as
begin
select top 3 prod.serial_no 
from product prod inner join Wishlist_Product wp on prod.serial_no=wp.serial_no 
where prod.category 
in(select top 3 pr.category  
from CustomerAddstoCartProduct cadd inner join Product pr  on cadd.serial_no=pr.serial_no
where cadd.customer_name=@customername
group by category 
order by count(*) desc
)
group by prod.serial_no
order by count(*) desc;
end;


go;

create proc secondRequire
@customername varchar(20)
as
begin

select serial_no 
from Wishlist_Product 
where username in(
select top 3 cart2.username from CustomerAddstoCartProduct cart1,CustomerAddstoCartProduct cart2
where cart1.serial_no=cart2.serial_no
and
cart1.customer_name<> cart2.customer_name
and
cart1.customer_name=@customername
group by cart2.customer_name
order by count(*) desc
)

end

go;
create proc recommend
@customername varchar(20)
as
begin
declare @tmpTable TABLE ( col INT)
insert @tmpTable exec firstRequire @customename

declare @tmpTable2 TABLE ( col INT)
insert @tmpTable2 exec secondRequire @customename

select * from product where serial_no in (select * from @tmpTable union select * from @tmpTable2)
end
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
        product_description = @product _description,
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
DECLARE  @activeoffer BIT
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
        WHERE offer_id = @offerid AND [CURRENT_TIMESTAMP] > expiry_date
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


        INSERT INTO Delivery_Person VALUES (@delivery_username,0)
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
  SELECT @amount=amount
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
        WHERE deal_id = @deal_iD AND [CURRENT_TIMESTAMP] > expiry_date
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
        WHERE code= @code AND [CURRENT_TIMESTAMP] > expiry_date
        
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
