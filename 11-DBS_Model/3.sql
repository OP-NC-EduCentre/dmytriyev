-- 3.1. Виконайте DELETE-запит із попередніх рішень, додавши аналіз даних із неявного
-- курсору. Наприклад, кількість віддалених рядків

BEGIN
    DELETE FROM PARKINGSLOT P
    WHERE NOT EXISTS (
        SELECT * FROM CAR C WHERE C.CAR_NUMBER = P.CAR
    );
    DBMS_OUTPUT.PUT_LINE('Кількість видалених рядків: ' || SQL%ROWCOUNT);
END;
/

-- Кількість видалених рядків: 8




-- 3.2. Повторіть виконання завдання 3 етапу 1 з використанням явного курсору.
DECLARE
    CURSOR car_list IS
        SELECT type, AVG(weight) as avg_weight
        FROM Car
        GROUP BY type;
    car_rec car_list%ROWTYPE;
BEGIN
    OPEN car_list;
    FETCH car_list INTO car_rec;
    DBMS_OUTPUT.PUT_LINE(RPAD('Тип', 15, ' ') || 'Середня вага, т');
    WHILE car_list%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(car_rec.type, 15, ' ') || car_rec.avg_weight);
        FETCH car_list INTO car_rec;
    END LOOP;
    CLOSE car_list;
END;
/

-- Тип            Середня вага, т
-- Легковик       1,75
-- Вантажівка     4,6




-- 3.3 З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
-- викликатиме один із варіантів подібних SQL-запитів залежно від значення версії СУБД.
-- При вирішенні використовувати:
--   значення змінної DBMS_DB_VERSION.VERSION;
--   явний курсор із параметричним циклом.

BEGIN
    DBMS_OUTPUT.PUT_LINE('Версія CУБД: ' || DBMS_DB_VERSION.VERSION);

    IF DBMS_DB_VERSION.VERSION < 12 THEN
        DECLARE
            CURSOR car_list IS
                WITH 
                car_weight_sorted AS (
                    SELECT car_number, weight
                    FROM Car
                    ORDER BY weight DESC
                ),
                car_weight_rownum AS (
                    SELECT 
                        ROWNUM AS r,
                        car_number,
                        weight
                    FROM car_weight_sorted
                )
                SELECT car_number, weight
                FROM car_weight_rownum
                WHERE r <= 5;
        BEGIN
            DBMS_OUTPUT.PUT_LINE(RPAD('Номер', 10, ' ') || 'Вага, т');
            FOR car_item IN car_list LOOP
                DBMS_OUTPUT.PUT_LINE(RPAD(car_item.car_number, 10, ' ') || car_item.weight);
            END LOOP;
        END;
    ELSE
        DECLARE
        CURSOR car_list IS
            SELECT car_number, weight
            FROM Car
            ORDER BY weight DESC
            FETCH FIRST 5 ROWS ONLY;
        BEGIN
            DBMS_OUTPUT.PUT_LINE(RPAD('Номер', 10, ' ') || 'Вага, т');
            FOR car_item IN car_list LOOP
                DBMS_OUTPUT.PUT_LINE(RPAD(car_item.car_number, 10, ' ') || car_item.weight);
            END LOOP;
        END;
    END IF;
END;
/

-- Версія CУБД: 21
-- Номер     Вага, т
-- АА0002АА  7
-- АА0000АА  5
-- ВН0000АА  2
-- ВС1111АА  2
-- ВН1001НВ  1,8

