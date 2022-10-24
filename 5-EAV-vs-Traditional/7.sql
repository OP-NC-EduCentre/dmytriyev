-- 7.1 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
-- рішення завдання No 4.2 лабораторної роботи No 3:
-- Для однієї з таблиць створити команду отримання значень всіх колонок (явно перерахувати) за
-- окремими рядками з урахуванням умови: символьне значення однієї з колонок має співпадати з якимось
-- константним значенням.
SELECT
    CAR_NUMBER.VALUE AS CAR_NUMBER,
    BRAND.VALUE AS BRAND,
    COLOR.VALUE AS COLOR,
    PRODUCTION_YEAR.VALUE AS PRODUCTION_YEAR,
    TYPE_VALUE.VALUE AS TYPE,
    WEIGHT.VALUE AS WEIGHT,
    CAR.PARENT_ID AS OWNER
FROM
    OBJECTS CAR,
    ATTRIBUTES CAR_NUMBER,
    ATTRIBUTES BRAND,
    ATTRIBUTES COLOR,
    ATTRIBUTES PRODUCTION_YEAR,
    LISTS TYPE_VALUE,
    ATTRIBUTES TYPE_ATTR,
    ATTRIBUTES WEIGHT,
    OBJTYPE OT
WHERE
    OT.CODE = 'Car'
    AND OT.OBJECT_TYPE_ID = CAR.OBJECT_TYPE_ID
    AND CAR_NUMBER.OBJECT_ID = CAR.OBJECT_ID
    AND CAR_NUMBER.ATTR_ID = 8
    AND BRAND.OBJECT_ID = CAR.OBJECT_ID
    AND BRAND.ATTR_ID = 9
    AND COLOR.OBJECT_ID = CAR.OBJECT_ID
    AND COLOR.ATTR_ID = 10
    AND PRODUCTION_YEAR.OBJECT_ID = CAR.OBJECT_ID
    AND PRODUCTION_YEAR.ATTR_ID = 11
    AND TYPE_VALUE.ATTR_ID = TYPE_ATTR.ATTR_ID
    AND TYPE_VALUE.LIST_VALUE_ID = TYPE_ATTR.LIST_VALUE_ID
    AND TYPE_ATTR.OBJECT_ID = CAR.OBJECT_ID
    AND TYPE_ATTR.ATTR_ID = 12
    AND WEIGHT.OBJECT_ID = CAR.OBJECT_ID
    AND WEIGHT.ATTR_ID = 13
    AND TYPE_VALUE.VALUE = 'Вантажівка';

-- CAR_NUMBER|BRAND|COLOR|PRODUCTION_YEAR|TYPE      |WEIGHT|OWNER|
-- ----------+-----+-----+---------------+----------+------+-----+
-- АА0000АА  |ПАЗ  |Синій|               |Вантажівка|5     |    1|



-- 7.2 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
-- рішення завдання No 6.1 лабораторної роботи No 3:
-- Для однієї з таблиць створити команду отримання кількості рядків таблиці.
SELECT COUNT(OBJECT_ID) AS COUNT
FROM OBJECTS
WHERE OBJECT_TYPE_ID = 2;

-- COUNT|
-- -----+
--     2|




-- 7.3 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
-- рішення завдання No 3.2 лабораторної роботи No 4:
-- Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду отримання двох
-- колонок першої та другої таблиць з використанням екві-з’єднання таблиць. Використовувати префікси.
SELECT
    FIRST_NAME.VALUE AS FIRST_NAME,
    LAST_NAME.VALUE AS LAST_NAME,
    CAR_NUMBER.VALUE AS CAR_NUMBER,
    BRAND.VALUE AS BRAND
FROM 
    OBJECTS OWNER,
    OBJECTS CAR,
    ATTRIBUTES FIRST_NAME,
    ATTRIBUTES LAST_NAME,
    ATTRIBUTES CAR_NUMBER,
    ATTRIBUTES BRAND
WHERE
    OWNER.OBJECT_ID = CAR.PARENT_ID
    AND FIRST_NAME.OBJECT_ID = OWNER.OBJECT_ID
    AND FIRST_NAME.ATTR_ID = 1
    AND LAST_NAME.OBJECT_ID = OWNER.OBJECT_ID
    AND LAST_NAME.ATTR_ID = 2
    AND CAR_NUMBER.OBJECT_ID = CAR.OBJECT_ID
    AND CAR_NUMBER.ATTR_ID = 8
    AND BRAND.OBJECT_ID = CAR.OBJECT_ID
    AND BRAND.ATTR_ID = 9;

-- FIRST_NAME|LAST_NAME|CAR_NUMBER|BRAND|
-- ----------+---------+----------+-----+
-- Петро     |Петров   |ВН0000АА  |ЗАЗ  |
-- Петро     |Петров   |АА0000АА  |ПАЗ  |