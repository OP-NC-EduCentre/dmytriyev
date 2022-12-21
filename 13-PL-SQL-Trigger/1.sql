-- 1. Створити інформуючий тригер для виведення повідомлення на екран після
-- додавання, зміни або видалення рядка з будь-якої таблиці Вашої бази даних із зазначенням
-- у повідомленні операції, на яку зреагував тригер. Навести тест-кейс перевірки роботи
-- тригера.

CREATE OR REPLACE TRIGGER slot_changes_after
    AFTER INSERT OR UPDATE OR DELETE ON ParkingSlot
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Додавання нового паркомісця...');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Оновлення інформації про паркомісце...');
	ELSIF DELETING THEN 
        DBMS_OUTPUT.PUT_LINE('Видалення паркомісця...');
    END IF;
END;
/

INSERT INTO ParkingSlot (position, intended_type)
VALUES ('Надворі', 'Легковик');

-- Додавання нового паркомісця...


UPDATE ParkingSlot 
SET reserved_since = '12/12/2022', reserved_due = '22/06/2023', car = 'ВН0000АА'
WHERE id = 30;

-- Оновлення інформації про паркомісце...


DELETE FROM ParkingSlot
WHERE id = 30;

-- Видалення паркомісця...




-- 2. Повторити попереднє завдання лише під час роботи користувача, ім'я якого
-- збігається з вашим логіном. Навести тест-кейс перевірки роботи тригера.

CREATE OR REPLACE TRIGGER slot_changes_after
    AFTER INSERT OR UPDATE OR DELETE ON ParkingSlot
    FOR EACH ROW
    WHEN (USER = 'DMITRIEV')
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Додавання нового паркомісця...');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Оновлення інформації про паркомісце...');
	ELSIF DELETING THEN 
        DBMS_OUTPUT.PUT_LINE('Видалення паркомісця...');
    END IF;
END;
/;


-- Для перевірки роботи тригера для іншого користувача, авторизувався як користувач SYSTEM.
-- У результаті виконання команд не було виведено жодного повідомлення.
-- Для користувача DMITRIEV виводяться повідомлення аналогічно попередньому завданню.

INSERT INTO DMITRIEV.ParkingSlot (position, intended_type)
VALUES ('Надворі', 'Легковик');

UPDATE DMITRIEV.ParkingSlot 
SET reserved_since = '12/12/2022', reserved_due = '22/06/2023', car = 'ВН0000АА'
WHERE id = 31;

DELETE FROM DMITRIEV.ParkingSlot
WHERE id = 31;