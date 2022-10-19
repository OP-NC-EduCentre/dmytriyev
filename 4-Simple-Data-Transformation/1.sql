-- 1.1. Для всіх таблиць нової БД створити генератори послідовності, щоб забезпечити
-- автоматичне створення нових значень колонок, які входять у первинний ключ. Врахувати наявність
-- рядків у таблицях. Виконати тестове внесення одного рядка до кожної таблиці.
SELECT MAX(id) FROM Owner;

-- MAX(ID)|
-- -------+
--       2

CREATE SEQUENCE owner_id START WITH 3;
INSERT INTO Owner (id, first_name, last_name, patronymic, birth_date, pasport, address, phone)
VALUES (owner_id.NEXTVAL, 'Георгієв', 'Георгій', 'Георгійович', '12/12/1971', 'КЕ12345', 'вул. Лівобережна, 11', '+380991234567');


-- Для сутності Car послідовність не створюється, адже первинний ключ є символьним атрибутом


SELECT MAX(id) FROM ParkingSlot;

-- MAX(ID)|
-- -------+
--       3|

CREATE SEQUENCE slot_id START WITH 4;
INSERT INTO ParkingSlot (id, position, intended_type, reserved_since, reserved_due, car)
VALUES (slot_id.NEXTVAL, 'Надворі', 'Легковик', NULL, NULL, NULL);




-- 1.2 Для всіх пар взаємопов'язаних таблиць створити транзакції, що включають дві INSERT-
-- команди внесення рядка в дві таблиці кожної пари з урахуванням зв'язку між PK-колонкою першої
-- таблиці і FK-колонкою 2-ї таблиці пари з використанням псевдоколонок NEXTVAL і CURRVAL.
INSERT INTO Owner (id, first_name, last_name, patronymic, birth_date, pasport, address, phone)
VALUES (owner_id.NEXTVAL, 'Петренко', 'Григорій', 'Іванович', '10/12/1976', 'КЕ44444', 'вул. Лівобережна, 12', '+38099432112');
INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner)
VALUES ('ВН5050АА', 'ЗАЗ', 'Білий', '01/01/2014', 'Легковик', 1.5, owner_id.CURRVAL);

-- Так як первинний ключ сутності Car є рядком, тому із пов'язаною таблицею ParkingSlot
-- не можна виконати операцію INSERT за допомогою генерованого значення послідовності,
-- подібно прикладу вище




-- 1.3 Отримати інформацію про створені генератори послідовностей, використовуючи системну
-- таблицю СУБД Oracle.
SELECT SEQUENCE_NAME,LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME IN ('OWNER_ID', 'SLOT_ID');

-- SEQUENCE_NAME|LAST_NUMBER|
-- -------------+-----------+
-- OWNER_ID     |         23|
-- SLOT_ID      |         24|




-- 1.4 Використовуючи СУБД Oracle >= 12 для однієї з таблиць створити генерацію унікальних
-- значень PK-колонки через DEFAULT-оператор. Виконати тестове внесення одного рядка до таблиці.
ALTER TABLE ParkingSlot MODIFY (
    id NUMBER DEFAULT slot_id.NEXTVAL NOT NULL
);

INSERT INTO ParkingSlot (position, intended_type, reserved_since, reserved_due, car)
VALUES ('1 поверх', 'Легковик', NULL, NULL, NULL);