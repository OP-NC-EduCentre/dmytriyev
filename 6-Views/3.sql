-- 3.1 Створити нового користувача, ім'я якого = «ваше_прізвище_латиницею»+'EAV',
-- наприклад, blazhko_eav, з правами, достатніми для створення та заповнення таблиць БД EAV.
CREATE USER dmitriev_eav IDENTIFIED BY password;
GRANT CONNECT TO dmitriev_eav;
GRANT RESOURCE TO dmitriev_eav;
GRANT CREATE VIEW TO dmitriev_eav;
ALTER USER dmitriev_eav quota unlimited ON USERS;

ALTER SESSION SET CURRENT_SCHEMA=dmitriev_eav;




-- 3.2 Створити таблиці БД EAV та заповнити таблиці об'єктних типів та атрибутних типів,
-- взявши рішення з лабораторної роботи No5.
CREATE TABLE DMITRIEV_EAV.OBJTYPE (
	OBJECT_TYPE_ID NUMBER(20),
	PARENT_ID      NUMBER(20),
	CODE           VARCHAR2(20),
	NAME           VARCHAR2(200),
	DESCRIPTION    VARCHAR2(1000)
);

ALTER TABLE DMITRIEV_EAV.OBJTYPE ADD CONSTRAINT OBJTYPE_PK
	PRIMARY KEY (OBJECT_TYPE_ID);
ALTER TABLE DMITRIEV_EAV.OBJTYPE ADD CONSTRAINT OBJTYPE_CODE_UNIQUE
	UNIQUE (CODE);
ALTER TABLE DMITRIEV_EAV.OBJTYPE 
	MODIFY (CODE NOT NULL);
ALTER TABLE DMITRIEV_EAV.OBJTYPE ADD CONSTRAINT OBJTYPE_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJTYPE(OBJECT_TYPE_ID);

INSERT INTO DMITRIEV_EAV.OBJTYPE (OBJECT_TYPE_ID, PARENT_ID, CODE, NAME, DESCRIPTION) 
	VALUES (1, NULL, 'Owner', 'Власник', 'Інформація про власників автомобілів');
INSERT INTO DMITRIEV_EAV.OBJTYPE (OBJECT_TYPE_ID, PARENT_ID, CODE, NAME, DESCRIPTION) 
	VALUES (2, 1, 'Car', 'Автомобіль', 'Інформація про автомобілі');
INSERT INTO DMITRIEV_EAV.OBJTYPE (OBJECT_TYPE_ID, PARENT_ID, CODE, NAME, DESCRIPTION) 
	VALUES (3, NULL, 'ParkingSlot', 'Паркомісце', 'Інформація про заповнення місць стоянки');



CREATE TABLE DMITRIEV_EAV.ATTRTYPE (
    ATTR_ID      		NUMBER(20),
    OBJECT_TYPE_ID 		NUMBER(20),
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200)
);

ALTER TABLE DMITRIEV_EAV.ATTRTYPE ADD CONSTRAINT ATTRTYPE_PK
	PRIMARY KEY (ATTR_ID);
ALTER TABLE DMITRIEV_EAV.ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
ALTER TABLE DMITRIEV_EAV.ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_REF_FK
	FOREIGN KEY (OBJECT_TYPE_ID_REF) REFERENCES OBJTYPE (OBJECT_TYPE_ID);

INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (1, 1, NULL, 'first_name', 'Імя');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (2, 1, NULL, 'last_name', 'Прізвище');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (3, 1, NULL, 'patronymic', 'По-батькові');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (4, 1, NULL, 'birth_date', 'Дата народження');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (5, 1, NULL, 'pasport', 'Паспорт');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (6, 1, NULL, 'address', 'Адреса проживання');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (7, 1, NULL, 'phone', 'Номер телефону');

INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (8, 2, NULL, 'car_number', 'Номер автомобіля');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (9, 2, NULL, 'brand', 'Марка');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (10, 2, NULL, 'color', 'Колір');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (11, 2, NULL, 'production_year', 'Рік виробництва');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (12, 2, NULL, 'type', 'Тип транспорту');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (13, 2, NULL, 'weight', 'Вага');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (14, 2, 1, 'owner', 'Власник');

INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (15, 3, NULL, 'intended_type', 'Тип транспорту');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (16, 3, NULL, 'reserved_since', 'Зарезервовано з');
INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (17, 3, NULL, 'reserved_due', 'Зарезервовано до');

INSERT INTO DMITRIEV_EAV.ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (18, 2, 3, 'parked_on', 'Транспорт припарковано на...');



CREATE TABLE DMITRIEV_EAV.LISTS (
	ATTR_ID NUMBER(10),
	LIST_VALUE_ID NUMBER(10),
	VALUE VARCHAR(4000)
);

ALTER TABLE DMITRIEV_EAV.LISTS ADD CONSTRAINT LISTS_PK
	PRIMARY KEY (LIST_VALUE_ID);
