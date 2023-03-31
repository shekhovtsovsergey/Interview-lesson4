drop table if exists films;
drop table if exists schedule;
drop table if exists tickets;

CREATE TABLE films (
                       id int(11) NOT NULL AUTO_INCREMENT,
                       name varchar(255) NOT NULL,
                       duration int(11) NOT NULL
);


CREATE TABLE schedule (
                          id int(11) NOT NULL AUTO_INCREMENT,
                          film_id int(11) NOT NULL,
                          start_time datetime NOT NULL,
                          ticket_price decimal(10,2) NOT NULL
);

CREATE TABLE tickets (
                         id int(11) NOT NULL AUTO_INCREMENT,
                         schedule_id int(11) NOT NULL,
                         ticket_number int(11) NOT NULL
);

ALTER TABLE films ADD CONSTRAINT pk_films_id PRIMARY KEY (id);
ALTER TABLE schedule ADD CONSTRAINT fk_schedule_film_id FOREIGN KEY (film_id) REFERENCES films (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE tickets ADD CONSTRAINT fk_tickets_schedule_id FOREIGN KEY (schedule_id) REFERENCES schedule (id) ON DELETE CASCADE ON UPDATE CASCADE;