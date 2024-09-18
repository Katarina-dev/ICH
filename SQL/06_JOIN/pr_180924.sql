-- Выведите список стран со столицами

select * from country;
select * from city;
select * from countrylanguage;

select co.Name as Country, ci.Name as City
from country co
join city ci
on co.Capital = ci.ID;


-- Выведите список стран с языками, на которых в них говорят

select c.name, l.language
from country c
join countrylanguage l
on c.Code = l.CountryCode;

--  Выведите список стран с официальными языками

select c.name, l.language
from country c
join countrylanguage l
on c.Code = l.CountryCode
where l.IsOfficial = 'T';

--  Сравните результаты (количество записей в результате) предыдущих запросов. Где в результате больше записей?

-- Поменяйте последний запрос (3) так, чтобы результат выглядел так (например, для Samoa): Samoa | {English, Samoan}, то есть на каждую страну была только одна
-- запись, а соответствующие официальные языки бы отображались в одно строчку списком.

select concat(c.name, ' | {',GROUP_CONCAT(language separator ', '),'}') as Official_languages
from country c
join countrylanguage l
on c.Code = l.CountryCode
where l.IsOfficial = 'T'
group by c.name;

