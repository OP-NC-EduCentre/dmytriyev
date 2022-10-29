-- 4.1 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: цілочисельне значення однієї з колонок
-- має бути більшим за якесь константне значення.
SELECT 
    car_number,
    brand,
    color,
    production_year,
    type,
    weight,
    owner,
    purchase_date
FROM Car
WHERE
    weight > 2;

-- CAR_NUMBER|BRAND|COLOR|PRODUCTION_YEAR        |TYPE      |WEIGHT|OWNER|PURCHASE_DATE          |
-- ----------+-----+-----+-----------------------+----------+------+-----+-----------------------+
-- АА0000АА  |ПАЗ  |Синій|1991-01-01 00:00:00.000|Вантажівка|     5|    1|                       |
-- АА0002АА  |ПАЗ  |Сірий|2001-01-01 00:00:00.000|Вантажівка|     7|    2|2018-10-10 00:00:00.000|




-- 4.2 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
-- має співпадати з якимось константним значенням.
SELECT 
    car_number,
    brand,
    color,
    production_year,
    type,
    weight,
    owner,
    purchase_date
FROM Car
WHERE
    type = 'Вантажівка';

-- CAR_NUMBER|BRAND |COLOR   |PRODUCTION_YEAR        |TYPE      |WEIGHT|OWNER|PURCHASE_DATE          |
-- ----------+------+--------+-----------------------+----------+------+-----+-----------------------+
-- АА0000АА  |ПАЗ   |Синій   |1991-01-01 00:00:00.000|Вантажівка|     5|    1|                       |
-- АА0001АА  |Еталон|Червоний|2010-01-01 00:00:00.000|Вантажівка|   1.5|    2|                       |
-- АА0002АА  |ПАЗ   |Сірий   |2001-01-01 00:00:00.000|Вантажівка|     7|    2|2018-10-10 00:00:00.000|




-- 4.3 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
-- повинно містити в першому та третьому знакомісті якісь надані вами символи.
SELECT 
    car_number,
    brand,
    color,
    production_year,
    type,
    weight,
    owner,
    purchase_date
FROM Car
WHERE
    brand LIKE 'З_З%';

-- CAR_NUMBER|BRAND|COLOR |PRODUCTION_YEAR        |TYPE    |WEIGHT|OWNER|PURCHASE_DATE|
-- ----------+-----+------+-----------------------+--------+------+-----+-------------+
-- ВН0000АА  |ЗАЗ  |Чорний|2005-01-01 00:00:00.000|Легковик|     2|    1|             |
-- ВН0001АА  |ЗАЗА |Білий |2012-01-01 00:00:00.000|Автобус |     4|    1|             |




-- 4.4 У завданні 1.2 було додано колонку типу date. Створити команду отримання значень
-- всіх колонок (явно перерахувати) за окремими рядками з урахуванням умови: значення доданої
-- колонки містить невизначене значення.
SELECT 
    car_number,
    brand,
    color,
    production_year,
    type,
    weight,
    owner,
    purchase_date
FROM Car
WHERE
    purchase_date IS NULL;

-- CAR_NUMBER|BRAND |COLOR   |PRODUCTION_YEAR        |TYPE      |WEIGHT|OWNER|PURCHASE_DATE|
-- ----------+------+--------+-----------------------+----------+------+-----+-------------+
-- ВН0000АА  |ЗАЗ   |Чорний  |2005-01-01 00:00:00.000|Легковик  |     2|    1|             |
-- АА0000АА  |ПАЗ   |Синій   |1991-01-01 00:00:00.000|Вантажівка|     5|    1|             |
-- АА0001АА  |Еталон|Червоний|2010-01-01 00:00:00.000|Вантажівка|   1.5|    2|             |
-- ВН0001АА  |ЗАЗА  |Білий   |2012-01-01 00:00:00.000|Автобус   |     4|    1|             |




-- 4.5 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
-- рядками з урахуванням умови, що поєднує умови з рішень завдань 4.1 та 4.2
SELECT 
    car_number,
    brand,
    color,
    production_year,
    type,
    weight,
    owner,
    purchase_date
FROM Car
WHERE
    weight > 2 AND type = 'Вантажівка';

-- CAR_NUMBER|BRAND|COLOR|PRODUCTION_YEAR        |TYPE      |WEIGHT|OWNER|PURCHASE_DATE          |
-- ----------+-----+-----+-----------------------+----------+------+-----+-----------------------+
-- АА0000АА  |ПАЗ  |Синій|1991-01-01 00:00:00.000|Вантажівка|     5|    1|                       |
-- АА0002АА  |ПАЗ  |Сірий|2001-01-01 00:00:00.000|Вантажівка|     7|    2|2018-10-10 00:00:00.000|




-- 4.6 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
-- рядками з урахуванням умови, що інвертує результат рішення 4.5
SELECT 
    car_number,
    brand,
    color,
    production_year,
    type,
    weight,
    owner,
    purchase_date
FROM Car
WHERE
    NOT(weight > 2) OR NOT(type = 'Вантажівка');

-- CAR_NUMBER|BRAND |COLOR   |PRODUCTION_YEAR        |TYPE      |WEIGHT|OWNER|PURCHASE_DATE|
-- ----------+------+--------+-----------------------+----------+------+-----+-------------+
-- ВН0000АА  |ЗАЗ   |Чорний  |2005-01-01 00:00:00.000|Легковик  |     2|    1|             |
-- АА0001АА  |Еталон|Червоний|2010-01-01 00:00:00.000|Вантажівка|   1.5|    2|             |
-- ВН0001АА  |ЗАЗА  |Білий   |2012-01-01 00:00:00.000|Автобус   |     4|    1|             |