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





