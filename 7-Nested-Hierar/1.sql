-- 1. Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-
-- з'єднанням.

-- Отримання інформації про транспорт, легший за транспорт з номерами ВН0000АА
SELECT 
    car_number,
    brand,
    color,
    type,
    weight
FROM Car
WHERE weight < (
                SELECT weight
                FROM Car
                WHERE car_number = 'ВН0000АА'
               );

-- CAR_NUMBER|BRAND |COLOR   |TYPE      |WEIGHT|
-- ----------+------+--------+----------+------+
-- АА0001АА  |Еталон|Червоний|Вантажівка|   1.7|
-- ВН5050АА  |ЗАЗ   |Білий   |Легковик  |   1.5|




-- 2. Використання агрегатних функцій у підзапитах.

-- Отримання інформації про транспорт, вага якого є мінімальною
SELECT
    car_number,
    brand,
    color,
    type,
    weight
FROM Car
WHERE weight = (
                SELECT MIN(WEIGHT) FROM CAR
               );

-- CAR_NUMBER|BRAND|COLOR|TYPE    |WEIGHT|
-- ----------+-----+-----+--------+------+
-- ВН5050АА  |ЗАЗ  |Білий|Легковик|   1.5|




-- 3. Пропозиція HAVING із підзапитами.

-- Отримання списку транспорту, вага якого більша за середню вагу усього транспорту
SELECT 
    car_number,
    AVG(weight)
FROM Car
GROUP BY car_number
HAVING AVG(weight) >= (
                        SELECT AVG(weight) FROM Car
                      );

-- CAR_NUMBER|AVG(WEIGHT)|
-- ----------+-----------+
-- АА0000АА  |          5|
-- АА0002АА  |          7|




-- 4. Виконання багаторядкових підзапитів

-- Отримання списку власників транспорту, випущеного після 2000 року. Зі списку вилучити марку ПАЗ
SELECT *
FROM CAR_OWNERS
WHERE 
    CAR_NUMBER = ANY (
                        SELECT car_number
                        FROM Car
                        WHERE production_year >= '01-01-2000'
                     ) 
    AND "CAR BRAND" <> 'ПАЗ';

-- FIRST_NAME|LAST_NAME|CAR_NUMBER|CAR BRAND|
-- ----------+---------+----------+---------+
-- Петров    |Петро    |ВН0000АА  |ZAZ      |
-- Іванов    |Іван     |АА0001АА  |Еталон   |
-- Петренко  |Григорій |ВН5050АА  |ЗАЗ      |




-- 5. Використання оператора WITH для структуризації запиту

-- Отримати список осіб, які володіють як мінімум двома автомобілями
WITH CAR_COUNT AS (
    SELECT 
        OWNER, 
        COUNT(OWNER) AS COUNT 
    FROM CAR 
    GROUP BY OWNER
)
SELECT
    O.FIRST_NAME,
    O.LAST_NAME,
    O.PATRONYMIC,
    O.BIRTH_DATE,
    CC.COUNT
FROM CAR_COUNT CC, OWNER O
WHERE CC.OWNER = O.ID;

-- FIRST_NAME|LAST_NAME|PATRONYMIC|BIRTH_DATE|COUNT|
-- ----------+---------+----------+----------+-----+
-- Петров    |Петро    |Петрович  |2000-01-01|    2|
-- Іванов    |Іван     |          |1992-08-03|    2|
-- Петренко  |Григорій |Іванович  |1976-12-10|    1|




-- 6. Використання кореляційних підзапитів
SELECT
    C.CAR_NUMBER,
    C.BRAND,
    C.COLOR,
    C.TYPE,
    C.WEIGHT
FROM CAR C
WHERE NOT EXISTS (
                    SELECT * 
                    FROM PARKINGSLOT P
                    WHERE P.CAR = C.CAR_NUMBER
                 );

-- CAR_NUMBER|BRAND |COLOR   |TYPE      |WEIGHT|
-- ----------+------+--------+----------+------+
-- ВН0000АА  |ZAZ   |Чорний  |Легковик  |     2|
-- АА0001АА  |Еталон|Червоний|Вантажівка|   1.7|
-- АА0002АА  |ПАЗ   |Сірий   |Вантажівка|     7|
-- ВН5050АА  |ЗАЗ   |Білий   |Легковик  |   1.5|