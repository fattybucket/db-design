/* There's a schema "billing" */

create table billing.plan_details(
plan_de_no serial,
price int,
billing_cycle varchar(20),
status varchar(10),
primary key(plan_de_no));

create table billing.plans(
plan_no serial,
plan_name varchar(30),
primary key(plan_no),
plan_details int,
foreign key (plan_details) references billing.plan_details(plan_de_no));

create table billing.clients(
clients_no serial,
first_name varchar(15),
last_name varchar(15),
address varchar(30),
city varchar(20),
state varchar(20),
country varchar(25),
primary key (clients_no));

create table billing.invoices(
invoice_no serial,
paid$ int,
unpaid$ int,
refund$ int,
credit_bal$ int,
signup_date date,
due_date date,
primary key(invoice_no));

create table billing.orders(
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

/* Below stuff is mine

create view Balance (
select plan_details.price, plan_details.billing_cycle,
plan_details.status, plans.plan_name, clients.first_name,
clients.last_name, clients.address, clients.state, clients.city,
invoices.paid$, invoices.credit_bal$, invoices.signup_date,
invoices.due_date, orders.order_id from billing.plan_details INNER JOIN billing.plans ON billing.plan_details.plan_de_no = billing.plans.plan_details INNER JOIN billinbg.orders ON billing.orders.plan_no = billing.plans.plan_no INNER JOIN billing.invoices ON billing.orders.invoice_no = billing.invoices.invoice_no INNER JOIN billing.clients ON billing.orders.clients_no = billing.clients.clients_no
);
*/
