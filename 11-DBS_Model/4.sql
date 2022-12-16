-- 4.1. Виконайте введення 5 рядків у таблицю бази даних із динамічною генерацією
-- команди. Значення первинного ключа генеруються автоматично, решта даних дублюється.

DECLARE
    sql_str VARCHAR2(500);
    v_id ParkingSlot.id%TYPE;
    v_position ParkingSlot.position%TYPE;
    v_intended_type ParkingSlot.intended_type%TYPE;
BEGIN
    sql_str := 'INSERT INTO ParkingSlot (id, position, intended_type) VALUES (:1, :2, :3)';

    FOR i IN 1..5 LOOP
        v_id := slot_id.NEXTVAL;
        v_position := 'Надворі';
        v_intended_type := 'Легковик';
        EXECUTE IMMEDIATE sql_str 
            USING v_id, v_position, v_intended_type;
    END LOOP;
END;
/





-- 4.2. Скласти динамічний запит створення таблиці, іменами колонок якої будуть значення
-- будь-якої символьної колонки. Попередньо виконати перевірку існування таблиці з її
-- видаленням.

DECLARE 
	create_str VARCHAR2(500);
	v_count NUMBER;
BEGIN
    SELECT 1 INTO v_count
		FROM all_tables 
		WHERE table_name= upper('car_nums') AND 
				owner=upper('dmitriev');
	IF SQL%FOUND THEN
		EXECUTE IMMEDIATE 'DROP TABLE car_nums';
	END IF;
	create_str := 'CREATE TABLE car_nums (';
	FOR car_rec IN (SELECT car_number FROM car) LOOP
		create_str := create_str || car_rec.car_number || ' VARCHAR2(10),';
	END LOOP;
	create_str := RTRIM(create_str,',') || ')';
	DBMS_OUTPUT.PUT_LINE(create_str);
	EXECUTE IMMEDIATE create_str;
END;
/


SELECT COLUMN_NAME 
FROM ALL_TAB_COLUMNS 
WHERE TABLE_NAME = 'CAR_NUMS';

-- COLUMN_NAME|
-- -----------+
-- АА0000АА   |
-- АА0002АА   |
-- АА5555АА   |
-- ВН0000АА   |
-- ВН1001НВ   |
-- ВН5050АА   |
-- ВС1111АА   |





-- 4.3. Команда ALTER SEQUENCE може змінювати початкове значення генератора
-- починаючи з СУБД версії 12. Для ранніх версій доводиться виконувати дві команди: видалення
-- генератора та створення генератора з новим початковим значенням.
-- 
-- З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
-- викликатиме один із варіантів SQL-запитів зміни початкового значення генератора залежно від
-- значення версії СУБД.

DECLARE
    new_value NUMBER(4) := 15;
    sql_str VARCHAR2(500);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Версія СУБД: ' || DBMS_DB_VERSION.VERSION);
    IF DBMS_DB_VERSION.VERSION >= 12 THEN
        sql_str := 'ALTER SEQUENCE slot_id RESTART START WITH ' || new_value;
        EXECUTE IMMEDIATE sql_str;
    ELSE
        sql_str := 'DROP SEQUENCE slot_id';
        EXECUTE IMMEDIATE sql_str;
        sql_str := 'CREATE SEQUENCE slot_id START WITH ' || new_value;
        EXECUTE IMMEDIATE sql_str;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Виконаний запит: ' || sql_str);
END;
/

-- Версія СУБД: 21
-- Виконаний запит: ALTER SEQUENCE slot_id RESTART START WITH 15