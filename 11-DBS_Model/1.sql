-- 1.1. Виберіть таблицю бази даних, що містить стовпець типу date. Оголосіть змінні, що
-- відповідають стовпцям цієї таблиці, використовуючи посилальні типи даних. Надайте змінним
-- значення, використовуйте SQL-функції для формування значень послідовності, перетворення
-- дати до вибраного стилю. Виведіть на екран рядок.

DECLARE
    v_car Car%ROWTYPE;
BEGIN
	v_car.car_number := 'ВС1111АА';
	v_car.brand := 'ZAZ';
	v_car.color := 'Чорний';
    v_car.production_year := TO_DATE('12/12/2022', 'DD/MM/YYYY');
    v_car.type := 'Легковик';
    v_car.weight := 2;
    v_car.owner := 1;
    DBMS_OUTPUT.PUT_LINE('car_number: ' || v_car.car_number);
    DBMS_OUTPUT.PUT_LINE('production_year: ' || v_car.production_year);
END;
/

-- car_number: ВС1111АА
-- production_year: 12/12/2022




-- 1.2. Додати інформацію до однієї з таблиць, обрану у попередньому завданні.
-- Використовувати формування нового значення послідовності та перетворення формату дати.

DECLARE
    v_owner Car.owner%TYPE := 1;
BEGIN
    INSERT INTO Car (car_number, brand, color, production_year, type, weight, owner)
    VALUES ('ВС1111АА', 'ZAZ', 'Чорний', TO_DATE('12/12/2022', 'DD/MM/YYYY'), 'Легковик', 2, v_owner);
END;
/




-- 1.3. Для однієї з таблиць створити команду отримання середнього значення однієї з
-- цілих колонок, використовуючи умову вибірки за заданим значенням іншої колонки. Результат
-- присвоїти змінній і вивести на екран.

DECLARE
    v_avg_weight Car.weight%TYPE;
BEGIN
    SELECT AVG(weight) INTO v_avg_weight
    FROM Car
    WHERE type = 'Легковик';
    DBMS_OUTPUT.PUT_LINE('Середня вага легковиків: ' || v_avg_weight || ' т');
END;
/

-- Середня вага легковиків: 1,75 т




-- 1.4. Виконайте введення 5 рядків у таблицю бази даних, використовуючи цикл з
-- параметрами. Значення первинного ключа генеруються автоматично, решта даних дублюється.

BEGIN
    FOR i IN 1..5 LOOP
        INSERT INTO ParkingSlot (id, position, intended_type)
        VALUES (slot_id.NEXTVAL, 'Надворі', 'Легковик');
    END LOOP;
END;
/