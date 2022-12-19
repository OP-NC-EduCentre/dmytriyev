-- 3.1. Оформіть рішення завдань етапу 2 у вигляді програмного пакета. Наведіть
-- приклад виклику збереженої процедури та функції, враховуючи назву пакету.

CREATE OR REPLACE PACKAGE car_pkg IS
    PROCEDURE insert_copies (records IN NUMBER);
    FUNCTION get_sum_weight (car_type IN Car.type%TYPE)
        RETURN NUMBER;
END car_pkg;
/

CREATE OR REPLACE PACKAGE BODY car_pkg IS
    PROCEDURE insert_copies (records IN NUMBER)
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

    FUNCTION get_sum_weight(car_type IN Car.type%TYPE)
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
END car_pkg;
/




DECLARE
    copies NUMBER := 100;
BEGIN
    car_pkg.insert_copies(copies);
END;
/

-- Час виконання: ,015 мс
-- Додано рядків: 100


DECLARE
    car_type Car.type%TYPE := 'Легковик';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Сумарна вага транспорту типу ' || car_type || ': ' 
                            || car_pkg.get_sum_weight(car_type) || ' т');
END;
/

-- Сумарна вага транспорту типу Легковик: 7 т