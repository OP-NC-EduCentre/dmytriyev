-- 1.4 встановлення формату дати
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

-- 1.1 внесення даних
INSERT INTO Owner (id, first_name, last_name, patronymic, birth_date, pasport, address, phone)
VALUES (1, 'Петров', 'Петро', 'Петрович', '01/01/2000', 'КК112233', 'вул. Нижня, 50', '+380123456789');

INSERT INTO Owner (id, first_name, last_name, patronymic, birth_date, pasport, address, phone)
VALUES (2, 'Іванов', 'Іван', NULL, '03/08/1992', '001234567', 'вул. Верхня, 2А', '+380987654321');


INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner)
VALUES ('ВН0000АА', 'ЗАЗ', 'Чорний', '01/01/2005', 'Легковик', 2, 1);

INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner)
VALUES ('АА0000АА', 'ПАЗ', 'Синій', '01/01/1991', 'Вантажівка', 5, 1);


INSERT INTO ParkingSlot (id, position, intended_type, reserved_since, reserved_due, car)
VALUES (1, '1 поверх', 'Легковик', NULL, NULL, NULL); -- порожнє паркомісце

INSERT INTO ParkingSlot (id, position, intended_type, reserved_since, reserved_due, car)
VALUES (2, 'Надворі', 'Вантажівка', '22/02/2022', '22/02/2023', 'АА0000АА');


-- 1.2 додавання колонки типу DATE
ALTER TABLE Car ADD purchase_date DATE; -- дата покупки транспорту власником

-- 1.3 внесення рядка з невизначеним значенням нового атрибуту
INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner, purchase_date)
VALUES ('АА0001АА', 'Еталон', 'Червоний', '01/01/2010', 'Вантажівка', 1.5, 2, NULL);

-- 1.5 внесення рядка з новим атрибутом
INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner, purchase_date)
VALUES ('АА0002АА', 'ПАЗ', 'Сірий', '01/01/2001', 'Вантажівка', 7, 2, '10/10/2018');

-- 1.6 порушення цілісності потенційного ключа
INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner)
VALUES ('АА0003АА', 'ПАЗ', 'Сірий', '01/01/2001', 'Вантажівка', -5, 2); -- від'ємна вага
-- SQL Error [2290] [23000]: ORA-02290: check constraint (SYSTEM.CAR_WEIGHT_NOT_ZERO) violated

-- 1.7 порушення цілісності зовнішнього ключа
INSERT INTO ParkingSlot (id, position, intended_type, reserved_since, reserved_due, car)
VALUES (3, 'Надворі', 'Легковик', '22/01/2022', '22/06/2023', 'ВН5555АА');
-- SQL Error [2291] [23000]: ORA-02291: integrity constraint (SYSTEM.SLOT_CAR_FK) violated - parent key not found