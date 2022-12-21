-- 1. Створити тригер для реалізації каскадного видалення рядків зі значеннями PK-
-- колонки, пов'язаних з FK-колонкою. Навести тест-кейс перевірки роботи тригера.

CREATE OR REPLACE TRIGGER owner_cascade_delete
    BEFORE DELETE ON Owner
    FOR EACH ROW
BEGIN
    DELETE FROM Car
    WHERE owner = :OLD.id;
END;
/


SELECT * FROM Car
WHERE owner = 2;

-- CAR_NUMBER|BRAND |COLOR|PRODUCTION_YEAR        |TYPE      |WEIGHT|OWNER|PURCHASE_DATE          |
-- ----------+------+-----+-----------------------+----------+------+-----+-----------------------+
-- ВН1001НВ  |Еталон|Синій|01-01-2010 00:00:00.000|Вантажівка|   1.8|    2|                       |
-- АА0002АА  |ПАЗ   |Сірий|01-01-2001 00:00:00.000|Вантажівка|     7|    2|10-10-2018 00:00:00.000|


DELETE FROM Owner
WHERE id = 2;

SELECT * FROM Car
WHERE owner = 2;

-- Запит не повернув жодного рядка




-- 2. Створити тригер для реалізації предметно-орієнтованого контролю спроби
-- додавання значення FK-колонки, що не існує у PK-колонці. Навести тест-кейс перевірки
-- роботи тригера.

CREATE OR REPLACE TRIGGER car_insert_owner_control
    BEFORE INSERT ON Car
    FOR EACH ROW
DECLARE
    owner_id Owner.id%TYPE;
BEGIN
    SELECT id INTO owner_id
    FROM Owner
    WHERE id = :NEW.owner;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20551, 'Власника з id = ' || :NEW.owner || ' не зареєстровано!');
END;
/


INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner, purchase_date)
VALUES ('АА0003АА', 'ПАЗ', 'Сірий', '01/01/2001', 'Вантажівка', 7, 15, '10/10/2018');

-- SQL Error [20551] [72000]: 
-- ORA-20551: Власника з id = 15 не зареєстровано!
-- ORA-06512: at "DMITRIEV.CAR_INSERT_OWNER_CONTROL", line 9
-- ORA-04088: error during execution of trigger 'DMITRIEV.CAR_INSERT_OWNER_CONTROL'