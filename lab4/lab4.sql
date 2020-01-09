/*Drop existing tables and procedures */
SET FOREIGN_KEY_CHECKS = 0;
drop table if exists airport;
drop table if exists year;
drop table if exists weekday;
drop table if exists route;
drop table if exists schedual_weekly;
drop table if exists flight;
drop table if exists reservation;
drop table if exists reservation_list;
drop table if exists contact;
drop table if exists booking;
drop table if exists passenger;

SET FOREIGN_KEY_CHECKS = 1;
drop procedure if exists addYear;
drop procedure if exists addDay;
drop procedure if exists addDestination;
drop procedure if exists addRoute;
drop procedure if exists addFlight;
drop procedure if exists addPassenger;
drop procedure if exists addContact;
drop procedure if exists addReservation;
drop procedure if exists addPayment;

drop function if exists calculatePrice;
drop function if exists calculateFreeSeats;

drop view if exists allFlights;
drop view if exists temp;
/*"
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
 year integer,
 weekdayfactor double,
 	
 constraint pk_weekday_day
	primary key(day),
 constraint fk_weekday_year
	foreign key(year) references year(year)	
);

create table route(
 arrival varchar(3),
 departure varchar(3),
 year integer,
 routeprice double,

 constraint pk_route_id
    primary key(arrival,departure,year),
 constraint fk_route_arrival
	foreign key(arrival) references airport(airportcode),
 constraint fk_route_departure
	foreign key(departure) references airport(airportcode),
 constraint fk_route_year
	foreign key (year) references year(year)
);

create table schedual_weekly(
 id integer not NULL auto_increment,
 year integer,
 day varchar(30),
 departure_time time,
 arrival varchar(3),
 departure varchar(3),

 constraint pk_sch_week
	primary key (id),
 
 constraint fk_sch_year
	foreign key (year) references year(year),
 
 constraint fk_sch_day
	foreign key (day) references weekday(day),

 constraint fk_sch_route
	foreign key (arrival,departure) references route(arrival,departure)
);


create table flight(
 flightnumber integer not NULL auto_increment,
 week integer,
 time integer,

 constraint pk_flight_num
	primary key(flightnumber),
 constraint fk_flight_time
	foreign key(time) references schedual_weekly(id)

);


create table reservation(
 reservationnumber integer not NULL auto_increment,
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
 ticketnumber integer default null,
 
 constraint fk_res_pass
	foreign key(passportnumber) references passenger(passportnumber),
 constraint fk_reslist_res
	foreign key(reservation) references reservation(reservationnumber)
);

create table contact(
 passportnumber integer,
 phonenumber bigint,
 emailadress varchar(30),
 reservationnr integer,

 constraint pk_con_pass
	primary key(passportnumber),

 constraint fk_con_pass
	foreign key(passportnumber) references passenger(passportnumber),
 constraint fk_con_book
	foreign key(reservationnr) references reservation(reservationnumber)

);

create table booking(
 reservationnumber integer,
 cardnumber bigint,


 constraint pk_book_num
	primary key(reservationnumber),
 constraint fk_book_num
	foreign key(reservationnumber) references reservation(reservationnumber)


);

delimiter //
/* ----*/
create procedure addYear(in year int, in profit double) 
begin 
insert into year values(year,profit);
end //
/* -------*/
create procedure addDay(in year int,in day VARCHAR(10),in factor double)
begin
insert into weekday values(day,year,factor);
end //
/* ----------*/
create procedure addDestination(in airport_code varchar(3),in name varchar(30), in country varchar(30))
begin
insert into airport values(airport_code,name,country);
end //
/* --------*/
create procedure addRoute(in departure varchar(3),in arrival varchar(3),in year int, in routeprice double)
begin
insert into route values(arrival,departure,year,routeprice);
end //
/* -------*/
create procedure addFlight(in departure varchar(3),in arrival varchar(3),in year int,in day varchar(10), in departure_time time)
begin

declare schedual_id int;
declare week INT default 1;

insert into schedual_weekly (year,day,departure_time,arrival,departure) 
values(year,day,departure_time,arrival,departure);
set schedual_id = last_insert_id();

  while week <= 52 do
    insert into flight(week,time) values(week,schedual_id);
    set week = week + 1;
  end while;
end //


/* ---------*/

create procedure addReservation(in departure_in varchar(3),in arrival_in varchar(3), in year_in int,in week_in int, in day_in varchar(10), in time_in time, in number_of_passengers int,out output_reservation_nr int)
begin
	declare flightnr int;

	select flightnumber into flightnr from flight inner join schedual_weekly on flight.time= schedual_weekly.id where flight.week=week_in and schedual_weekly.departure=departure_in and 
		schedual_weekly.arrival=arrival_in and schedual_weekly.year=year_in and schedual_weekly.day=day_in
		and schedual_weekly.departure_time = time_in;

	if (calculateFreeSeats(flightnr)>=number_of_passengers)
		then insert into reservation(flight) values(flightnr);
			select last_insert_id() into output_reservation_nr;
	end if;
