---Написать SQL запросы выводящие:
---1. ошибки в расписании (фильмы накладываются друг на друга), отсортированные по возрастанию времени.
-- Выводить надо колонки «фильм 1», «время начала», «длительность», «фильм 2», «время начала», «длительность»;
SELECT
    s1.film_id AS "фильм 1", s1.start_time AS "время начала", f1.duration AS "длительность",s2.film_id AS "фильм 2", s2.start_time AS "время начала", f2.duration AS "длительность"
FROM schedule s1
         JOIN films f1 ON s1.film_id = f1.id
         JOIN schedule s2 ON s1.start_time < s2.start_time AND DATEADD('MINUTE', f1.duration, s1.start_time) > s2.start_time
         JOIN films f2 ON s2.film_id = f2.id
ORDER BY s1.start_time;


---2. перерывы 30 минут и более между фильмами — выводить по уменьшению длительности перерыва.
-- Колонки «фильм 1», «время начала», «длительность», «время начала второго фильма», «длительность перерыва»;
SELECT s1.film_id AS "фильм 1", s1.start_time AS "время начала", f1.duration AS "длительность", s2.start_time AS "время начала второго фильма", TIMESTAMPDIFF(MINUTE, DATEADD('MINUTE', f1.duration, s1.start_time), s2.start_time) AS "длительность перерыва"
FROM schedule s1
         JOIN films f1 ON s1.film_id = f1.id
         JOIN schedule s2 ON s2.start_time > DATEADD('MINUTE', f1.duration, s1.start_time)
         JOIN films f2 ON s2.film_id = f2.id
ORDER BY "длительность перерыва" DESC;


---3. список фильмов, для каждого — с указанием общего числа посетителей за все время, среднего числа зрителей за сеанс и общей суммы сборов по каждому фильму (отсортировать по убыванию прибыли). Внизу таблицы должна быть строчка «итого», содержащая данные по всем фильмам сразу;
SELECT f.name AS "название фильма",
       SUM(t.ticket_number) AS "общее число посетителей",
       AVG(t.ticket_number) AS "среднее число зрителей за сеанс",
       SUM(t.ticket_number * s.ticket_price) AS "общая сумма сборов"
FROM films f
         JOIN schedule s ON f.id = s.film_id
         JOIN tickets t ON s.id = t.schedule_id
GROUP BY f.id
ORDER BY "общая сумма сборов" DESC;
SELECT 'Итого:',
       SUM(t.ticket_number) AS "общее число посетителей",
       AVG(t.ticket_number) AS "среднее число зрителей за сеанс",
       SUM(t.ticket_number * s.ticket_price) AS "общая сумма сборов"
FROM schedule s
         JOIN tickets t ON s.id = t.schedule_id;


---4. число посетителей и кассовые сборы, сгруппированные по времени начала фильма: с 9 до 15, с 15 до 18, с 18 до 21, с 21 до 00:00 (сколько посетителей пришло с 9 до 15 часов и т.д.).
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM s.start_time) >= 9 AND EXTRACT(HOUR FROM s.start_time) < 15 THEN '9-15'
        WHEN EXTRACT(HOUR FROM s.start_time) >= 15 AND EXTRACT(HOUR FROM s.start_time) < 18 THEN '15-18'
        WHEN EXTRACT(HOUR FROM s.start_time) >= 18 AND EXTRACT(HOUR FROM s.start_time) < 21 THEN '18-21'
        WHEN EXTRACT(HOUR FROM s.start_time) >= 21 THEN '21-00'
        END AS "временной промежуток",
    SUM(t.ticket_number) AS "число посетителей",
    SUM(t.ticket_number * s.ticket_price) AS "кассовые сборы"
FROM schedule s
         JOIN tickets t ON s.id = t.schedule_id
GROUP BY CASE
             WHEN EXTRACT(HOUR FROM s.start_time) >= 9 AND EXTRACT(HOUR FROM s.start_time) < 15 THEN '9-15'
             WHEN EXTRACT(HOUR FROM s.start_time) >= 15 AND EXTRACT(HOUR FROM s.start_time) < 18 THEN '15-18'
             WHEN EXTRACT(HOUR FROM s.start_time) >= 18 AND EXTRACT(HOUR FROM s.start_time) < 21 THEN '18-21'
             WHEN EXTRACT(HOUR FROM s.start_time) >= 21 THEN '21-00'
             END;