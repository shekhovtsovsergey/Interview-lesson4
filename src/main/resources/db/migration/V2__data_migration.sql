INSERT INTO films (name, duration) VALUES ('The Shawshank Redemption', 60);
INSERT INTO films (name, duration) VALUES ('The Godfather', 60);
INSERT INTO films (name, duration) VALUES ('The Dark Knight', 60);
INSERT INTO films (name, duration) VALUES ('Pulp Fiction', 60);
INSERT INTO films (name, duration) VALUES ('The Lord of the Rings: The Fellowship of the Ring', 60);

INSERT INTO schedule (film_id, start_time, ticket_price) VALUES (1, '2022-03-15 09:00:00', 1.00);
INSERT INTO schedule (film_id, start_time, ticket_price) VALUES (2, '2022-03-15 10:00:00', 2.00);
INSERT INTO schedule (film_id, start_time, ticket_price) VALUES (3, '2022-03-15 11:00:00', 3.00);
INSERT INTO schedule (film_id, start_time, ticket_price) VALUES (4, '2022-03-15 12:00:00', 4.00);
INSERT INTO schedule (film_id, start_time, ticket_price) VALUES (5, '2022-03-15 13:00:00', 5.00);

INSERT INTO tickets (schedule_id, ticket_number) VALUES (1, 1);
INSERT INTO tickets (schedule_id, ticket_number) VALUES (1, 2);
INSERT INTO tickets (schedule_id, ticket_number) VALUES (2, 3);
INSERT INTO tickets (schedule_id, ticket_number) VALUES (3, 4);
INSERT INTO tickets (schedule_id, ticket_number) VALUES (3, 5);