-- Одна з колонок таблиць повинна містити строкове значення з двома словами,
-- розділеними пробілом. Виконайте команду UPDATE, помінявши місцями ці два слова.

-- Перегляд даних до змін
SELECT * FROM PARKINGSLOT;

-- ID|POSITION|INTENDED_TYPE|RESERVED_SINCE|RESERVED_DUE|CAR     |
-- --+--------+-------------+--------------+------------+--------+
-- 44|1 поверх|Легковик     |    2022-11-27|  2024-10-10|АА5555АА|
--  1|1 поверх|Легковик     |              |            |        |
--  2|Надворі |Вантажівка   |    2022-02-22|  2023-02-22|АА0000АА|
-- 24|Надворі |Легковик     |              |            |        |
-- 25|1 поверх|Легковик     |              |            |        |


UPDATE PARKINGSLOT
SET POSITION = REGEXP_REPLACE(POSITION, '^(\S+)\s(\S+)$', '\2 \1');


-- Перегляд даних після змін
SELECT * FROM PARKINGSLOT;

-- ID|POSITION|INTENDED_TYPE|RESERVED_SINCE|RESERVED_DUE|CAR     |
-- --+--------+-------------+--------------+------------+--------+
-- 44|поверх 1|Легковик     |    2022-11-27|  2024-10-10|АА5555АА|
--  1|поверх 1|Легковик     |              |            |        |
--  2|Надворі |Вантажівка   |    2022-02-22|  2023-02-22|АА0000АА|
-- 24|Надворі |Легковик     |              |            |        |
-- 25|поверх 1|Легковик     |              |            |        |




-- Одна з колонок таблиць має містити строкове значення з електронною поштовою
-- адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит,
-- вилучення логіна користувача з електронної адреси (підстрока перед символом @).
SELECT
    FIRST_NAME,
    LAST_NAME,
    PATRONYMIC,
    PASPORT,
    PHONE,
    REGEXP_REPLACE(EMAIL, '^([a-zA-z0-9_.]+)\@[a-zA-z0-9_.]+(\.[a-zA-z0-9_.]+){1,2}$', '\1') AS LOGIN
FROM OWNER
WHERE EMAIL IS NOT NULL;

-- FIRST_NAME|LAST_NAME|PATRONYMIC|PASPORT  |PHONE            |LOGIN|
-- ----------+---------+----------+---------+-----------------+-----+
-- Петров    |Петро    |Петрович  |КК112233 |+38(012)345-67-89|mail |
-- Іванов    |Іван     |          |001234567|+38(098)765-43-21|int  |




-- Одна з колонок таблиць повинна містити строкове значення з номером мобільного
-- телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Виконайте команду UPDATE,
-- додавши перед номером телефону фразу «Mobile:».

-- Перегляд даних до змін
SELECT * FROM OWNER;

-- ID|FIRST_NAME|LAST_NAME|PATRONYMIC |BIRTH_DATE|PASPORT  |ADDRESS             |PHONE            |TRUSTEE|EMAIL         |
-- --+----------+---------+-----------+----------+---------+--------------------+-----------------+-------+--------------+
--  1|Петров    |Петро    |Петрович   |2000-01-01|КК112233 |вул. Нижня, 50      |+38(012)345-67-89|       |mail@mail.ua  |
--  2|Іванов    |Іван     |           |1992-08-03|001234567|вул. Верхня, 2А     |+38(098)765-43-21|      1|int@int.exe.ua|
-- 23|Георгієв  |Георгій  |Георгійович|1971-12-12|КЕ12345  |вул. Лівобережна, 11|+38(099)123-45-67|     24|              |
-- 24|Петренко  |Григорій |Іванович   |1976-12-10|КЕ44444  |вул. Лівобережна, 12|+38(099)432-11-23|       |              |
-- 44|Ban Ban   |Sergio   |           |2000-01-01|КК112244 |вул. Нижня, 55      |+38(012)346-57-89|       |              |

-- Збільшення ліміту кількості символів у номері телефоні
ALTER TABLE OWNER MODIFY PHONE VARCHAR(50);

UPDATE OWNER 
SET PHONE = REGEXP_REPLACE(PHONE, '^(\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2})$', 'Mobile: \1'); 


-- Перегляд даних після змін
SELECT * FROM OWNER;

-- ID|FIRST_NAME|LAST_NAME|PATRONYMIC |BIRTH_DATE|PASPORT  |ADDRESS             |PHONE                    |TRUSTEE|EMAIL         |
-- --+----------+---------+-----------+----------+---------+--------------------+-------------------------+-------+--------------+
--  1|Петров    |Петро    |Петрович   |2000-01-01|КК112233 |вул. Нижня, 50      |Mobile: +38(012)345-67-89|       |mail@mail.ua  |
--  2|Іванов    |Іван     |           |1992-08-03|001234567|вул. Верхня, 2А     |Mobile: +38(098)765-43-21|      1|int@int.exe.ua|
-- 23|Георгієв  |Георгій  |Георгійович|1971-12-12|КЕ12345  |вул. Лівобережна, 11|Mobile: +38(099)123-45-67|     24|              |
-- 24|Петренко  |Григорій |Іванович   |1976-12-10|КЕ44444  |вул. Лівобережна, 12|Mobile: +38(099)432-11-23|       |              |
-- 44|Ban Ban   |Sergio   |           |2000-01-01|КК112244 |вул. Нижня, 55      |Mobile: +38(012)346-57-89|       |              |




