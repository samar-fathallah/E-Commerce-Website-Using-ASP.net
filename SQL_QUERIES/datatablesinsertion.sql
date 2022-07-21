Create table Users(
username varchar(20) PRIMARY KEY,
password varchar(20),
first_name varchar(20),
last_name varchar(20),
email varchar(50)
)

Create table User_mobile_numbers(
mobile_number varchar(20),
username varchar(20)
PRIMARY KEY(mobile_number, username)
foreign key(username) references Users on delete cascade on update cascade
)

Create table User_Addresses(
address varchar(20),
username varchar(20)
PRIMARY KEY(address, username)
foreign key(username) references Users on delete cascade on update cascade
)


Create table Customer(
username varchar(20) PRIMARY KEY,
points int default 0
foreign key(username) references Users on delete cascade on update cascade
)


Create table Admins(
username varchar(20) PRIMARY KEY
foreign key(username) references Users on delete cascade on update cascade
)

Create table Vendor(
username varchar(20) PRIMARY KEY,
activated bit,
company_name varchar(20),
bank_acc_no varchar(20),
admin_username varchar(20),
foreign key(username) references Users on delete cascade on update cascade,
foreign key(admin_username) references Admins on delete no action on update no action
)


Create table Delivery_Person(
username varchar(20) PRIMARY KEY,
is_activated bit
foreign key(username) references Users on delete cascade on update cascade
)

Create table Credit_Card(
number varchar(20) PRIMARY KEY,
expiry_date datetime,
cvv_code varchar(4)
)

Create table Delivery(
id int PRIMARY KEY IDENTITY,
type varchar(20),
time_duration int,
fees decimal (5,3),
username varchar(20)
foreign key(username) references Admins on delete no action on update no action
)
Create table Giftcard(
code varchar(10) PRIMARY KEY,
expiry_date datetime,
amount int,
username varchar(20)
foreign key(username) references Admins on delete no action on update no action
)

Create table Orders(
order_no int PRIMARY KEY IDENTITY,
order_date datetime,
total_amount decimal (10,2),
cash_amount decimal (10,2),
credit_amount decimal (10,2),
payment_type varchar(20),
order_status varchar(20),
remaining_days int,
time_limit int,
Gift_Card_code_used varchar(10),
customer_name varchar(20),
delivery_id int,
creditCard_number varchar(20)
foreign key(customer_name) references Customer on delete no action on update no action,
foreign key(delivery_id) references Delivery on delete no action on update no action,
foreign key(creditCard_number) references Credit_Card on delete no action on update cascade,
foreign key(Gift_Card_code_used) references GiftCard on delete no action
)

Create table Product(
serial_no int PRIMARY KEY IDENTITY,
product_name varchar(20),
category varchar(20),
product_description text,
price decimal(10,2),
final_price decimal(10,2),
color varchar(20),
available bit,
rate int,
vendor_username varchar(20),
customer_username varchar(20) null,
customer_order_id int null,
foreign key(vendor_username) references Vendor on delete no action on update no action,
foreign key(customer_username) references Customer on delete no action on update no action,
foreign key(customer_order_id) references Orders on delete no action on update no action
)

Create table CustomerAddstoCartProduct(
serial_no int,
customer_name varchar(20)
PRIMARY KEY(serial_no, customer_name)
foreign key(serial_no) references Product on delete cascade on update cascade,
foreign key(customer_name) references Customer on delete no action on update no action
)

Create table Todays_Deals(
deal_id int PRIMARY KEY identity,
deal_amount int,
expiry_date datetime,
admin_username varchar(20)
foreign key(admin_username) references Admins on delete no action on update no action
)

Create table Todays_Deals_Product(
deal_id int,
serial_no int
PRIMARY KEY(deal_id, serial_no)
foreign key(deal_id) references Todays_Deals on delete cascade on update cascade,
foreign key(serial_no) references Product on delete cascade on update cascade
)


Create table offer(
offer_id int PRIMARY KEY identity,
offer_amount int,
expiry_date datetime
)

Create table offersOnProduct(
offer_id int,
serial_no int
PRIMARY KEY(offer_id, serial_no)
foreign key(offer_id) references Offer on delete cascade on update no action,
foreign key(serial_no) references Product on delete cascade on update no action
)

Create table Customer_Question_Product(
serial_no int,
customer_name varchar(20),
question varchar(50),
answer text
PRIMARY KEY(serial_no, customer_name)
foreign key(serial_no) references Product on delete cascade on update cascade,
foreign key(customer_name) references Customer on delete no action on update no action
)

Create table Wishlist(
username varchar(20),
name varchar(20)
PRIMARY KEY(username, name)
foreign key(username) references Customer on delete no action on update no action
)



Create table Wishlist_Product(
username varchar(20),
wish_name varchar(20),
serial_no int
PRIMARY KEY(username, wish_name, serial_no)
foreign key(username, wish_name) references Wishlist on delete cascade on update cascade,
foreign key(serial_no) references Product on delete cascade on update cascade
)

