CREATE TABLE IF NOT EXISTS `user_queries` (id int AUTO_INCREMENT PRIMARY KEY, 
                    title VARCHAR(100) DEFAULT '',
                    genre VARCHAR(32) DEFAULT '',
                    release_year YEAR DEFAULT 0, 
                    actor_last_name VARCHAR(50) DEFAULT '', 
                    request_count INT DEFAULT 1,
                    date_of_request DATETIME DEFAULT CURRENT_TIMESTAMP,
                    UNIQUE KEY idx_user_request (title, genre, release_year, actor_last_name));


INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('dino', '', 0, '', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('dino', '', 0, '', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('dino', '', 0, '', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('', 'comedy', 0, '2006', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('', 'comedy', 0, '2006', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('dogma', 'horror', 0, '2006', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

INSERT INTO user_queries (title, genre, release_year, actor_last_name, request_count)
	VALUES ('', '', 0, '2006', 1)
	ON DUPLICATE KEY UPDATE request_count = request_count + 1, date_of_request = NOW();

select * from film f;
select * from actor a ;
select * from category;
select * from film_category ;
select * from user_queries uq ;
SELECT * FROM `user_queries` ORDER BY request_count desc, date_of_request desc  


SELECT f.film_id, f.title,
		GROUP_CONCAT(distinct c.name separator ', ') as genre,
		f.release_year, f.description,		
        GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors, 
        f.rental_rate, f.rating,
        CASE
        WHEN f.rating = 'G' THEN 'All age categories'
        WHEN f.rating = 'PG' THEN 'Parental supervision is recommended'
        WHEN f.rating = 'PG-13' THEN 'For children under 13 years'
        WHEN f.rating = 'R' THEN 'Restricted, requires adult accompaniment'
        WHEN f.rating = 'NC-17' THEN 'Only for viewers over 17 years of age'
        ELSE 'No rating'
    END AS rating_description
	FROM category c 
        join film_category fc 
        on c.category_id = fc.category_id 
        join film f 
        on fc.film_id = f.film_id
        join film_actor fa 
        on f.film_id = fa.film_id 
        join actor a 
        on fa.actor_id  = a.actor_id 
        GROUP BY f.film_id
        ORDER BY f.rental_rate DESC;
