/*
Lab 1 report <Student_names and liu_id>
*/

/* All non code should be within SQL-comments like this */ 


/*
Drop all user created tables that have been created when solving the lab
*/

DROP TABLE IF EXISTS custom_table CASCADE;


/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql;
SOURCE company_data.sql;

/*
Question 1: selected all employees from the employee table:"
*/

select * from jbemployee;

/* Show the output for every question.
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+


*/ 

/*
Question 2: listing all department names in alphabetical order:"
*/

select name from jbdept order by name asc;

/*
Question 2: output
+------------------+
| name             |
+------------------+
| Bargain          |
| Book             |
| Candy            |
| Children's       |
| Children's       |
| Furniture        |
| Giftwrap         |
| Jewelry          |
| Junior Miss      |
| Junior's         |
| Linens           |
| Major Appliances |
| Men's            |
| Sportswear       |
| Stationary       |
| Toys             |
| Women's          |
| Women's          |
| Women's          |
+------------------+
*/


/*
Question 3. select all parts from jbparts that are of quantity 0:"
*/

select * from jbparts where qoh = 0;
/*
Question 3. output"
+----+-------------------+-------+--------+------+
| id | name              | color | weight | qoh  |
+----+-------------------+-------+--------+------+
| 11 | card reader       | gray  |    327 |    0 |
| 12 | card punch        | gray  |    427 |    0 |
| 13 | paper tape reader | black |    107 |    0 |
| 14 | paper tape punch  | black |    147 |    0 |
+----+-------------------+-------+--------+------+
4 rows in set (0.00 sec)
*/


/*
Question 4. list all employees with a salary between 9000 and 10000:"
*/

select * from jbemployee where salary >= 9000 AND salary<=10000;

/*
Question 4. output"
+-----+----------------+--------+---------+-----------+-----------+
| id  | name           | salary | manager | birthyear | startyear |
+-----+----------------+--------+---------+-----------+-----------+
|  13 | Edwards, Peter |   9000 |     199 |      1928 |      1958 |
|  32 | Smythe, Carol  |   9050 |     199 |      1929 |      1967 |
|  98 | Williams, Judy |   9000 |     199 |      1935 |      1969 |
| 129 | Thomas, Tom    |  10000 |     199 |      1941 |      1962 |
+-----+----------------+--------+---------+-----------+-----------+
4 rows in set (0.00 sec)

*/


/*
Question 5.list all employees and their age:
*/

select name, startyear - birthyear as age from jbemployee;

/*
Question 5.output:
+--------------------+------+
| name               | age  |
+--------------------+------+
| Ross, Stanley      |   18 |
| Ross, Stuart       |    1 |
| Edwards, Peter     |   30 |
| Thompson, Bob      |   40 |
| Smythe, Carol      |   38 |
| Hayes, Evelyn      |   32 |
| Evans, Michael     |   22 |
| Raveen, Lemont     |   24 |
| James, Mary        |   49 |
| Williams, Judy     |   34 |
| Thomas, Tom        |   21 |
| Jones, Tim         |   20 |
| Bullock, J.D.      |    0 |
| Collins, Joanne    |   21 |
| Brunet, Paul C.    |   21 |
| Schmidt, Herman    |   20 |
| Iwano, Masahiro    |   26 |
| Smith, Paul        |   21 |
| Onstad, Richard    |   19 |
| Zugnoni, Arthur A. |   21 |
| Choy, Wanda        |   23 |
| Wallace, Maggie J. |   19 |
| Bailey, Chas M.    |   19 |
| Bono, Sonny        |   24 |
| Schwarz, Jason B.  |   15 |
+--------------------+------+
25 rows in set (0.00 sec)
*/

/*
Question 6.select names where last name ends with “son” ::
*/

select name from jbemployee where name like '%son,%';

/*
Question 6.output
+---------------+
| name          |
+---------------+
| Thompson, Bob |
+---------------+
1 row in set (0.00 sec)
*/



/*
Question 7, select all items from a specific supplier with sub queries:
*/

select * from jbitem where supplier in (select id from jbsupplier where name='Fisher-Price');

/*
Question 7,output
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
3 rows in set (0.00 sec)
*/

