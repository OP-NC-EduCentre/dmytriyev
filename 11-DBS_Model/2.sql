-- 2.1. Повторити виконання завдання 3 етапу 1, забезпечивши контроль відсутності даних у
-- відповіді на запит із використанням винятку.

DECLARE
    v_avg_weight Car.weight%TYPE;
BEGIN
    SELECT weight INTO v_avg_weight
    FROM Car
    WHERE type = 'Тролейбус';
    DBMS_OUTPUT.PUT_LINE('Середня вага тролейбусів: ' || v_avg_weight || ' т');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Транспорту даного типу не знайдено');
END;
/

-- Транспорту даного типу не знайдено




-- 2.2. Повторити виконання завдання 3 етапу 1, забезпечивши контроль отримання
-- багаторядкової відповіді на запит.

DECLARE
    v_avg_weight Car.weight%TYPE;
BEGIN
    SELECT weight INTO v_avg_weight
    FROM Car
    WHERE type = 'Легковик';
    DBMS_OUTPUT.PUT_LINE('Середня вага легковиків: ' || v_avg_weight || ' т');
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Запит мав повернути лише одне значення, а повернув декілька...');
END;
/

-- Запит мав повернути лише одне значення, а повернув декілька...




-- 2.3. Повторити виконання завдання 3 етапу 1, забезпечивши контроль за внесенням
-- унікальних значень.

DECLARE
    v_owner Car.owner%TYPE := 1;
BEGIN
    INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner)
    VALUES ('ВС1111АА', 'ZAZ', 'Чорний', TO_DATE('12/12/2022', 'DD/MM/YYYY'), 'Легковик', 2, v_owner);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Транспорт з наданим номером вже зареєстровано раніше...');
END;
/

-- Транспорт з наданим номером вже зареєстровано раніше...
