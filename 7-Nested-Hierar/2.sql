-- 1. Багатотабличне внесення даних

-- Зареєструвати та припаркувати новий автомобіль для клієнта з номером паспорта КЕ44444

INSERT ALL
    INTO CAR (CAR_NUMBER, BRAND, COLOR, PRODUCTION_YEAR, TYPE, WEIGHT, OWNER)
        VALUES ('АА5555АА', 'ЗАЗ', 'Червоний', '01/01/2006', 'Легковик', 2, OWNER_ID)
    INTO PARKINGSLOT (POSITION, INTENDED_TYPE, RESERVED_SINCE, RESERVED_DUE, CAR)
        VALUES ('1 поверх', 'Легковик', SYSDATE, '10/10/2024', 'АА5555АА')
SELECT ID AS OWNER_ID
FROM OWNER
WHERE PASPORT = 'КЕ44444';




-- 2. Використання багатостовпцевих підзапитів при зміні даних

-- Зміна типу та ваги транспорту з номером АА5555АА на такі ж, як у транспорта ВН5050АА

UPDATE CAR
SET (TYPE, WEIGHT) = (
                        SELECT TYPE, WEIGHT
                        FROM CAR
                        WHERE CAR_NUMBER = 'ВН5050АА'
                     )
WHERE CAR_NUMBER = 'АА5555АА';




-- 3. Видалення рядків із використанням кореляційних підзапитів.

-- Видалити порожні паркомісця
DELETE FROM PARKINGSLOT P
WHERE 
    NOT EXISTS (
                SELECT * FROM CAR C WHERE C.CAR_NUMBER = P.CAR
               );




-- 4. Поєднаний INSERT/UPDATE запит – оператор MERGE

-- Створення копії таблиці автомобілів
CREATE TABLE CAR_COPY AS
    SELECT * FROM CAR;

-- Встановлення усім автомобілям як дату покупки поточну дату
UPDATE CAR SET PURCHASE_DATE = SYSDATE;

-- Видалення транспорту, вага якого перевищує 2 тонни
DELETE FROM CAR
WHERE WEIGHT > 2;

-- Відновлення дат покупки та видалених автомобілів
MERGE INTO CAR A
USING CAR_COPY B
    ON (A.CAR_NUMBER = B.CAR_NUMBER)
WHEN MATCHED THEN
    UPDATE SET A.PURCHASE_DATE = B.PURCHASE_DATE
WHEN NOT MATCHED THEN
    INSERT (CAR_NUMBER, BRAND, COLOR, PRODUCTION_YEAR, TYPE, WEIGHT, OWNER)
    VALUES (B.CAR_NUMBER, B.BRAND, B.COLOR, B.PRODUCTION_YEAR, B.TYPE, B.WEIGHT, B.OWNER)