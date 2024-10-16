SELECT * FROM airliners;
SELECT * FROM clients;
SELECT * FROM tickets;
SELECT * FROM trips;


-- 1. Выведите количество лайнеров в каждом году.

SELECT production_year, COUNT(*) FROM airliners group by production_year ;

-- 2. Выведите количество лайнеров в каждом году с годами, где количеством лайнеров больше 1.

SELECT production_year, COUNT(*) as airlines_cnt FROM airliners 
group by production_year 
HAVING airlines_cnt > 1;

-- 3. Выведите список client_id, amount_of_tickets (таблица tickets), который содержит айди клиентов и количество билетов у каждого.

SELECT client_id, COUNT(*) amount_of_tickets FROM tickets 
group by client_id;

-- 4. Выведите только тех клиентов, у которых больше 2 билетов.

SELECT client_id, COUNT(*) amount_of_tickets FROM tickets 
group by client_id
HAVING amount_of_tickets > 2;

-- 5. Измените запрос так, чтобы вместо айди клиентов выводились их имена (join с таблицей clients).

select c.name, count(t.id) as amount_of_tickets from tickets as t 
join clients as c on t.client_id = c.id
group by client_id
having amount_of_tickets > 2;

-- 6. Выведите среднюю стоимость билетов в каждом сервисном классе.

select service_class, avg(price) from tickets
group by service_class;

SELECT 
    service_class, FORMAT(AVG(price),2)
FROM
    tickets
GROUP BY service_class;

-- 7. Выведите список самых популярных аэропортов отправления (trips departures).

SELECT departure,  COUNT(*) as dep_cnt from trips 
group by departure
ORDER BY dep_cnt DESC;

-- 8. Выведите самого молодого клиента.

select name, age from clients order by age asc limit 1;

-- 9. Выведите имена клиентов, код аэропорта отправления и прибытия (выборка
-- из tickets и join с clients и с trips).

select c.name, tr.departure, tr.arrival from clients as c
left join tickets as ti on c.id = ti.client_id
left join trips as tr on tr.id = ti.trip_id;

-- 10. Выведите имена клиентов, чьи поездки (trips) были отменены.

SELECT c.name, tr.status from clients c 
JOIN tickets ti on c.id = ti.client_id
JOIN trips tr on ti.trip_id = tr.id
WHERE tr.status = 'Cancelled';