/*
Question 8, same as 7 but without subqueries:
*/

select jbitem.* from jbitem,jbsupplier where jbitem.supplier=jbsupplier.id and jbsupplier.name='Fisher-Price';

/*
Question 8, output:
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
3 rows in set (0.00 sec)
*/

/*
Question 9, select cities where there are suppliers using subqueries:
*/

select * from jbcity where jbcity.id in (select city from jbsupplier);


/*
Question 9, output

+-----+----------------+-------+
| id  | name           | state |
+-----+----------------+-------+
|  10 | Amherst        | Mass  |
|  21 | Boston         | Mass  |
| 100 | New York       | NY    |
| 106 | White Plains   | Neb   |
| 118 | Hickville      | Okla  |
| 303 | Atlanta        | Ga    |
| 537 | Madison        | Wisc  |
| 609 | Paxton         | Ill   |
| 752 | Dallas         | Tex   |
| 802 | Denver         | Colo  |
| 841 | Salt Lake City | Utah  |
| 900 | Los Angeles    | Calif |
| 921 | San Diego      | Calif |
| 941 | San Francisco  | Calif |
| 981 | Seattle        | Wash  |
+-----+----------------+-------+
15 rows in set (0.01 sec)

*/

/*
Question 10, select name and color from jbparts where weight if parts are greater than the card readers using subqueries:

*/

select name,color from jbparts where weight >(select weight from jbparts where name ='card reader' );


/*
Question 10,output
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)

*/


/*
Question 11, same as above but without subquery

*/

select jbparts.name,jbparts.color from jbparts, jbparts as jbp where jbparts.weight >jbp.weight and jbp.name = 'card reader';

/*
Question 11, output
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.01 sec)
*/

/*
Question 12, select average weight for black parts:
*/
select color,avg(weight) from jbparts where color='black';
/*
Question 12, output
+-------+-------------+
| color | avg(weight) |
+-------+-------------+
| black |    347.2500 |
+-------+-------------+
1 row in set (0.00 sec)

*/


/*
Question 13, total weight of all parts thateach supplier in Massachusetts has delivered.
what we did: we joined the different tables to extract the columns that we wanted and subquery 
for the state Mass to calculate the result.
*/

select jbsupplier.name, SUM(jbsupply.quan*jbparts.weight) as tot
from jbsupplier left outer join jbsupply on jbsupplier.id = jbsupply.supplier
left outer join jbparts on jbsupply.part = jbparts.id 
where jbsupplier.city in (select id from jbcity where state = 'Mass') 
group by jbsupplier.name;

/*
Question 13,output

+--------------+---------+
| name         | tot     |
+--------------+---------+
| DEC          |    3120 |
| Fisher-Price | 1135000 |
+--------------+---------+
2 rows in set (0.00 sec)
*/


/*
Question 14, create new item table with prices lower than average
*/

create table ciitem( id integer, name text, dept integer, 
price integer, qoh integer, supplier integer, 
constraint ci_pk primary key(id), 
constraint ci_fk1 foreign key(supplier) references jbsupplier(id), 
constraint ci_fk2 foreign key(dept) references jbdept(id) );

insert into ciitem select * from jbitem where price < (select avg(price) from jbitem);
/*output
Query OK, 14 rows affected (0.00 sec)
Records: 14  Duplicates: 0  Warnings: 0*/

select * from ciitem;

/*
Question 14, output
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
14 rows in set (0.00 sec)
*/

/*
Question 15, create view with items with prices lower than average
*/

create view item_view as select * from ciitem;

select * from item_view;

/*
Question 15,output
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
14 rows in set (0.00 sec)

*/

/*
Question 16, A view is dynamic since it depends on the existence other tables 
to be able to view the certain content. A table is static since it does not 
change if you do not change the table directly. A view changes when the tables 
that it depends on changes.
*/

/*
Question 17, create view that has the total cost of each debit with i
mplicit inner joins
*/

create view debit_view as select jbsale.debit,sum(jbsale.quantity*jbitem.price) 
from jbitem,jbsale 
where jbsale.item=jbitem.id group by debit;

select * from debit_view;      

