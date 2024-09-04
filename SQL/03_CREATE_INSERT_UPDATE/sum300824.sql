USE 050824_new;

CREATE TABLE IF NOT EXISTS Schedule_3 (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Classname VARCHAR(200),
    Subjects VARCHAR(100),
    Teacher VARCHAR(100),
    Dates DATE,
    Start_time TIME,
    End_time TIME);
    
    SELECT * FROM Schedule_3;
    
    INSERT INTO Schedule_3
		(Classname, Subjects, Teacher, Dates, Start_time, End_time)
	VALUES
		('Python 11: Summary session 3', 'Python Fundamentals', 'Timchuk Oleg', '2024-08-30', '09:00:00', '10:30:00');
    
	INSERT INTO Schedule_3
		(Classname, Subjects, Teacher, Dates, Start_time, End_time)
	VALUES
		('Datebase 9: Summary session SQL 3', 'Databases', 'Barbylev Ilya', '2024-08-30', '10:45:00', '12:15:00'),
        ('Google sheets 18: Summary session 3', 'Google sheets', 'Rykhlova Elena', '2024-08-30', '12:30:00', '14:00:00');
        