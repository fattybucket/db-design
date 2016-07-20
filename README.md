# What is SQL?
SQL stands for *Structured Query Language*. It's not just the way of stores files but also we can manipulate the data in a table with the help of rows and columns.

It's just about the way how are you **_Designing a Database_** is it normalize or not if no then you should at least draw it on the paper where you could see the `Error`

The Database we are going to designe is based on ***Billing Manager and Bank System***

Before we go ahead we need to learn the rules of its first and then we'll make a <a href="#recipe">recipe</a> :blush:

## Database normalization
+ First normal form
  ###Every row must be uniquely identified.
  ####No other column should contain same type of information.
  #####Every column cell should contain one value.
  
+ Second normal form
##### No other rows should have same values.

* By the way third normal form is optional so it's not a necessary we can make a good Design by the following those normalization process above :wink:

### What is a primary key?
Primary key is supposed to use for unquie indentical purpose such as `Citizen identical numbers, Vehicle registration number` and stuff like that.

#### What is a foreign key?
Foreign key is that we use for referential purpose. For example we have created a test table with Primary key and Foreign key is supposed to be define in another table. It should be reference with that test table.

<h2 id="recipe">Recipe</h2>
<pre>
<h4>Billing Database</h4>
                          +-------------------+
                          |   plan_details    |
                          +-------------------+
+----------------+        |                   |
|     plans      |      +--> + pland_id(P.K)  |      +------------------+
+----------------+      | |  | price          |      |     clients      |
|                |      | |  | billing_cy     |      +------------------+
| + plan_id(P.K) +---+  | |  + status         |      |                  |
| | plan_name    |   |  | |                   |      | + client_id(P.K) +------+
| + plan_de(F.K) |---+--+ |                   |      | | first_name     |      |
|                |   |    |                   |      | | last_name      |      |
|                |   |    +-------------------+      | | address        |      |
|                |   |                               | | city           |      |
|                |   |                               | | state          |      |
+----------------+   |                               | + country        |      |
                     |       +-------------------+   |                  |      |
                     |       |       orders      |   +------------------+      |
                     |       +-------------------+     +--------------------+  |
                     |       |                   |     |     invoices       |  |
                     |       |  + order_id(P.K)  |     +--------------------+  |
                     |       |  | order_no       |     |                    |  |
                     |       |  | invoice_id(F.K)+-----> + invoice_id( P.K) |  |
                     +--------> | plan_id(F.K)   |     | | paid             |  |
                             |  + client_id(F.K)<----+ | | unpaid           |  |
                             |                   |   | | | refund           |  |
                             |                   |   | | | credit_bal       |  |
                             |                   |   | | | signup_date      |  |
                             +-------------------+   | | + due_date         |  |
                                                     | |                    |  |
                                                     | +--------------------+  |
                                                     |                         |
                                                     |                         |
                                                     |                         |
                                                     |                         |
                                                     +-------------------------+
<h5>Bank Database</h5>						     
+-----------------+
|   clients       |      +------------------+
+-+---------------+      |   acctinfo       |
| | client_id(P.K)+--+   +------------------+                +-------------------+
| | name          |  |   | |acctinfo_id(P.K)|                |    accounts       |
| | lastname      |  +---+->client_id(F.K)  |                +-------------------+
| | address       |      | + account_id(F.K)<------------------> account_id      |
| | city          |      |                  |                | | type            |
| | country       |      |                  |                | | balance         |
| | phone_no      |      |                  |                | | acct_no         |
| + email         |      +------------------+                | | credit_balance  |
|                 |                                          | + status          |
+-----------------+                                          |                   |
                                                             |                   |
                                                             |                   |
                                                             +-------------------+
</pre>

> PS: it's not a *big deal* everybody can be smirk!
> I hope you guys enjoy this. **HAVE FUN** :smiley: