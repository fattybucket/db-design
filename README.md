# What is SQL?
SQL stands for *Structured Query Language*. It doesn't store files that way but also we can manipulate the data in a table with the help of rows and columns.

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
Primary key is supposed to be use for unquie indentical purpose such as `Citizen identical numbers, Vehicle registration number` and stuff like that.

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

## Implementation
**Billing Database**
```
CREATE TABLE billing.plan_details(
plan_de_no serial,
price int,
billing_cycle varchar(20),
status varchar(10),
primary key(plan_de_no));

CREATE TABLE billing.plans(
plan_no serial,
plan_name varchar(30),
primary key(plan_no),
plan_details int,
foreign key (plan_details) references billing.plan_details(plan_de_no));

CREATE TABLE billing.clients(
clients_no serial,
first_name varchar(15),
last_name varchar(15),
address varchar(30),
city varchar(20),
state varchar(20),
country varchar(25),
primary key (clients_no));

CREATE TABLE billing.invoices(
invoice_no serial,
paid$ int,
unpaid$ int,
refund$ int,
credit_bal$ int,
signup_date date,
due_date date,
primary key(invoice_no));

CREATE TABLE billing.orders(
order_no serial,
order_id int,
invoice_no int,
plan_no int,
clients_no int,
foreign key(invoice_no) references billing.invoices(invoice_no),
foreign key(plan_no) references billing.plans(plan_no),
foreign key(clients_no) references billing.clients(clients_no));

insert into billing.plan_details(price,billing_cycle,status) values(6.89,'6 month','Active'), (5.99,'3 month','Active');

insert into billing.plans(plan_name,plan_details) values('Linux Basic',2), ('ASP.NET Basic',1);

insert into billing.clients(first_name,last_name,address,city,state,country) values('Bob','Orton','25 G','Los Vega','California','U.S'), ('Martain','Moole','37L','Los Angeles','California','U.S');

insert into billing.invoices(paid$,unpaid$,refund$,credit_bal$,signup_date,due_date) values(18.00,0.00,0.00,0.00,'2011-Aug-08','2012-Aug-09'), (20.82,0.00,0.00,30.00,'2012-May-02','2014-May-03');

insert into billing.orders(order_id,invoice_no,plan_no,clients_no) values(1188290,1,1,2), (7274821,2,2,1);

select plan_details.price, plan_details.billing_cycle,
plan_details.status, plans.plan_name, clients.first_name,
clients.last_name, clients.address, clients.state, clients.city,
invoices.paid$, invoices.credit_bal$, invoices.signup_date,
invoices.due_date, orders.order_id from billing.plan_details INNER JOIN billing.plans ON billing.plan_details.plan_de_no = billing.plans.plan_details INNER JOIN billing.orders ON billing.orders.plan_no = billing.plans.plan_no INNER JOIN billing.invoices ON billing.orders.invoice_no = billing.invoices.invoice_no INNER JOIN billing.clients ON billing.orders.clients_no = billing.clients.clients_no;

CREATE VIEW Balance (
SELECT plan_details.price, plan_details.billing_cycle,
plan_details.status, plans.plan_name, clients.first_name,
clients.last_name, clients.address, clients.state, clients.city,
invoices.paid$, invoices.credit_bal$, invoices.signup_date,
invoices.due_date, orders.order_id from billing.plan_details INNER JOIN billing.plans ON billing.plan_details.plan_de_no = billing.plans.plan_details INNER JOIN billinbg.orders ON billing.orders.plan_no = billing.plans.plan_no INNER JOIN billing.invoices ON billing.orders.invoice_no = billing.invoices.invoice_no INNER JOIN billing.clients ON billing.orders.clients_no = billing.clients.clients_no
);
```
**Bank Database**
```
CREATE TABLE clients( 
client_id bigserial,
firstname varchar(20),
lastname varchar(20),
address varchar(30),
city varchar(20),
country varchar(30),
phone_no bigint,
email varchar(25),
PRIMARY KEY(client_id)
);

CREATE TABLE accounts(
account_id bigserial,
type varchar(10),
balance money,
acc_no integer,
credit_balance money,
status acct_status,
PRIMARY KEY(account_id)
);

CREATE TABLE acctinfo(
client_acct_id bigserial,
client_id bigint,
account_id bigint,
foreign key(client_id) references clients(client_id),
foreign key(account_id) references accounts(account_id)
);


insert into clients (firstname,lastname,address,city,country,phone_no,email) VALUES('john', 'uth', '19C', 'san andreas', 'usa', 5552221, 'john@name.com'), ('james', 'karlson', 'south dakota', 'usa', 8822119, 'james@name.com');
insert into accounts (type,balance,acc_no,credit_balance,status) VALUES('current', 20.00, 2222881, 0.00, 'inactive'), ('current', 500000.00, 8887771, 0.00, 'active');

insert into acctinfo (client_id,account_id) VALUES(1,2), (2,1);


Select Clients.Name, Clients.Address, Clients.Country, Accounts.type, accounts.balance, accounts.acc_no, accounts.status FROM clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id;


CREATE VIEW bank AS
select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status FROM clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id;

/*

Please, ignore that stuff ;-)

\copy accounts (type,balance,acc_no,credit_balance,status) TO '/home/fadi/accounts.txt';
\copy clients (name,lastname,address,city,country,phone_no,email) TO '/home/fadi/clients.txt';


SELECT row_to_json(lol) AS json FROM (select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status FROM clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id) lol;
*/
```