Create table Admin_Customer_Giftcard(
code varchar(10),
customer_name varchar(20),
admin_username varchar(20),
remaining_points int
PRIMARY KEY(code, customer_name, admin_username)
foreign key(code) references Giftcard on delete cascade on update cascade,
foreign key(customer_name) references Customer on delete no action on update no action,
foreign key(admin_username) references Admins on delete no action on update no action
)

Create table Admin_Delivery_Order(
delivery_username varchar(20),
order_no int,
admin_username varchar(20),
delivery_window int
PRIMARY KEY(delivery_username, order_no)
foreign key(delivery_username) references Delivery_Person on delete no action on update no action,
foreign key(order_no) references Orders on delete cascade on update cascade,
foreign key(admin_username) references Admins on delete no action on update no action
)

Create table Customer_CreditCard(
customer_name varchar(20),
cc_number varchar(20)
PRIMARY KEY(customer_name, cc_number)
foreign key(customer_name) references Customer on delete no action on update no action,
foreign key(cc_number) references Credit_Card on delete cascade on update cascade
)


insert into users (username,first_name,last_name,password,email) values ('hana.aly','hana','aly','pass1','hana.aly@guc.edu.eg')
insert into users (username,first_name,last_name,password,email) values ('ammar.yasser','ammar','yasser','pass4','ammar.yasser@guc.edu.eg')
insert into users (username,first_name,last_name,password,email) values ('nada.sharaf','nada','sharaf','pass7','nada.sharaf@guc.edu.eg')
insert into users (username,first_name,last_name,password,email) values ('hadeel.adel','hadeel','adel','pass13','hadeel.adel@guc.edu,eg')
insert into users (username,first_name,last_name,password,email) values ('mohamed.tamer','mohamed','tamer','pass16','mohamed.tamer@guc.edu.eg')



insert into User_Addresses (address,username) values('New Cairo', 'hana.aly')
insert into User_Addresses (address,username) values('Heliopolis', 'hana.aly')

insert into User_mobile_numbers (mobile_number,username) values ('01111111111', 'hana.aly')
insert into User_mobile_numbers (mobile_number,username) values ('1211555411', 'hana.aly')

insert into Admins (username) values ('hana.aly')
insert into Admins (username) values ('nada.sharaf')

insert into Customer(username,points) values ('ammar.yasser',15)

insert into Vendor (username,activated,company_name,bank_acc_no,admin_username) values ('hadeel.adel',1,'Dello','47449349234','hana.aly')

insert into Delivery_Person (is_activated,username) values (1, 'mohamed.tamer')

Set Identity_Insert Product on

insert into Product (serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
values (1, 'Bag', 'Fashion', 'backbag' , 100 ,100, 'yellow' ,1, 0, 'hadeel.adel')

insert into Product (serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
values (2, 'Blue pen' , 'stationary' ,'useful pen', 10, 10, 'Blue' ,1, 0 ,'hadeel.adel')

insert into Product (serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
values (3, 'Blue pen' ,'stationary', 'useful pen', 10, 10, 'Blue' ,0, 0 ,'hadeel.adel')

Set Identity_Insert Product off

insert into CustomerAddstoCartProduct (serial_no,customer_name) values (1,'ammar.yasser')

insert into Credit_Card (number,expiry_date,cvv_code) values( '4444-5555-6666-8888' ,'2028-10-19' ,'232')

insert into Delivery (type,time_duration,fees) values ('pick-up' ,7 ,10)
insert into Delivery (type,time_duration,fees) values ('regular', 14, 30)
insert into Delivery (type,time_duration,fees) values ('speedy' ,1 ,50)

Set Identity_Insert Todays_Deals on

insert into Todays_Deals(deal_id,deal_amount,admin_username,expiry_date) values (1, 30, 'hana.aly', '11/30/2019')
insert into Todays_Deals(deal_id,deal_amount,admin_username,expiry_date) values (2, 40, 'hana.aly', '11/18/2019')
insert into Todays_Deals(deal_id,deal_amount,admin_username,expiry_date) values (3, 50, 'hana.aly', '12/12/2019')


Set Identity_Insert Todays_Deals off

Set Identity_Insert offer on

insert into offer (offer_id,offer_amount,expiry_date) values (1 ,50, '11/30/2019')

Set Identity_Insert offer off

insert into Wishlist(username,name) values ('ammar.yasser','fashion')

insert into Wishlist_Product(username,wish_name,serial_no) values ('ammar.yasser','fashion',2)
insert into Wishlist_Product(username,wish_name,serial_no) values ('ammar.yasser','fashion',3)

INSERT INTO Customer_CreditCard (customer_name,cc_number) values ('ammar.yasser','4444-5555-6666-8888')
insert into Giftcard (code,expiry_date,amount) values('G101' ,'11/18/2019' ,100)