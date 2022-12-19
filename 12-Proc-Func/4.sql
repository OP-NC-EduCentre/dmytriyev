-- 4.1. З урахуванням вашої предметної області створити табличну функцію, що
-- повертає значення будь-яких двох колонок будь-якої таблиці з урахуванням значення однієї
-- з колонок, що передається як параметр. Показати приклад виклику функції.

DROP TYPE car_weight_list;
DROP TYPE car_weight;

CREATE TYPE car_weight AS OBJECT (
    car_number VARCHAR(15),
    type VARCHAR(20),
    weight NUMBER(8,2)
);

CREATE TYPE car_weight_list IS TABLE OF car_weight;


CREATE OR REPLACE FUNCTION get_car_weight_info(car_type IN Car.type%TYPE)
RETURN car_weight_list
AS
    car_list car_weight_list := car_weight_list();
BEGIN
    SELECT car_weight(car_number, type, weight)
    BULK COLLECT INTO car_list
    FROM Car
    WHERE type = car_type;
    RETURN car_list;
END;
/


SELECT car_number, type, weight
FROM TABLE(get_car_weight_info('Легковик'))
ORDER BY weight DESC;

-- CAR_NUMBER|TYPE    |WEIGHT|
-- ----------+--------+------+
-- ВН0000АА  |Легковик|     2|
-- ВС1111АА  |Легковик|     2|
-- ВН5050АА  |Легковик|   1.5|
-- АА5555АА  |Легковик|   1.5|




-- 4.2. Повторіть рішення попереднього завдання, але з використанням конвеєрної
-- табличної функції.

CREATE OR REPLACE PACKAGE car_info_pkg IS
    TYPE car_weight IS RECORD (
        car_number VARCHAR(15),
        type VARCHAR(20),
        weight NUMBER(8,2)
    );
    TYPE car_weight_list IS TABLE OF car_weight;
    FUNCTION get_car_weight_info(car_type IN VARCHAR)
        RETURN car_weight_list PIPELINED;
END car_info_pkg;
/

CREATE OR REPLACE PACKAGE BODY car_info_pkg IS
    FUNCTION get_car_weight_info(car_type IN VARCHAR)
    RETURN car_weight_list PIPELINED
    AS
        car_list car_weight_list := car_weight_list();
    BEGIN
        FOR elem IN (SELECT car_number, type, weight
                     FROM Car
                     WHERE type = car_type) LOOP
            PIPE ROW(elem);
        END LOOP;
    END;
END car_info_pkg;
/

SELECT car_number, type, weight
FROM TABLE(car_info_pkg.get_car_weight_info('Легковик'))
ORDER BY weight DESC;

-- CAR_NUMBER|TYPE    |WEIGHT|
-- ----------+--------+------+
-- ВН0000АА  |Легковик|     2|
-- ВС1111АА  |Легковик|     2|
-- ВН5050АА  |Легковик|   1.5|
-- АА5555АА  |Легковик|   1.5|