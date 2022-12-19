-- 1.1. Повторіть виконання завдання 4 етапу 1 із попередньої лабораторної роботи:
--   циклічно внести 5000 рядків;
--   визначити загальний час на внесення зазначених рядків;
--   вивести на екран значення часу.

DECLARE
    t1 TIMESTAMP;
    t2 TIMESTAMP;
    delta NUMBER; -- різниця у мілісекундах
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..5000 LOOP
        INSERT INTO ParkingSlot (id, position, intended_type)
        VALUES (slot_id.NEXTVAL, 'Надворі', 'Легковик');
    END LOOP;
    t2 := SYSTIMESTAMP;
    delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
				TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
    DBMS_OUTPUT.PUT_LINE('Час виконання: ' || delta || ' мс');
END;
/

-- Час виконання: ,249 мс




-- 1.2. Повторіть виконання попереднього завдання, порівнявши час виконання
-- циклічних внесень рядків, використовуючи два способи: FOR і FORALL.

DROP TABLE ParkingSlot1;
DROP TABLE ParkingSlot2;
CREATE TABLE ParkingSlot1 (id NUMBER(8), position VARCHAR2(20));
CREATE TABLE ParkingSlot2 (id NUMBER(8), position VARCHAR2(20));

DECLARE
    TYPE IdTab IS TABLE OF ParkingSlot.id%TYPE INDEX BY PLS_INTEGER;
    TYPE PositionTab IS TABLE OF ParkingSlot.position%TYPE INDEX BY PLS_INTEGER;
    ids IdTab; positions PositionTab;
    iterations CONSTANT PLS_INTEGER := 5000;
    t1 TIMESTAMP; t2 TIMESTAMP; delta NUMBER;
BEGIN
    FOR j IN 1..iterations LOOP
        ids(j) := j;
        positions(j) := 'Надворі' || TO_CHAR(j);
    END LOOP;
    
    t1 := SYSTIMESTAMP;
    FOR i IN 1..iterations LOOP
        INSERT INTO ParkingSlot1 (id, position) 
        VALUES (ids(i), positions(i));
    END LOOP;
    t2 := SYSTIMESTAMP;
    delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
				TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
    DBMS_OUTPUT.PUT_LINE('Час виконання (FOR): ' || delta || ' мс');

    t1 := SYSTIMESTAMP;
    FORALL i IN 1..iterations
        INSERT INTO ParkingSlot2 (id, position) 
        VALUES (ids(i), positions(i));
    t2 := SYSTIMESTAMP;
    delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
				TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
    DBMS_OUTPUT.PUT_LINE('Час виконання (FORALL): ' || delta || ' мс');
END;
/

-- Час виконання (FOR): ,169 мс
-- Час виконання (FORALL): ,013 мс




-- 1.3. Для однієї з таблиць отримайте рядки з використанням курсору та пакетної
-- обробки SELECT-операції з оператором BULK COLLECT.
DECLARE
    CURSOR car_list IS
        SELECT 
            car_number, 
            type, 
            weight
        FROM Car;
    car_rec car_list%ROWTYPE;
    TYPE CarList IS TABLE OF car_list%ROWTYPE;
    car_list_arr CarList;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Отримання рядків за допомогою CURSOR:');
    DBMS_OUTPUT.PUT_LINE(RPAD('Номер', 15, ' ') || RPAD('Тип', 15, ' ') || 'Вага, т');
    FOR car_rec IN car_list LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(car_rec.car_number, 15, ' ') || RPAD(car_rec.type, 15, ' ') 
                                    || car_rec.weight);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Отримання рядків за допомогою BULK COLLECT:');
    SELECT 
        car_number, 
        type, 
        weight
    BULK COLLECT INTO car_list_arr
    FROM Car;
    DBMS_OUTPUT.PUT_LINE(RPAD('Номер', 15, ' ') || RPAD('Тип', 15, ' ') || 'Вага, т');
    FOR i IN car_list_arr.FIRST..car_list_arr.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(car_list_arr(i).car_number, 15, ' ') || RPAD(car_list_arr(i).type, 15, ' ') 
                                    || car_list_arr(i).weight);
    END LOOP;
END;
/

-- Отримання рядків за допомогою CURSOR:
-- Номер          Тип            Вага, т
-- ВН5050АА       Легковик       1,5
-- АА5555АА       Легковик       1,5
-- ВН1001НВ       Вантажівка     1,8
-- ВН0000АА       Легковик       2
-- АА0000АА       Вантажівка     5
-- АА0002АА       Вантажівка     7
-- ВС1111АА       Легковик       2
-- 
-- Отримання рядків за допомогою BULK COLLECT:
-- Номер          Тип            Вага, т
-- ВН5050АА       Легковик       1,5
-- АА5555АА       Легковик       1,5
-- ВН1001НВ       Вантажівка     1,8
-- ВН0000АА       Легковик       2
-- АА0000АА       Вантажівка     5
-- АА0002АА       Вантажівка     7
-- ВС1111АА       Легковик       2