/*
Lab 2 report chrha376 iliay038

All non code should be within SQL-comments /* like this */ 


/*
Drop all user created tables that have been created when solving the lab
*/

DROP TABLE IF EXISTS custom_table CASCADE;


/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql;
SOURCE company_data.sql;

/*
Question 3, 

*/
create table jbmanager(
	id integer,
	bonus integer default 0,
	constraint pk_manager
		primary key (id), 	
	constraint fk_employee 
		foreign key (id) references jbemployee(id)
);

/*
We initialize the bonus value to 0, so that adding a bonus will be possible since its an integer(not NULL). Should someone want to calculate the average bonus salary it would not be possible with null as a initial value since that manager would not be included. However with 0 they would be.
*/
insert into jbmanager (select id,0 from jbemployee where id in (select manager from jbemployee));


alter table jbemployee drop foreign key fk_emp_mgr;
alter table jbemployee add constraint fk_emp_mgr foreign key (manager) references jbmanager(id)
on delete set null;


alter table jbdept drop foreign key fk_dept_mgr;
alter table jbemployee add constraint fk_dept_mgr foreign key (manager) references jbmanager(id)
on delete set null;

/*
Question 4
*/

update jbmanager
set bonus= bonus +10000
where id in (select manager from jbdept);



/*
Question 5
*/


create table jbcustomer(
	id integer,
	name char,
	address char,
	city integer,
	constraint pk_cust
		primary key(id),
	constraint fk_cust_city
		foreign key(city) references jbcity(id)
);

create table jbaccount(
	account_number integer,
	balance integer,
	owner integer,
	constraint pk_acc
		primary key(account_number),
	constraint fk_acc_cust
		foreign key(owner) references jbcustomer(id)


);

create table jbtransaction(
	transaction_number integer,
	sdate timestamp NOT NULL DEFAULT current_timestamp(),
	employee integer,
	account_number integer,
	constraint pk_trans
		primary key(transaction_number),
	constraint fk_trans_emp
		foreign key(employee) references jbemployee(id),
	constraint fk_trans_acc
		foreign key(account_number) references jbaccount(account_number)

);



alter table jbdebit drop foreign key fk_debit_employee;
alter table jbdebit drop column sdate;
alter table jbdebit drop column employee;
alter table jbdebit drop column account;
alter table jbdebit add constraint fk_debit_trans foreign key(id) references jbtransaction(transaction_number);



create table jbdeposit(
	deposit_number integer,
	amount integer,
	constraint pk_depo	
		primary key(deposit_number),
	constraint fk_depo_trans
		foreign key(deposit_number) references jbtransaction(transaction_number)

);

create table jbwithdrawal(
	withdrawal_number integer,
	amount integer,
	constraint pk_withd	
		primary key(withdrawal_number),
	constraint fk_withd_trans
		foreign key(withdrawal_number) references jbtransaction(transaction_number)

);


