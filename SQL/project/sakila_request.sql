

select * from film where title like '%ACADEMY DINOSAUR%';

select * from film;


select * from category;

select * from category c
join film_category fc
on c.category_id = fc.category_id 
join film f
on fc.film_id = f.film_id 
where c.name like '%classic%' and f.release_year like '%20%'; 

select * from queries_genre_year;
select * from queries_keywords;