-- Додайте до колонки з електронною адресою обмеження цілісності, що забороняє
-- вносити дані, відмінні від формату електронної адреси, використовуючи команду ALTER TABLE
-- таблиця ADD CONSTRAINT обмеження CHECK (умова). Перевірте роботу обмеження на двох
-- прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.

ALTER TABLE OWNER ADD CONSTRAINT OWNER_EMAIL_CORRECT 
    CHECK (REGEXP_LIKE(EMAIL, '^([a-z][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4})$'));
    

UPDATE OWNER SET EMAIL = 'ASDFG@' WHERE ID = 23;
-- SQL Error [2290] [23000]: ORA-02290: check constraint (DMITRIEV.OWNER_EMAIL_CORRECT) violated


UPDATE OWNER SET EMAIL = 'truemail@mail.ua' WHERE ID = 23;




-- Видаліть зайві дані з колонки з номером мобільного телефону, залишивши тільки номер
-- телефону в заданому форматі.

-- Перегляд даних до змін
SELECT * FROM OWNER;

-- ID|FIRST_NAME|LAST_NAME|PATRONYMIC |BIRTH_DATE|PASPORT  |ADDRESS             |PHONE                    |TRUSTEE|EMAIL           |
-- --+----------+---------+-----------+----------+---------+--------------------+-------------------------+-------+----------------+
--  1|Петров    |Петро    |Петрович   |2000-01-01|КК112233 |вул. Нижня, 50      |Mobile: +38(012)345-67-89|       |mail@mail.ua    |
--  2|Іванов    |Іван     |           |1992-08-03|001234567|вул. Верхня, 2А     |Mobile: +38(098)765-43-21|      1|int@int.exe.ua  |
-- 23|Георгієв  |Георгій  |Георгійович|1971-12-12|КЕ12345  |вул. Лівобережна, 11|Mobile: +38(099)123-45-67|     24|truemail@mail.ua|
-- 24|Петренко  |Григорій |Іванович   |1976-12-10|КЕ44444  |вул. Лівобережна, 12|Mobile: +38(099)432-11-23|       |                |
-- 44|Ban Ban   |Sergio   |           |2000-01-01|КК112244 |вул. Нижня, 55      |Mobile: +38(012)346-57-89|       |                |


UPDATE OWNER 
SET PHONE = REGEXP_SUBSTR(PHONE, '\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2}'); 


-- Перегляд даних після змін
SELECT * FROM OWNER;

-- ID|FIRST_NAME|LAST_NAME|PATRONYMIC |BIRTH_DATE|PASPORT  |ADDRESS             |PHONE            |TRUSTEE|EMAIL           |
-- --+----------+---------+-----------+----------+---------+--------------------+-----------------+-------+----------------+
--  1|Петров    |Петро    |Петрович   |2000-01-01|КК112233 |вул. Нижня, 50      |+38(012)345-67-89|       |mail@mail.ua    |
--  2|Іванов    |Іван     |           |1992-08-03|001234567|вул. Верхня, 2А     |+38(098)765-43-21|      1|int@int.exe.ua  |
-- 23|Георгієв  |Георгій  |Георгійович|1971-12-12|КЕ12345  |вул. Лівобережна, 11|+38(099)123-45-67|     24|truemail@mail.ua|
-- 24|Петренко  |Григорій |Іванович   |1976-12-10|КЕ44444  |вул. Лівобережна, 12|+38(099)432-11-23|       |                |
-- 44|Ban Ban   |Sergio   |           |2000-01-01|КК112244 |вул. Нижня, 55      |+38(012)346-57-89|       |                |




-- Додайте в колонку з мобільним телефоном обмеження цілісності, що забороняє вносити
-- дані, відмінні від формату, записаного в завданні 3. Перевірте роботу обмеження на двох
-- прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
ALTER TABLE OWNER ADD CONSTRAINT OWNER_PHONE_CORRECT
    CHECK(REGEXP_LIKE(PHONE, '^\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2}$'));


UPDATE OWNER SET PHONE = '+33332323232323232' WHERE ID = 44;
-- SQL Error [2290] [23000]: ORA-02290: check constraint (DMITRIEV.OWNER_PHONE_CORRECT) violated


UPDATE OWNER SET PHONE = '+38(099)999-99-99' WHERE ID = 44;