/*
Question 17, output
+--------+-----------------------------------+
| debit  | sum(jbsale.quantity*jbitem.price) |
+--------+-----------------------------------+
| 100581 |                              2050 |
| 100582 |                              1000 |
| 100586 |                             13446 |
| 100592 |                               650 |
| 100593 |                               430 |
| 100594 |                              3295 |
+--------+-----------------------------------+
6 rows in set (0.00 sec)
*/

/*
Question 18, same as 17 but with explicit joins
motivation: Since we know that jbsale has the attribute item which is a
foreign key pointing to jbitems primary key, we know that there should be a 
corresponding tuple in that table, which is why inner join was used. 
*/

create view debit_view2 as select jbsale.debit, 
sum(jbsale.quantity*jbitem.price) 
from jbitem inner join jbsale on jbitem.id = jbsale.item  
group by jbsale.debit;

select * from debit_view2;

/*
Question 18, output

+--------+-----------------------------------+
| debit  | sum(jbsale.quantity*jbitem.price) |
+--------+-----------------------------------+
| 100581 |                              2050 |
| 100582 |                              1000 |
| 100586 |                             13446 |
| 100592 |                               650 |
| 100593 |                               430 |
| 100594 |                              3295 |
+--------+-----------------------------------+
6 rows in set (0.00 sec)

*/

/*
Question 19a, Remove all suppliers in Los Angeles from the table jbsupplier
*/

/*delete from jbsupplier where city in (select id from jbcity where name='Los Angeles');

/* output
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign 
key constraint fails (`iliay038`.`ciitem`, CONSTRAINT `ci_fk1` FOREIGN KEY (`supplier`) 
REFERENCES `jbsupplier` (`id`))
*/

/*Then we drop our own table since it was conflicting*/
drop table ciitem;

/*Then we identified all relations connected and removed related item from jbsale:*/

delete from jbsale where item in (select jbitem.id from
jbitem inner join jbsupplier on jbitem.supplier = jbsupplier.id 
where jbsupplier.city in ( select id from jbcity where name = 'Los Angeles'));


/*Then we removed the items from jbitem: */

delete from jbitem where supplier in (select jbsupplier.id
from jbsupplier 
where jbsupplier.city in ( select id from jbcity where name='Los Angeles'));



/*Lastly we did the first query:*/

delete from jbsupplier where city in (select id from jbcity where name='Los Angeles');

select * from jbsupplier;

/*question 19a, output
+-----+--------------+------+
| id  | name         | city |
+-----+--------------+------+
|   5 | Amdahl       |  921 |
|  15 | White Stag   |  106 |
|  20 | Wormley      |  118 |
|  33 | Levi-Strauss |  941 |
|  42 | Whitman's    |  802 |
|  62 | Data General |  303 |
|  67 | Edger        |  841 |
|  89 | Fisher-Price |   21 |
| 122 | White Paper  |  981 |
| 125 | Playskool    |  752 |
| 213 | Cannon       |  303 |
| 241 | IBM          |  100 |
| 440 | Spooley      |  609 |
| 475 | DEC          |   10 |
| 999 | A E Neumann  |  537 |
+-----+--------------+------+
15 rows in set (0.00 sec)
*/

/*
Question 19b,
We combined tables using inner join due to the foreign key relations to each 
other. Thereafter we used a subquery to locate which suppliers where in LA.
We used the subquery to minimize the amount of tables joined. 
Thereafter we deleted the tuples related to the supplier.
*/

/*
Question 20, create view with suppliers that have sold items and not sold items
*/

create view jbsale_supply(supplier,item,quantity) as 
SELECT jbsupplier.name, jbitem.name, jbsale.quantity 
FROM jbsupplier inner join jbitem on 
jbitem.supplier = jbsupplier.id left join jbsale on jbsale.item = jbitem.id;

SELECT supplier, sum(quantity) AS sum FROM jbsale_supply group by supplier;

/*
Question 20,output
+--------------+------+
| supplier     | sum  |
+--------------+------+
| Cannon       |    6 |
| Fisher-Price | NULL |
| Levi-Strauss |    1 |
| Playskool    |    2 |
| White Stag   |    4 |
| Whitman's    |    2 |
+--------------+------+

*/