end //

/* -------*/

create procedure addPassenger(in reservation_nr integer,in passport_number int, in name varchar(30))
begin
	if(not exists(select * from reservation where reservationnumber=reservation_nr))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The given reservation number does not exist';
	end if;
	if(exists(select * from booking where reservationnumber= reservation_nr))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = ' The booking has already been payed and no futher passengers can be added';
	end if;
	if(not exists(select * from passenger where passportnumber=passport_number))
	then
	insert into passenger(passportnumber,name) values (passport_number,name);
	end if;

	insert into reservation_list(passportnumber,reservation) values (passport_number,reservation_nr);
	
end //


/* ------*/

create procedure addContact(in reservation_nr int,in passport_number int,in email varchar(30),in phone bigint)
begin
	if(not exists(select * from reservation where reservationnumber=reservation_nr))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The given reservation number does not exist';
	end if;
	if(not exists(select * from passenger where passportnumber=passport_number))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The person is not a passenger of the reservation';
	end if;
	insert into contact(passportnumber,phonenumber,emailadress,reservationnr) values(passport_number,phone,email,reservation_nr);
end //


/* --------*/

create procedure addPayment (in reservation_nr integer,in cardholder_name varchar(30),in credit_card_number bigint)
begin 
declare nr_pass int;
declare nr_free int;
declare flight int;
if(exists(select * from booking where reservationnumber=reservation_nr))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The given reservation has already been payed for';
	end if;
if(not exists(select * from reservation where reservationnumber=reservation_nr))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The given reservation number does not exist';
	end if;
if(not exists(select * from contact where reservationnr=reservation_nr))
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The reservation has no contact yet';
	end if;
select flight into flight from reservation where reservationnumber = reservation_nr;

select calculateFreeSeats(flight) into nr_free;
select count(*) into nr_pass from reservation_list where reservation = reservation_nr;


	if (nr_free >= nr_pass)
	then insert into booking(reservationnumber,cardnumber) values(reservation_nr,credit_card_number);
	else
	delete from reservation_list where reservation= reservation_nr;
	delete from contact where reservationnr=reservation_nr;
	delete from reservation where reservationnumber=reservation_nr; 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There are not enough seats available on the flight anymore, deleting reservation ';
	end if;
end //

/* --------*/

create function calculateFreeSeats(flight_number integer)
returns integer
begin
declare bookedseats integer;
select count(*) into bookedseats from reservation_list where reservation in 
	(select reservationnumber from booking where reservationnumber in
	(select reservationnumber from reservation where flight = flight_number));
return (40 - bookedseats);

end //

/* --------*/

create function calculatePrice(flight_number integer)
returns float 
begin
declare weekday_factor double;
declare bookedseats integer;
declare profit_factor double;
declare route_price double;
select count(*) into bookedseats from reservation_list where reservation in 
	(select reservationnumber from booking where reservationnumber in
	(select reservationnumber from reservation where flight = flight_number));

select weekdayfactor into weekday_factor from weekday where day in 
	(select day from schedual_weekly where id in
	(select time from flight where flightnumber = flight_number));


select profitfactor into profit_factor from year where year in 
	(select year from schedual_weekly where id in
	(select time from flight where flightnumber = flight_number));

select routeprice into route_price from route inner join schedual_weekly on (schedual_weekly.arrival,schedual_weekly.departure,schedual_weekly.year)= (route.arrival,route.departure,route.year) where schedual_weekly.id in
	(select time from flight where flightnumber = flight_number);

return route_price*weekday_factor*((bookedseats+1)/40)*profit_factor;
end //

delimiter ;

/* --------*/

CREATE TRIGGER generateTicket
AFTER INSERT ON booking
for each row
update reservation_list set ticketnumber = CAST(RAND() * 1000000 AS INT) where reservation = 
last_insert_id();

/* --------*/

create view temp as
select departure.airportname as departure_city_name,arrival.airportname as destination_city_name,schedual_weekly.departure_time,schedual_weekly.day as departure_day,flight.week as departure_week, schedual_weekly.year as departure_year
, calculateFreeSeats(flight.flightnumber) as nr_of_free_seats,calculatePrice(flight.flightnumber)as current_price_per_seat
from (flight inner join schedual_weekly on time=id) inner join route on route.arrival=schedual_weekly.arrival
and route.departure=schedual_weekly.departure  
inner join airport as arrival on arrival.airportcode= route.arrival inner join airport as departure on departure.airportcode=route.departure;

/* --------*/

create view allFlights as
select distinct * from temp;







































