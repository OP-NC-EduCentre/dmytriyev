-- 1. Класифікуйте значення однієї з колонок на 3 категорії залежно від загальної суми
-- значень у будь-якій числовій колонці. Використати аналітичну функцію NTILE.

SELECT
    CAR_NUMBER,
    BRAND,
    COLOR,
    OWNER,
    PRODUCTION_YEAR,
    WEIGHT,
    NTILE(3) OVER (ORDER BY WEIGHT) CATEGORY
FROM CAR;

-- CAR_NUMBER|BRAND |COLOR   |OWNER|PRODUCTION_YEAR|WEIGHT|CATEGORY|
-- ----------+------+--------+-----+---------------+------+--------+
-- АА5555АА  |ЗАЗ   |Червоний|   24|     2006-01-01|   1.5|       1|
-- ВН5050АА  |ЗАЗ   |Білий   |   24|     2014-01-01|   1.5|       1|
-- АА0001АА  |Еталон|Червоний|    2|     2010-01-01|   1.7|       1|
-- ВН1001НВ  |Еталон|Синій   |    2|     2010-01-01|   1.8|       2|
-- ВН0000АА  |ZAZ   |Чорний  |    1|     2005-01-01|     2|       2|
-- АА0000АА  |ПАЗ   |Синій   |    1|     1991-01-01|     5|       3|
-- АА0002АА  |ПАЗ   |Сірий   |    2|     2001-01-01|     7|       3|




-- 2. Складіть запит, який поверне списки лідерів (список за убуванням відповідного
-- значення) у підгрупах, отриманих у першому завданні етапу 1.

WITH
CATTED AS (
    SELECT
        CAR_NUMBER,
        BRAND,
        COLOR,
        OWNER,
        PRODUCTION_YEAR,
        WEIGHT,
        NTILE(3) OVER (ORDER BY WEIGHT) CATEGORY
    FROM CAR
),
RANKED AS (
    SELECT
        CAR_NUMBER,
        BRAND,
        COLOR,
        OWNER,
        PRODUCTION_YEAR,
        WEIGHT,
        CATEGORY,
        RANK() OVER (PARTITION BY CATEGORY ORDER BY WEIGHT) RANK
    FROM CATTED
)
SELECT
    CAR_NUMBER,
    BRAND,
    COLOR,
    OWNER,
    PRODUCTION_YEAR,
    WEIGHT,
    CATEGORY,
    RANK
FROM RANKED
WHERE RANK = 1;

-- CAR_NUMBER|BRAND |COLOR   |OWNER|PRODUCTION_YEAR|WEIGHT|CATEGORY|RANK|
-- ----------+------+--------+-----+---------------+------+--------+----+
-- АА5555АА  |ЗАЗ   |Червоний|   24|     2006-01-01|   1.5|       1|   1|
-- ВН5050АА  |ЗАЗ   |Білий   |   24|     2014-01-01|   1.5|       1|   1|
-- ВН1001НВ  |Еталон|Синій   |    2|     2010-01-01|   1.8|       2|   1|
-- АА0000АА  |ПАЗ   |Синій   |    1|     1991-01-01|     5|       3|   1|




-- 3. Модифікуйте рішення попереднього завдання, повернувши по 2 лідери у кожній
-- підгрупі.

WITH
CATTED AS (
    SELECT
        CAR_NUMBER,
        BRAND,
        COLOR,
        OWNER,
        PRODUCTION_YEAR,
        WEIGHT,
        NTILE(3) OVER (ORDER BY WEIGHT) CATEGORY
    FROM CAR
),
RANKED AS (
    SELECT
        CAR_NUMBER,
        BRAND,
        COLOR,
        OWNER,
        PRODUCTION_YEAR,
        WEIGHT,
        CATEGORY,
        ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY WEIGHT) RANK
    FROM CATTED
)
SELECT
    CAR_NUMBER,
    BRAND,
    COLOR,
    OWNER,
    PRODUCTION_YEAR,
    WEIGHT,
    CATEGORY,
    RANK
