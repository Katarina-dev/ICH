USE OnlineStore;

DROP TABLE IF EXISTS date_learning;

CREATE TABLE IF NOT EXISTS date_learning (
    date_ DATE,
    time_ TIME,
    date_time DATETIME
);

INSERT INTO date_learning
VALUES
    ('2024-09-03', '09:00:00', '2024-09-03 09:00:00'),
    (CURRENT_DATE(), CURRENT_TIME(), NOW()),
    (CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP());


SELECT * FROM date_learning;