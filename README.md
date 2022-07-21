# E-commerce-website using ASP.net
An E-commerce platform, where customers can choose a product or service of their choice from any vendor anywhere in the world without moving away from their workplace or home. They can also track their delivery status and know when the goods are being sent to them. They can also choose the convenient method of payment.


The prevalence of E-Commerce continues to grow and shows no signs of slowing down. People prefer
online shopping as it enables them to get all the items they need from the comfort of their homes.
Through an E-commerce platform, customers can choose a product or service of their choice from any
vendor anywhere in the world without moving away from their workplace or home. They can also track
their delivery status and know when the goods are being sent to them. They can also choose the convenient
method of payment.
E-Commerce provides new channels for vendors to reach more customers. An online presence allows vendors
to provide more information about the products they are selling. Through E-commerce, sellers can
post different offers to their products to increase sales.
The aim of the project is to implement an E-commerce website that provides these features to merchandisers
and customers.
2 Systems Requirements
This section describes the different requirements that the platform has.
Users
Different types of users can use the websites. Users are either customers, vendors, delivery personnels or
admins.
Any user can view, browse and search all the available products sold through the website. Any user should
have a name (First and last name), a unique username, password and an E-mail. The user can also have
mobile number(s) and address(es).
A customer has to sign up to be able to use the website and make orders. The account is automatically
activated.
Similarly, a vendor has to sign up to the system.Unlike a customer, the account of a vendor is not
automatically activated. Only an admin can activate a vendor. The system keeps track of which admin
activates the vendor.
Likewise, a delivery person does not sign up to the system. However, in their case, they get invited by
an admin to join the system. The admin assigns them a username. They are invited through their email.
The system keeps track of which admin invited the delivery person. Once the delivery person accepts the
invitation, their account is activated and they can choose their password and supply the other details.

Products and Vendors
Products are uniquely identified by a serial number. Each product has a name and a category. A product
is provided by one supplier. Each product should include a description, price, availability (whether the
product is available to the customers or not), rate (calculated as average of ratings the product received),
image, color.
A vendor can post their products once their registration is approved.Each vendor should also have a
company name, bank account number. They can post any number of products. They can also delete/edit
any of their products.
The customer can rate any product (given that they bought it before). In addition, they can post questions
about certain product. Questions can only be answered by the supplier of the product.
Payment Methods
Customers can pay in cash or using a credit card. Payment can also be fully/partially done using the
points of the customer. A credit card has a number, an expiry date and a CVC code. A credit card could
be used by multiple customers.
Points are added to the customer through different promotions as discussed later. Every point is equivalent
to 1 EGP.
Cart and Wish Lists
Every customer has their own cart. Every time a customer is interested to buy a product, they add it
to the cart. The customer can add/remove any number of products to/from their cart. In addition, the
entire cart can be emptied by one click instead of removing items one by one.
Every customer can create their own wish-list(s). A wish list has a name. It contains items that the user
is interested in and wishes to buy in the future. One user will never have two wish lists with the same
name. For example: user1 can have two wish-lists named electronics and food respectively. Whereas user2
can have only one wish-list named food. Similar to the cart, the customer can add/remove any products
to/from any of his wish-lists.
Order
Once the customer orders the items in the cart, the cart is emptied. A new order is created for the items.
The order has a unique number. The user has to choose a payment method for the order. Each order has
a status (not processed, in process, out for delivery, delivered). Admin can review all the orders made
through their website. In addition, the status of the order is updated by an admin.
An order could be cancelled as long as its status is “not processed” or “in process”. The payment is
automatically reversed in this case if it was done through credit card/ points.
The customer can also check the items once they are delivered and choose to return some/all of the items.
In this case, the price of the returned items is reversed using the same payment method (points/credit
card). In case of cash payment, the customer simply pays the items he/she chooses to keep.
Delivery
The website provides several types of delivery. Each delivery type has a specific time duration and fees.
Only admins can add a new delivery type and specify its time duration and fees.
On making an order, the customer has to specify the chosen delivery type.
For example, the basic delivery types available in the system for the customer to choose from are:
• The customer can pick-up the order thyself within a week
• The customer can choose a regular delivery which takes maximum 2 weeks to deliver,
• The customer can choose a speedy delivery which delivers in 24 hours.
Each type has its own fees
The customer should be able to track the delivery status (remaining days to deliver the order) of any
order.
A delivery personnel gets assigned to orders. Every order they get has its own time limit before which it
should be delivered. The delivery personnel has to make sure the delivery occurs within the allowed time
frame. They should also provide an estimated delivery window for each customers order (for example
today between 12 and 3 or tomorrow before 12). They are also responsible for updating the status of an
order as delivered once the delivery is done.
Recommendations
Each time the customer logs in, the website suggests products that they might like based on what the
customer has bought/added to their cart before.
Promotions
Moreover, Our E-commerce website has the privilege of offering promotions to its customers. Each promotion
has a unique number, an expiry date and amount of discount. The website provides 3 types of
promotions: Offers, Today’s Deals, and Gift Cards. Offers (discounts) can be added by vendors only. An
admin can add an offer to any of their products. However, at a time at most one offer is active for a
product. On the other hand, Today’s Deals and Gift cards are posted by the admins. Today’s Deals,
similar to offers, provide a discount on some products. Similarly a product can not have more than one
active deal at a time. The system keeps track of the admins that generated a “today’s deal”
Gift Cards are codes that are generated by the admins for special customers. A gift card is basically a
number of points added to the customers balance. These points, however, have an expiry date, A customer
can not have more than one gift card at a time. However the same gift card can be issued to more than
one customer at a time by more than one admin. Therefore we need to keep track of which admin issued
which gift card to which customer for safety reasons.
