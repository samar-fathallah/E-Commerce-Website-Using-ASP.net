﻿exec customerRegister 'ahmed.ashraf', 'ahmed','ashraf',
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
exec addMobile  '0124262652','ahmed.ashraf'