-- 2.1 Для однієї з таблиць створити команду отримання символьних значень колонки з
-- переведенням першого символу у верхній регістр, інших у нижній. При виведенні на екран визначити
-- для вказаної колонки нову назву псевдоніму.
SELECT
    id,
    first_name,
    last_name,
    patronymic,
    INITCAP(address) AS cap_address
FROM Owner;

-- ID|FIRST_NAME|LAST_NAME|PATRONYMIC |CAP_ADDRESS         |
-- --+----------+---------+-----------+--------------------+
--  1|Петров    |Петро    |Петрович   |Вул. Нижня, 50      |
--  2|Іванов    |Іван     |           |Вул. Верхня, 2а     |
--  3|Георгієв  |Георгій  |Георгійович|Вул. Лівобережна, 11|




-- 2.2. Модифікувати рішення попереднього завдання, створивши команду оновлення значення
-- вказаної колонки у таблиці.
UPDATE Owner SET address = INITCAP(address);




-- 2.3 Для однієї з символьних колонок однієї з таблиць створити команду отримання
-- мінімальної, середньої та максимальної довжин рядків.
SELECT
    MIN(LENGTH(first_name)) AS "Shortest name length",
    MAX(LENGTH(first_name)) AS "Longest name length",
    AVG(LENGTH(first_name)) AS "Average name length"
FROM Owner;

-- Shortest name length|Longest name length|Average name length                     |
-- --------------------+-------------------+----------------------------------------+
--                    6|                  8|6.66666666666666666666666666666666666667|




-- 2.4 Для колонки типу date однієї з таблиць отримати кількість днів, тижнів та місяців, що
-- пройшли до сьогодні.
SELECT
    first_name,
    last_name,
    birth_date,
    ROUND(SYSDATE - birth_date) AS "Days passed",
    ROUND((SYSDATE - birth_date) / 7) AS "Weeks passed",
    ROUND(MONTHS_BETWEEN(SYSDATE, birth_date)) AS "Months passed"
FROM Owner;

-- FIRST_NAME|LAST_NAME|BIRTH_DATE             |Days passed|Weeks passed|Months passed|
-- ----------+---------+-----------------------+-----------+------------+-------------+
-- Петров    |Петро    |2000-01-01 00:00:00.000|       8328|        1190|          274|
-- Іванов    |Іван     |1992-08-03 00:00:00.000|      11035|        1576|          363|
-- Георгієв  |Георгій  |1971-12-12 00:00:00.000|      18575|        2654|          610|