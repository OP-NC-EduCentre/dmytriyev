-- 2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання 2.3
-- з лабораторної роботи No5, але враховує опцію «WITH READ ONLY»: отримати інформацію
-- про атрибутні типи. Отримати вміст таблиці.

-- Змінено назви колонок у представленні для виправлення помилки СКБД про дублікати назв колонок
CREATE OR REPLACE VIEW ATTRIBUTE_VIEW
    (OBJ_CODE, ATTR_ID, ATTR_CODE, ATTR_NAME, OBJ_REF)
AS
SELECT O.CODE, A.ATTR_ID, A.CODE, A.NAME, O_REF.CODE O_REF
FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF ON 
    (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID, A.ATTR_ID
WITH READ ONLY;

SELECT * FROM ATTRIBUTE_VIEW;

-- OBJ_CODE   |ATTR_ID|ATTR_CODE      |ATTR_NAME                   |OBJ_REF    |
-- -----------+-------+---------------+----------------------------+-----------+
-- Owner      |      1|first_name     |Імя                         |           |
-- Owner      |      2|last_name      |Прізвище                    |           |
-- Owner      |      3|patronymic     |По-батькові                 |           |
-- Owner      |      4|birth_date     |Дата народження             |           |
-- Owner      |      5|pasport        |Паспорт                     |           |
-- Owner      |      6|address        |Адреса проживання           |           |
-- Owner      |      7|phone          |Номер телефону              |           |
-- Car        |      8|car_number     |Номер автомобіля            |           |
-- Car        |      9|brand          |Марка                       |           |
-- Car        |     10|color          |Колір                       |           |
-- Car        |     11|production_year|Рік виробництва             |           |
-- Car        |     12|type           |Тип транспорту              |           |
-- Car        |     13|weight         |Вага                        |           |
-- Car        |     14|owner          |Власник                     |Owner      |
-- Car        |     18|parked_on      |Транспорт припарковано на...|ParkingSlot|
-- ParkingSlot|     15|intended_type  |Тип транспорту              |           |
-- ParkingSlot|     16|reserved_since |Зарезервовано з             |           |
-- ParkingSlot|     17|reserved_due   |Зарезервовано до            |           |


-- 2.2 Виконати видалення одного рядка з віртуальної таблиці, створеної у попередньому
-- завданні. Прокоментувати реакцію СУБД.
DELETE FROM ATTRIBUTE_VIEW
WHERE ATTR_ID = 10;

-- SQL Error [42399] [99999]: ORA-42399: cannot perform a DML operation on a read-only view

-- Так як представлення створено із модифікатором READ ONLY, операції DML заборонені




-- 2.3 Створити віртуальну таблицю, що містить дві колонки:
-- назва класу, кількість екземплярів об'єктів класу. Отримати вміст таблиці.
CREATE OR REPLACE VIEW OBJECT_TYPE_STATS
AS
SELECT 
    OT.NAME, 
    COUNT(O.OBJECT_ID) AS COUNT
FROM OBJECTS O JOIN OBJTYPE OT 
    ON (O.OBJECT_TYPE_ID = OT.OBJECT_TYPE_ID)
GROUP BY OT.NAME;

SELECT * FROM OBJECT_TYPE_STATS;

-- NAME      |COUNT|
-- ----------+-----+
-- Власник   |    2|
-- Автомобіль|    2|
-- Паркомісце|    2|




-- 2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
-- створеної у попередньому завданні. Прокоментувати реакцію СУБД.
UPDATE OBJECT_TYPE_STATS SET NAME = 'Власники'
WHERE NAME = 'Власник';

-- SQL Error [1732] [42000]: ORA-01732: data manipulation operation not legal on this view
-- Операції DML над представленнями, які містять агрегатні функції, заборонені