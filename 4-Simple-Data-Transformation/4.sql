-- 4.1 Повторити рішення завдання 3.1
SELECT first_name, last_name, car_number
FROM Owner, Car;

-- FIRST_NAME|LAST_NAME|CAR_NUMBER|
-- ----------+---------+----------+
-- Петров    |Петро    |АА0000АА  |
-- Петров    |Петро    |АА0001АА  |
-- Петров    |Петро    |АА0002АА  |
-- Петров    |Петро    |ВН0000АА  |
-- Петров    |Петро    |ВН0001АА  |
-- Іванов    |Іван     |АА0000АА  |
-- Іванов    |Іван     |АА0001АА  |
-- Іванов    |Іван     |АА0002АА  |
-- Іванов    |Іван     |ВН0000АА  |
-- Іванов    |Іван     |ВН0001АА  |
-- Георгієв  |Георгій  |АА0000АА  |
-- Георгієв  |Георгій  |АА0001АА  |
-- Георгієв  |Георгій  |АА0002АА  |
-- Георгієв  |Георгій  |ВН0000АА  |
-- Георгієв  |Георгій  |ВН0001АА  |




-- 4.2 Повторити рішення завдання 3.2
SELECT 
    o.first_name, 
    o.last_name,
    c.car_number,
    c.brand AS "CAR BRAND"
FROM Owner o, Car c
WHERE o.id = c.owner;

-- FIRST_NAME|LAST_NAME|CAR_NUMBER|CAR BRAND|
-- ----------+---------+----------+---------+
-- Петров    |Петро    |ВН0000АА  |ЗАЗ      |
-- Петров    |Петро    |АА0000АА  |ПАЗ      |
-- Іванов    |Іван     |АА0001АА  |Еталон   |
-- Іванов    |Іван     |АА0002АА  |ПАЗ      |
-- Петров    |Петро    |ВН0001АА  |ЗАЗА     |




-- 4.3 Повторити рішення завдання 3.4
SELECT
    o.first_name, 
    o.last_name,
    c.car_number,
    c.brand AS "CAR BRAND"
FROM Owner o, Car c
WHERE o.id = c.owner (+);

-- FIRST_NAME|LAST_NAME|CAR_NUMBER|CAR BRAND|
-- ----------+---------+----------+---------+
-- Петров    |Петро    |ВН0000АА  |ЗАЗ      |
-- Петров    |Петро    |АА0000АА  |ПАЗ      |
-- Іванов    |Іван     |АА0001АА  |Еталон   |
-- Іванов    |Іван     |АА0002АА  |ПАЗ      |
-- Петров    |Петро    |ВН0001АА  |ЗАЗА     |
-- Георгієв  |Георгій  |          |         |