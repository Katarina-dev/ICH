USE 050824_dam_ClassWork;

SELECT * FROM toys1;

DELETE FROM toys1 
WHERE
    toy_name = 'Скейтборд' LIMIT 3;
    

DELETE FROM toys1 
LIMIT 100;

COMMIT;


    
INSERT INTO toys1 (
	toy_name,
	weight
) VALUES (
	"Скутер",
	10
);

/* Обратите внимание, что автоинкримент ведёт себя так, будто строке не удалены!
Но TRANCATE полность меняет картину. */

TRUNCATE TABLE toys1;

INSERT INTO toys1 (
	toy_name,
	weight
) VALUES (
	"Скутер",
	10
);

/* Как видим при TRANCATE автоинктимент полностью сбрасывается. */