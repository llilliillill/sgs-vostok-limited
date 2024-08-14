-- Создаём базу данных если ее нет
-- иначе выбераем её
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'db')
	CREATE DATABASE db
ELSE
	USE db

-- Удаляем таблицы
DROP TABLE IF EXISTS containers;
DROP TABLE IF EXISTS operations;

-- Создаём таблицу контейнеров
CREATE TABLE containers (
	id INT PRIMARY KEY IDENTITY,
	number NUMERIC,
	type TEXT,
	length NUMERIC,
	width NUMERIC,
	height NUMERIC,
	weight NUMERIC,
	empty BIT,
	date DATETIME
)

-- Создаём таблицу операций
CREATE TABLE operations (
	id INT PRIMARY KEY IDENTITY,
	container_id INT UNIQUE,
	operation_start_date DATETIME,
	operation_end_date DATETIME,
	operation_type TEXT,
	operator_name TEXT,
	location TEXT,
)

-- Вставляем данные в таблицу контейнеры
INSERT INTO containers VALUES 
(11, 'standard', 5905, 2350, 2381, 2230, 0, '20240816 14:35'),
(12, 'refrigerated', 6060, 2438, 2590, 20800, 1, '20240814 16:10'),
(13, 'open top', 6060, 2438, 2590, 21600, 0, '20240815 13:25'),
(14, 'platform', 6060, 2438, 2590, 28000, 1, '20240816 17:30'),
(15, 'thermal insulated', 6058, 2438, 2591, 15240, 0, '20240816 18:10'),
(16, 'ventilated', 6058, 2438, 2591, 21350, 1, '20240815 13:25')

-- Вставляем данные в таблицу операций
INSERT INTO operations VALUES 
(6, '20240820 10:05', '20240930 12:30', 'переместить', 'Иванов Иван Иванович', 'Морской порт Санкт-Петербург'),
(5, '20240830 11:00', '20240930 15:05', 'разгрузить', 'Петров Петр Петрович', 'Морской порт Санкт-Петербург'),
(4, '20240818 12:35', '20240922 18:30', 'переместить', 'Воробьев Стас Максимович', 'Морской порт Санкт-Петербург'),
(3, '20240812 11:00', '20240903 17:00', 'разгрузить', 'Семенов Александр Федорович', 'Морской порт Санкт-Петербург'),
(2, '20240810 10:30', '20240901 16:35', 'оформить', 'Соколов Владимир Иванович', 'Морской порт Санкт-Петербург'),
(1, '20240806 12:00', '20240930 14:30', 'оформить', 'Павлов Олег Юрьевич', 'Морской порт Санкт-Петербург')

-- Напишите запрос, выбирающий из первой таблицы все данные 
-- по контейнерам в формате JSON не используя встроенную функцию
DECLARE @i INT, @count INT, @json VARCHAR(8000) 

SET @count = (SELECT COUNT(*) FROM containers)
SET @json = '['
SET @i = 1

WHILE @i <= @count
	BEGIN
		DECLARE @id INT, @number NUMERIC, @type VARCHAR(15), 
		@length NUMERIC, @width NUMERIC, @height NUMERIC, 
		@weight NUMERIC, @empty NUMERIC, @date DATETIME

		SET @id     = (SELECT id FROM containers WHERE id = @i)
		SET @number = (SELECT number FROM containers WHERE id = @i)
		SET @type   = (SELECT type FROM containers WHERE id = @i)
		SET @length = (SELECT length FROM containers WHERE id = @i)
		SET @width  = (SELECT width FROM containers WHERE id = @i)
		SET @height = (SELECT height FROM containers WHERE id = @i)
		SET @weight = (SELECT weight FROM containers WHERE id = @i)
		SET @empty  = (SELECT empty FROM containers WHERE id = @i)
		SET @date   = (SELECT date FROM containers WHERE id = @i)
		
		SET @json = @json + '{ "id": "' + CAST(@id AS VARCHAR(5)) + '", '
		SET @json = @json + '"number": "' + CAST(@number AS VARCHAR(5)) + '", '
		SET @json = @json + '"type": "' + @type + '", '
		SET @json = @json + '"length": "' + CAST(@length AS VARCHAR(5)) + '", '
		SET @json = @json + '"width": "' + CAST(@width AS VARCHAR(5)) + '", '
		SET @json = @json + '"height": "' + CAST(@height AS VARCHAR(5)) + '", '
		SET @json = @json + '"weight": "' + CAST(@weight AS VARCHAR(5)) + '", '
		SET @json = @json + '"empty": "' + CAST(@empty AS VARCHAR(1)) + '", '
		SET @json = @json + '"date": "' + CAST(@date AS VARCHAR(20)) + '" }'

		IF (@i < @count)
			BEGIN
				SET @json = @json + ', '
			END
		
		SET @i = @i + 1
	END

SET @json = @json + ']'

PRINT @json

-- Напишите запрос, выбирающий из второй таблицы все данные по операциям 
-- для определенного контейнера в формате JSON не используя встроенную функцию
DECLARE @json2 VARCHAR(8000), @operation_id INT, @container_id NUMERIC, 
@operation_start_date VARCHAR(20), @operation_end_date VARCHAR(20), 
@operation_type VARCHAR(20), @operator_name VARCHAR(20), @location VARCHAR(30)

SET @json2 = ''
SET @operation_id         = (SELECT id FROM operations WHERE container_id = 1)
SET @container_id         = (SELECT container_id FROM operations WHERE container_id = 1)
SET @operation_start_date = (SELECT operation_start_date FROM operations WHERE container_id = 1)
SET @operation_end_date   = (SELECT operation_end_date FROM operations WHERE container_id = 1)
SET @operation_type       = (SELECT operation_type FROM operations WHERE container_id = 1)
SET @operator_name        = (SELECT operator_name FROM operations WHERE container_id = 1)
SET @location             = (SELECT location FROM operations WHERE container_id = 1)
		
SET @json2 = @json2 + '{ "id": "' + CAST(@operation_id AS VARCHAR(5)) + '", '
SET @json2 = @json2 + '"container_id": "' + CAST(@container_id AS VARCHAR(5)) + '", '
SET @json2 = @json2 + '"operation_start_date": "' + CAST(@operation_start_date AS VARCHAR(20)) + '", '
SET @json2 = @json2 + '"operation_end_date": "' + CAST(@operation_end_date AS VARCHAR(20)) + '", '
SET @json2 = @json2 + '"operation_type": "' + CAST(@operation_type AS VARCHAR(20)) + '", '
SET @json2 = @json2 + '"operator_name": "' + CAST(@operator_name AS VARCHAR(20)) + '", '
SET @json2 = @json2 + '"location": "' + CAST(@location AS VARCHAR(30)) + '" }'

PRINT @json2