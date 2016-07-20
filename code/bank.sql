CREATE TABLE clients( 
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

-- fill the data in these tables:

\copy clients (name,lastname,address,city,country,phone_no,email) FROM '/home/fadi/me.txt';
insert into accounts (type,balance,acc_no,credit_balance,status) VALUES('current', 20.00, 2222881, 0.00, 'inactive'), ('current', 500000.00, 8887771, 0.00, 'active');

\copy acctinfo (client_id,account_id) FROM '/home/fadi/acctinfo.txt';

-- Joined These Tables:

Select Clients.Name, Clients.Address, Clients.Country, Accounts.type, accounts.balance, accounts.acc_no, accounts.status FROM clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id;

-- after joining, will create view of this:

CREATE VIEW bank AS
select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status FROM clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id;

-- now copys these tables data in to the following file:

\copy accounts (type,balance,acc_no,credit_balance,status) TO '/home/fadi/accounts.txt';
\copy clients (name,lastname,address,city,country,phone_no,email) TO '/home/fadi/clients.txt';

-- converts the table into JSON format:

SELECT row_to_json(lol) AS json FROM (select clients.name, clients.address, clients.country, accounts.type, accounts.balance, accounts.acc_no, accounts.status FROM clients JOIN acctinfo ON clients.client_id = acctinfo.client_id JOIN accounts ON accounts.account_id = acctinfo.account_id) lol;