ALTER TABLE DMITRIEV_EAV.LISTS ADD CONSTRAINT LISTS_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES DMITRIEV_EAV.ATTRTYPE(ATTR_ID);

INSERT INTO DMITRIEV_EAV.LISTS(ATTR_ID, LIST_VALUE_ID, VALUE) 
	VALUES(12, 1, 'Легковик');
INSERT INTO DMITRIEV_EAV.LISTS(ATTR_ID, LIST_VALUE_ID, VALUE) 
	VALUES(12, 2, 'Вантажівка');
INSERT INTO DMITRIEV_EAV.LISTS(ATTR_ID, LIST_VALUE_ID, VALUE) 
	VALUES(12, 3, 'Автобус');



CREATE TABLE DMITRIEV_EAV.OBJECTS (
	OBJECT_ID      NUMBER(20),
	PARENT_ID      NUMBER(20),
	OBJECT_TYPE_ID NUMBER(20),
	NAME           VARCHAR2(2000),
	DESCRIPTION    VARCHAR2(4000)
);

ALTER TABLE DMITRIEV_EAV.OBJECTS ADD CONSTRAINT OBJECTS_PK
	PRIMARY KEY (OBJECT_ID);
ALTER TABLE DMITRIEV_EAV.OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
	FOREIGN KEY (PARENT_ID) REFERENCES DMITRIEV_EAV.OBJECTS (OBJECT_ID);
ALTER TABLE DMITRIEV_EAV.OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES DMITRIEV_EAV.OBJTYPE (OBJECT_TYPE_ID);

INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (1, NULL, 1, 'Петров П.П.', NULL);
INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (2, NULL, 1, 'Іванов Іван', NULL);

INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (3, 1, 2, 'ЗАЗ ВН0000АА', 'Чорний легковик');
INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (4, 1, 2, 'ПАЗ АА0000АА', 'Синя вантажівка');




CREATE TABLE DMITRIEV_EAV.ATTRIBUTES (
	ATTR_ID NUMBER(10),
	OBJECT_ID NUMBER(20),
	VALUE VARCHAR2(4000),
	DATE_VALUE DATE,
	LIST_VALUE_ID NUMBER(10)
);

ALTER TABLE DMITRIEV_EAV.ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_PK
	PRIMARY KEY (ATTR_ID, OBJECT_ID);
ALTER TABLE DMITRIEV_EAV.ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_LIST_VALUE_ID_FK
	FOREIGN KEY (LIST_VALUE_ID) REFERENCES DMITRIEV_EAV.LISTS (LIST_VALUE_ID);
ALTER TABLE DMITRIEV_EAV.ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES DMITRIEV_EAV.ATTRTYPE (ATTR_ID);
ALTER TABLE DMITRIEV_EAV.ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_OBJECT_ID_FK
	FOREIGN KEY (OBJECT_ID) REFERENCES DMITRIEV_EAV.OBJECTS (OBJECT_ID);

INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (1, 1, 'Петро', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (2, 1, 'Петров', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (3, 1, 'Петрович', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (4, 1, NULL, '01/01/2000', NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (5, 1, 'КК112233', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (6, 1, 'вул. Нижня, 50', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (7, 1, '+380123456789', NULL, NULL);

INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (1, 2, 'Іван', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (2, 2, 'Іванов', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (3, 2, NULL, NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (4, 2, NULL, '03/08/1992', NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (5, 2, '001234567', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (6, 2, 'вул. Верхня, 2А', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (7, 2, '+380987654321', NULL, NULL);

INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (8, 3, 'ВН0000АА', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (9, 3, 'ЗАЗ', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (10, 3, 'Чорний', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (11, 3, NULL, '01/01/2005', NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (12, 3, NULL, NULL, 1);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (13, 3, 2, NULL, NULL);

INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (8, 4, 'АА0000АА', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (9, 4, 'ПАЗ', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (10, 4, 'Синій', NULL, NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (11, 4, NULL, '01/01/1991', NULL);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (12, 4, NULL, NULL, 2);
INSERT INTO DMITRIEV_EAV.ATTRIBUTES (ATTR_ID, OBJECT_ID, VALUE, DATE_VALUE, LIST_VALUE_ID)
VALUES (13, 4, 5, NULL, NULL);



CREATE TABLE DMITRIEV_EAV.OBJREFERENCE (
	ATTR_ID   NUMBER(20),
	REFERENCE NUMBER(20),
	OBJECT_ID NUMBER(20)
);

ALTER TABLE DMITRIEV_EAV.OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_PK
	PRIMARY KEY (ATTR_ID,REFERENCE,OBJECT_ID);
ALTER TABLE DMITRIEV_EAV.OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_REFERENCE_FK
	FOREIGN KEY(REFERENCE) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE DMITRIEV_EAV.OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_OBJECT_ID_FK
	FOREIGN KEY (OBJECT_ID) REFERENCES DMITRIEV_EAV.OBJECTS(OBJECT_ID);
ALTER TABLE DMITRIEV_EAV.OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES DMITRIEV_EAV.ATTRTYPE (ATTR_ID);

-- Створімо об'єкти паркомісць, з якими можливі іменовані асоціації:
INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (5, NULL, 3, '001 1 поверх', NULL);
INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (6, NULL, 3, '002 Надворі', NULL);

INSERT INTO DMITRIEV_EAV.OBJREFERENCE (ATTR_ID, OBJECT_ID, REFERENCE) 
VALUES (18, 3, 5);
INSERT INTO DMITRIEV_EAV.OBJREFERENCE (ATTR_ID, OBJECT_ID, REFERENCE) 
VALUES (18, 4, 6);




-- 3.3 Створити генератор послідовності таблиці OBJECTS БД EAV, ініціалізувавши його
-- початковим значенням з урахуванням вже заповнених значень.
SELECT MAX(OBJECT_ID) FROM DMITRIEV_EAV.OBJECTS;

-- MAX(OBJECT_ID)|
-- --------------+
--              6|


CREATE SEQUENCE DMITRIEV_EAV.OBJECTS_SEQ START WITH 7; 



-- 3.4 Налаштувати права доступу нового користувача до таблиць схеми даних із таблицями
-- реляційної БД вашої предметної області, створеної в лабораторній роботі No2.
GRANT SELECT ON DMITRIEV.OWNER TO DMITRIEV_EAV;
GRANT SELECT ON DMITRIEV.CAR  TO DMITRIEV_EAV;
GRANT SELECT ON DMITRIEV.PARKINGSLOT TO DMITRIEV_EAV;




-- 3.5 Створити множину запитів типу INSERT INTO ... SELECT, які автоматично заповнять
-- таблицю OBJECTS, взявши потрібні дані з реляційної бази даних вашої предметної області.
INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME)
SELECT
    DMITRIEV_EAV.OBJECTS_SEQ.NEXTVAL,
    NULL,
    OT.OBJECT_TYPE_ID,
    O.LAST_NAME || ' ' || O.FIRST_NAME || ': ' || O.PASPORT
FROM 
    DMITRIEV_EAV.OBJTYPE OT,
    DMITRIEV.OWNER O
WHERE
	OT.CODE = 'Owner';

INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME)
SELECT
    DMITRIEV_EAV.OBJECTS_SEQ.NEXTVAL,
    OBJ.OBJECT_ID,
    OT.OBJECT_TYPE_ID,
    C.CAR_NUMBER || ' ' || C.BRAND
FROM 
    DMITRIEV_EAV.OBJTYPE OT,
    DMITRIEV.OWNER O,
    DMITRIEV.CAR C,
    DMITRIEV_EAV.OBJECTS OBJ
WHERE
	OT.CODE = 'Car'
    AND O.LAST_NAME || ' ' || O.FIRST_NAME || ': ' || O.PASPORT = OBJ.NAME
    AND O.ID = C.OWNER;
    
INSERT INTO DMITRIEV_EAV.OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME)
SELECT
    DMITRIEV_EAV.OBJECTS_SEQ.NEXTVAL,
    NULL,
    OT.OBJECT_TYPE_ID,
    PS.ID || ' ' || PS.POSITION
FROM
    DMITRIEV.PARKINGSLOT PS,
    DMITRIEV_EAV.OBJTYPE OT
WHERE
    OT.CODE = 'ParkingSlot';
    

SELECT * FROM DMITRIEV_EAV.OBJECTS;

-- OBJECT_ID|PARENT_ID|OBJECT_TYPE_ID|NAME                      |DESCRIPTION    |
-- ---------+---------+--------------+--------------------------+---------------+
--         1|         |             1|Петров П.П.               |               |
--         2|         |             1|Іванов Іван               |               |
--         3|        1|             2|ЗАЗ ВН0000АА              |Чорний легковик|
--         4|        1|             2|ПАЗ АА0000АА              |Синя вантажівка|
--         5|         |             3|001 1 поверх              |               |
--         6|         |             3|002 Надворі               |               |
--         7|         |             1|Петро Петров: КК112233    |               |
--         8|         |             1|Іван Іванов: 001234567    |               |
--         9|         |             1|Георгій Георгієв: КЕ12345 |               |
--        10|         |             1|Григорій Петренко: КЕ44444|               |
--        11|        7|             2|ВН0000АА ZAZ              |               |
--        12|        7|             2|АА0000АА ПАЗ              |               |
--        13|        8|             2|АА0001АА Еталон           |               |
--        14|        8|             2|АА0002АА ПАЗ              |               |
--        15|       10|             2|ВН5050АА ЗАЗ              |               |
--        16|         |             3|1 1 поверх                |               |
--        17|         |             3|2 Надворі                 |               |
--        18|         |             3|24 Надворі                |               |
--        19|         |             3|25 1 поверх               |               |

-- Перші 6 об'єктів було створено під час виконання завдання 3.2