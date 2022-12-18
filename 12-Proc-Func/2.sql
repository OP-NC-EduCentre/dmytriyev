-- 2.1. Повторити виконання завдання 1 етапу 1, створивши процедуру з вхідним
-- параметром у вигляді кількості рядків, що вносяться.
-- Навести приклад виконання створеної процедури.

CREATE OR REPLACE PROCEDURE insert_copies (records IN NUMBER)
IS
    t1 TIMESTAMP;
    t2 TIMESTAMP;
    delta NUMBER; -- різниця у мілісекундах
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..records LOOP
        INSERT INTO ParkingSlot (id, position, intended_type)
        VALUES (slot_id.NEXTVAL, 'Надворі', 'Легковик');
    END LOOP;
    t2 := SYSTIMESTAMP;
    delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
				TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
    DBMS_OUTPUT.PUT_LINE('Час виконання: ' || delta || ' мс');
    DBMS_OUTPUT.PUT_LINE('Додано рядків: ' || records);
END;
/

DECLARE
    copies NUMBER := 100;
BEGIN
    insert_copies(copies);
END;
/

-- Час виконання: ,004 мс
-- Додано рядків: 100




-- 2.2. Створити функцію, яка повертає суму значень однієї з цілих колонок однієї з
-- таблиць. Навести приклад виконання створеної функції.

CREATE OR REPLACE FUNCTION get_sum_weight(car_type IN Car.type%TYPE)
RETURN NUMBER
IS
    sql_str VARCHAR2(500);
    weight_sum NUMBER;
BEGIN
    SELECT SUM(weight) INTO weight_sum
    FROM Car
    WHERE type = car_type;
    RETURN weight_sum;
END;
/


DECLARE
    car_type Car.type%TYPE := 'Легковик';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Сумарна вага транспорту типу ' || car_type || ': ' 
                            || get_sum_weight(car_type) || ' т');
END;
/

-- Сумарна вага транспорту типу Легковик: 7 т