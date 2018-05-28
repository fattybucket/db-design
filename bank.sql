create table clients( 
client_id bigserial,
name varchar(20),
lastname varchar(20),
address varchar(30),
city varchar(20),
country varchar(30),
phone_no bigint,
email varchar(25),
PRIMARY KEY(client_id)
);

create table accounts(
account_id bigserial,
type varchar(10),
balance money,
acc_no integer,
credit_balance money,
status acct_status,
PRIMARY KEY(account_id)
);

create table acctinfo(
client_acct_id bigserial,
client_id bigint,
account_id bigint,
foreign key(client_id) references clients(client_id),
foreign key(account_id) references accounts(account_id)
);

-- fill the data in these tables:

\copy clients (name,lastname,address,city,country,phone_no,email) from '/Users/fadi/me.txt';
insert into accounts (type,balance,acc_no,credit_balance,status) values('current', 20.00, 2222881, 0.00, 'inactive'), ('current', 500000.00, 8887771, 0.00, 'active');

\copy acctinfo (client_id,account_id) from '/Users/fadi/acctinfo.txt';

-- join these tables:

select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status from clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id;

-- after joining, create view of this:

create view bank AS
select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status from clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id;

-- now copy these tables data in to the following file:

\copy accounts (type,balance,acc_no,credit_balance,status) TO '/Users/fadi/accounts.txt';
\copy clients (name,lastname,address,city,country,phone_no,email) TO '/Users/fadi/clients.txt';

-- convert the table into JSON format:

select row_to_json(lol) AS json from (select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status from clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id) lol;
