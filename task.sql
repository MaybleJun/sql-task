-- Написать запрос по шаблону, к демонстрационной базе данных, использовать любую таблицу на ваше усмотрение, главный критерий код запроса должен быть рабочим и возвращать строки, код запроса приложить в качестве результата выполненого ДЗ, самостоятельно код запроса выполнить и проанализировать результат.

--1
SELECT flight_no, status
FROM bookings.flights;

--2
SELECT DISTINCT departure_airport
FROM bookings.flights;

--3
SELECT flight_no, scheduled_departure
FROM bookings.flights
WHERE departure_airport = 'SVO';

--4 использовать как AND так и OR в одном условии.
SELECT flight_no, departure_airport, arrival_airport, status
FROM bookings.flights
WHERE
    (status = 'Delayed' OR status = 'Cancelled')
    AND scheduled_departure > '2016-10-22 00:00:00+00';

--5
SELECT flight_no, arrival_airport
FROM bookings.flights
WHERE arrival_airport IN ('KEJ', 'PEZ');

--6
SELECT flight_no, scheduled_departure
FROM bookings.flights
WHERE scheduled_departure BETWEEN '2016-09-15 00:00:00+00' AND '2016-10-15 23:59:59+00';

--7
SELECT flight_no, status
FROM bookings.flights
WHERE status LIKE 'De%';

--8 Использовать одновременно ASC и DESC для разных столбцов
SELECT flight_no, scheduled_departure, status
FROM bookings.flights
ORDER BY status ASC, scheduled_departure DESC;

--9
SELECT status, COUNT(*)
FROM bookings.flights
GROUP BY status;

--10
SELECT COUNT(*)
FROM bookings.flights
WHERE scheduled_departure > '2016-10-15 00:00:00+00';

--11
SELECT aircraft_code, COUNT(*)
FROM bookings.flights
GROUP BY aircraft_code
HAVING COUNT(*) > 100;

-----Аналогично предыдущему заданию, по шаблонам написать рабочие запросы к демонстрационной базе данных.

-- создание таблицы, не менее 4х колонок разного типа,
-- 1 колонка первичный ключ, одна необнуляймая

CREATE TABLE bookings.flight_crews (
    crew_id SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT,
    role TEXT,
    date_of_birth DATE
);

-- удаление таблицы
DROP TABLE bookings.flight_crews;

-- создание индекса
CREATE UNIQUE INDEX idx_last_name
ON bookings.flight_crews (last_name);


-- удаление индекса
DROP INDEX bookings.idx_last_name;


-- получение описания структуры таблицы
SELECT
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'flight_crews' AND table_schema = 'bookings';

-- очистка таблицы
TRUNCATE TABLE bookings.flight_crews;

-- выбрать одно из вариантов: добавление/удаление/модификация колонок
ALTER TABLE bookings.flight_crews ADD experience_years INT;
ALTER TABLE bookings.flight_crews DROP COLUMN experience_years;
ALTER TABLE bookings.flight_crews ALTER COLUMN experience_years TYPE SMALLINT;

-- переименование таблицы
ALTER TABLE bookings.flight_crews RENAME TO former_flight_crews;

-- вставка значений
INSERT INTO bookings.flight_crews (last_name, first_name, role, date_of_birth)
VALUES ('Smith', 'John', 'Captain', '1975-05-20');

-- обновление записей
UPDATE bookings.flight_crews
SET last_name = 'Doe', first_name = 'Jane', role = 'Co-pilot'
WHERE crew_id = 1;

-- удаление записей
DELETE FROM bookings.flight_crews
WHERE crew_id = 1;