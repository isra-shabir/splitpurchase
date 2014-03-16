##Payment Information
Note: You must create a new payment account before you can create group purchases : when you click the group purchase link before you create a payment account you will be brought to the new payment account page.

* **card number:** 4242424242424242

* **cvc:** any 3 digit number

* **expiration date:** month from current month onward

* **routing number:** 110000000

* **account number:** 000123456789

------------------------------------------------------------

####Author: Isabella Tromba

####heroku link: http://secret-crag-3887.herokuapp.com/members/sign_in

####Teammate Names: Isra Shabir, Kevin White, Isabella Tromba

------------------------------------------------------------

## Improvements from 3.2 Submission
### Overall Additions
+ Added Commenting feature that displays on group purchase and only group purchase creator or author of the comment can delete it

### Hacking
+ New error messages displayed for tokenization when searching for members who either are the creator of the group or have already been added
+ Payment is now manually inputed for each invoice and unallocated balance is displayed for group creator
+ Title is now "Split Purchases" and not "Rails Bootstrap"
+ Dollar sign has been added in front of the value input field so users will not be tempted to add the sign themselves and be met twith an error.
+ Invoice controller now makes sure that you cannot make a purchase with $0.00 value or nil value
+ All dollar amounts go to 2 decimal places -- 
  i.e.: `number_with_precision(@group_purchase.get_invoice_balance(current_member), :precision =>2)`
+ Balance is displayed when running locally
+ Users can see who else is on the invoice - in money they owe section they can click on the group purchase and see who else owes money and how much they owe
+ Cannot navigate to purchases when not logged in. Added `before_filter` in all relevant controllers.

### Robust Coding
+ Moved methods from controllers to models to adhere to skinny controller/fat model design. 
+ Removed the huge if/else block for showing page for logged-in/logged-out users
+ Cannot navigate to purchases when not logged in. Added `before_filter` in all relevant controllers.

### Design
+ Fixed data model multiplicities

### Testing
+ Created tests for all relevant model methods
