-- 1. Розробити механізм журналізації DML-операцій, що виконуються над таблицею
-- вашої бази даних, враховуючи такі дії:
--   створити таблицю з ім'ям LOG_ім'я_таблиці. Структура таблиці повинна
-- включати: ім'я користувача, тип операції, дата виконання операції, атрибути, що містять
-- старі та нові значення.
--   створити тригер журналювання.
-- Перевірити роботу тригера журналювання для операцій INSERT, UPDATE,
-- DELETE.

CREATE TABLE LOG_OWNER (
	OP_TYPE VARCHAR(6),
	USER_NAME VARCHAR(30),
	CHANGE_DATE DATE,
	NEW_ID NUMBER,
	NEW_FIRST_NAME VARCHAR(100),
	NEW_LAST_NAME VARCHAR(100),
	NEW_PATRONYMIC VARCHAR(100),
	NEW_BIRTH_DATE DATE,
	NEW_PASPORT VARCHAR(50),
	NEW_ADDRESS VARCHAR(100),
	NEW_PHONE VARCHAR(50),
	NEW_TRUSTEE NUMBER,
	NEW_EMAIL VARCHAR(100),
	OLD_FIRST_NAME VARCHAR(100),
	OLD_LAST_NAME VARCHAR(100),
	OLD_PATRONYMIC VARCHAR(100),
	OLD_BIRTH_DATE DATE,
	OLD_PASPORT VARCHAR(50),
	OLD_ADDRESS VARCHAR(100),
	OLD_PHONE VARCHAR(50),
	OLD_TRUSTEE NUMBER,
	OLD_EMAIL VARCHAR(100)
);


CREATE OR REPLACE TRIGGER owner_logger
    AFTER INSERT OR UPDATE OR DELETE ON Owner
    FOR EACH ROW
DECLARE
    operation LOG_OWNER.OP_TYPE%TYPE;
BEGIN
    IF INSERTING THEN operation := 'INSERT';
    ELSIF UPDATING THEN operation := 'UPDATE';
    ELSIF DELETING THEN operation := 'DELETE';
    END IF;
    INSERT INTO LOG_OWNER VALUES (
        operation,
        USER,
        SYSDATE,
        :NEW.id,
        :NEW.first_name,
        :NEW.last_name,
        :NEW.patronymic,
        :NEW.birth_date,
        :NEW.pasport,
        :NEW.address,
        :NEW.phone,
        :NEW.trustee,
        :NEW.email,
        :OLD.first_name,
        :OLD.last_name,
        :OLD.patronymic,
        :OLD.birth_date,
        :OLD.pasport,
        :OLD.address,
        :OLD.phone,
        :OLD.trustee,
        :OLD.email
    );
END;
/


INSERT INTO Owner (id, first_name, last_name, patronymic, birth_date, pasport, address, phone)
VALUES (owner_id.NEXTVAL, 'Іванов', 'Петро', NULL, '03/08/1992', '001111111', 'вул. Тіниста, 2', '+38(050)000-00-00');

UPDATE Owner
SET phone = '+38(099)999-99-99'
WHERE pasport = '001111111';

DELETE FROM Owner
WHERE pasport = '001111111';

SELECT * FROM LOG_OWNER;

-- OP_TYPE|USER_NAME|CHANGE_DATE            |NEW_ID|NEW_FIRST_NAME|NEW_LAST_NAME|NEW_PATRONYMIC|NEW_BIRTH_DATE         |NEW_PASPORT|NEW_ADDRESS    |NEW_PHONE        |NEW_TRUSTEE|NEW_EMAIL|OLD_FIRST_NAME|OLD_LAST_NAME|OLD_PATRONYMIC|OLD_BIRTH_DATE         |OLD_PASPORT|OLD_ADDRESS    |OLD_PHONE        |OLD_TRUSTEE|OLD_EMAIL|
-- -------+---------+-----------------------+------+--------------+-------------+--------------+-----------------------+-----------+---------------+-----------------+-----------+---------+--------------+-------------+--------------+-----------------------+-----------+---------------+-----------------+-----------+---------+
-- INSERT |DMITRIEV |21-12-2022 05:47:34.000|    46|Іванов        |Петро        |              |03-08-1992 00:00:00.000|001111111  |вул. Тіниста, 2|+38(050)000-00-00|           |         |              |             |              |                       |           |               |                 |           |         |
-- UPDATE |DMITRIEV |21-12-2022 05:47:39.000|    46|Іванов        |Петро        |              |03-08-1992 00:00:00.000|001111111  |вул. Тіниста, 2|+38(099)999-99-99|           |         |Іванов        |Петро        |              |03-08-1992 00:00:00.000|001111111  |вул. Тіниста, 2|+38(050)000-00-00|           |         |
-- DELETE |DMITRIEV |21-12-2022 05:47:49.000|      |              |             |              |                       |           |               |                 |           |         |Іванов        |Петро        |              |03-08-1992 00:00:00.000|001111111  |вул. Тіниста, 2|+38(099)999-99-99|           |         |




-- 2. Припустимо, що використовується СУБД до 12-ї версії, яка не підтримує механізм
-- DEFAULT SEQUENCE, який дозволяє автоматично внести нове значення первинного
-- ключа, якщо воно не задано при операції внесення. Для будь-якої колонки вашої бази даних
-- створити тригер з підтримкою механізму DEFAULT SEQUENCE. Навести тест-кейс
-- перевірки роботи тригера.

CREATE OR REPLACE TRIGGER owner_default_seq
    BEFORE INSERT ON Owner
    FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := owner_id.NEXTVAL;
    END IF;
END;
/

INSERT INTO Owner (first_name, last_name, patronymic, birth_date, pasport, address, phone)
VALUES ('Іванов', 'Петро', NULL, '03/08/1992', '001111111', 'вул. Тіниста, 2', '+38(050)000-00-00');

SELECT * FROM Owner
WHERE pasport = '001111111';

-- ID|FIRST_NAME|LAST_NAME|PATRONYMIC|BIRTH_DATE             |PASPORT  |ADDRESS        |PHONE            |TRUSTEE|EMAIL|
-- --+----------+---------+----------+-----------------------+---------+---------------+-----------------+-------+-----+
-- 47|Іванов    |Петро    |          |03-08-1992 00:00:00.000|001111111|вул. Тіниста, 2|+38(050)000-00-00|       |     |