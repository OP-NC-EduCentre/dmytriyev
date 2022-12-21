-- 1. Створити таблицю для реєстрації наступних DDL-подій: тип події, що спричинила
-- запуск тригера; ім'я користувача; ім'я об'єкта БД. Створити тригер реєстрації заданих подій
-- створення об'єктів. Подати тест-кейси перевірки роботи тригера.

CREATE TABLE LOG_DDL (
    OPERATION VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    OBJ_NAME VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER DDL_LOGGER
    AFTER CREATE OR ALTER OR DROP ON DMITRIEV.SCHEMA
BEGIN
    INSERT INTO LOG_DDL (
        OPERATION,
        USER_NAME,
        OBJ_NAME
    )
    VALUES (
        ORA_SYSEVENT,
        ORA_LOGIN_USER,
        ORA_DICT_OBJ_NAME
    );
END;
/


CREATE TABLE TESTING (
    FIELD NUMBER
);

ALTER TABLE TESTING
ADD SECOND VARCHAR(100);

DROP TABLE TESTING;


SELECT * FROM LOG_DDL;

-- OPERATION|USER_NAME|OBJ_NAME|
-- ---------+---------+--------+
-- CREATE   |DMITRIEV |TESTING |
-- ALTER    |DMITRIEV |TESTING |
-- DROP     |DMITRIEV |TESTING |