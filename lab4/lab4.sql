

/*Drop existing tables and procedures */
SET FOREIGN_KEY_CHECKS = 0;
drop table airport;
drop table year;
drop table weekday;
drop table route;
drop table schedual_weekly;
drop table flight;
drop table reservation;
drop table reservation_list;
drop table contact;
drop table booking;
drop table passenger;

SET FOREIGN_KEY_CHECKS = 1;



/*
Creating relevant tables and foreign keys
*/

create table airport(
 airportcode VARCHAR(3),
 airportname VARCHAR(30),
 country VARCHAR(30),
	
 constraint pk_airport_code
	primary key(airportcode)

);


create table year(
 year integer,
 profitfactor double,

 constraint pk_year_year
	primary key(year)

);

create table weekday(
 day VARCHAR(10),
 wekdayfactor double,
 	
 constraint pk_weekday_day
	primary key(day)	
);

create table route(
 id integer,
 routeprice double,
 arrival varchar(3),
 departure varchar(3),
 
 constraint pk_route_id
    primary key(id),
 constraint fk_route_arrival
	foreign key(arrival) references airport(airportcode),
 constraint fk_route_departure
	foreign key(departure) references airport(airportcode)
);

create table schedual_weekly(
 id integer,
 year integer,
 day varchar(30),
 departure_time time,
 route integer,

 constraint pk_sch_week
	primary key (id),
 
 constraint fk_sch_year
	foreign key (year) references year(year),
 
 constraint fk_sch_day
	foreign key (day) references weekday(day),

 constraint fk_sch_route
	foreign key (route) references route(id)
);


create table flight(
 flightnumber integer,
 week integer,
 time integer,

 constraint pk_flight_num
	primary key(flightnumber),
 constraint fk_flight_time
	foreign key(time) references schedual_weekly(id)

);


create table reservation(
 reservationnumber integer,
 flight integer,
 
 constraint pk_reser_num
	primary key(reservationnumber),
 constraint fk_reser_flight
	foreign key(flight) references flight(flightnumber)
);


create table passenger(
 passportnumber integer,
 name varchar(30),
 
 constraint pk_passe_pass
	primary key(passportnumber)
);


create table reservation_list(
 passportnumber integer,
 reservation integer,
 
 constraint fk_res_pass
	foreign key(passportnumber) references passenger(passportnumber),
 constraint fk_reslist_res
	foreign key(reservation) references reservation(reservationnumber)
);

create table contact(
 passportnumber integer,
 phonenumber bigint,
 emailadress varchar(30),
 
 constraint pk_con_pass
	primary key(passportnumber),
 constraint fk_con_pass
	foreign key(passportnumber) references passenger(passportnumber)
);

create table booking(
 reservationnumber integer,
 cardnumber bigint,
 contact integer,

 constraint pk_book_num
	primary key(reservationnumber),
 constraint fk_book_num
	foreign key(reservationnumber) references reservation(reservationnumber),
 constraint fk_book_con
	foreign key(contact) references contact(passportnumber)

);