FROM RANKED
WHERE RANK <= 2;

-- CAR_NUMBER|BRAND |COLOR   |OWNER|PRODUCTION_YEAR|WEIGHT|CATEGORY|RANK|
-- ----------+------+--------+-----+---------------+------+--------+----+
-- АА5555АА  |ЗАЗ   |Червоний|   24|     2006-01-01|   1.5|       1|   1|
-- ВН5050АА  |ЗАЗ   |Білий   |   24|     2014-01-01|   1.5|       1|   2|
-- ВН1001НВ  |Еталон|Синій   |    2|     2010-01-01|   1.8|       2|   1|
-- ВН0000АА  |ZAZ   |Чорний  |    1|     2005-01-01|     2|       2|   2|
-- АА0000АА  |ПАЗ   |Синій   |    1|     1991-01-01|     5|       3|   1|
-- АА0002АА  |ПАЗ   |Сірий   |    2|     2001-01-01|     7|       3|   2|




-- 4. Складіть запит, який повертає рейтинг будь-якого з перерахованих значень
-- відповідно до вашої предметноїобласті: товарів/послуг/співробітників/клієнтів тощо.

SELECT
    CAR_NUMBER,
    BRAND,
    COLOR,
    OWNER,
    PRODUCTION_YEAR,
    WEIGHT,
    RANK() OVER (ORDER BY WEIGHT DESC) RANK
FROM CAR;

-- CAR_NUMBER|BRAND |COLOR   |OWNER|PRODUCTION_YEAR|WEIGHT|RANK|
-- ----------+------+--------+-----+---------------+------+----+
-- АА0002АА  |ПАЗ   |Сірий   |    2|     2001-01-01|     7|   1|
-- АА0000АА  |ПАЗ   |Синій   |    1|     1991-01-01|     5|   2|
-- ВН0000АА  |ZAZ   |Чорний  |    1|     2005-01-01|     2|   3|
-- ВН1001НВ  |Еталон|Синій   |    2|     2010-01-01|   1.8|   4|
-- АА0001АА  |Еталон|Червоний|    2|     2010-01-01|   1.7|   5|
-- ВН5050АА  |ЗАЗ   |Білий   |   24|     2014-01-01|   1.5|   6|
-- АА5555АА  |ЗАЗ   |Червоний|   24|     2006-01-01|   1.5|   6|




-- 5. Одна з колонок таблиці повинна містити значення, що повторюються, для
-- виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
-- отримає перше значення у кожній підгрупі. Використати аналітичну функцію
-- FIRST_VALUE.

WITH
GROUPED AS (
    SELECT
        CAR_NUMBER,
        BRAND,
        COLOR,
        OWNER,
        PRODUCTION_YEAR,
        WEIGHT,
        FIRST_VALUE(WEIGHT) OVER (PARTITION BY OWNER ORDER BY WEIGHT DESC) TOP_WEIGHT
    FROM CAR
)
SELECT
    CAR_NUMBER,
    BRAND,
    COLOR,
    OWNER,
    PRODUCTION_YEAR,
    WEIGHT
FROM GROUPED
WHERE WEIGHT = TOP_WEIGHT;

-- CAR_NUMBER|BRAND|COLOR   |OWNER|PRODUCTION_YEAR|WEIGHT|
-- ----------+-----+--------+-----+---------------+------+
-- АА0000АА  |ПАЗ  |Синій   |    1|     1991-01-01|     5|
-- АА0002АА  |ПАЗ  |Сірий   |    2|     2001-01-01|     7|
-- ВН5050АА  |ЗАЗ  |Білий   |   24|     2014-01-01|   1.5|
-- АА5555АА  |ЗАЗ  |Червоний|   24|     2006-01-01|   1.5|