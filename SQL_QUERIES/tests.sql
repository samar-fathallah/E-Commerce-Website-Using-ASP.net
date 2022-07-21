exec customerRegister 'ahmed.ashraf', 'ahmed','ashraf',
'pass123','ahmed@yahoo.com'
exec vendorRegister
'eslam.mahmod','eslam ','mahmod', 'pass1234',
'hopa@gmail.com' , 'Market', '132132513'
DECLARE @success INT,@type INT
exec userLogiN 'eslam.mahmoud','pass123',
@success OUTPUT,@type output
PRINT @success 
PRINT @type
DECLARE @success INT,@type INT
exec userLogiN 'eslam.mahmoud','pass1234',
@success OUTPUT,@type output
PRINT @success 
PRINT @type
EXEC addMobile '01111211122','ahmed.ashraf'
exec addMobile  '0124262652','ahmed.ashraf'EXEC addAddress 'nasr city','ahmed.ashraf' exec showProductsEXEC ShowProductsbyPriceEXEC searchbyname 'BLUE PEN'EXEC AddQuestion 1,'ahmed.ashraf','size?'EXEC addToCart 'ahmed.ashraf' , 1EXEC addToCart 'ahmed.ashraf' , 2EXEC removefromCart 'ahmed.ashraf' , 2EXEC createWishlist 'ahmed.ashraf','fashion'EXEC AddtoWishlist 'ahmed.ashraf','fashion',1EXEC AddtoWishlist 'ahmed.ashraf','fashion',2EXEC removefromWishlist 'ahmed.ashraf','fashion',1EXEC showWishlistProduct 'ahmed.ashraf','fashion'EXEC viewMyCart 'AHMED.ASHRAF'EXEC makeOrder 'AHMED.ASHRAF'declare @sum int EXEC calculatepriceOrder 'AHMED.ASHRAF' ,@SUM outputprint @sumexec productsinorder 'ammar.yasser' ,1EXEC emptyCart 'ammar.yasser'EXEC ShowproductsIbought 'ammar.yasser'EXEC RATE 2,3,'AHMED.ASHRAF'EXEC SpecifyAmount 'ahmed.ashraf',19,null,10EXEC SpecifyAmount 'ahmed.ashraf',20,5,NULLEXEC AddCreditCard '4444-5555-6666-8888','10/19/2028','232','AMMAR.YASSER'