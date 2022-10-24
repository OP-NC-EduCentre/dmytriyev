-- 4.1 Створити таблицю описів екземплярів об'єктів.
CREATE TABLE OBJECTS (
	OBJECT_ID      NUMBER(20),
	PARENT_ID      NUMBER(20),
	OBJECT_TYPE_ID NUMBER(20),
	NAME           VARCHAR2(2000),
	DESCRIPTION    VARCHAR2(4000)
);

ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PK
	PRIMARY KEY (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);




-- 4.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3,
-- заповнити описи екземплярів об'єктів.
INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (1, NULL, 1, 'Петров П.П.', NULL);
INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (2, NULL, 1, 'Іванов Іван', NULL);

INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (3, 1, 2, 'ЗАЗ ВН0000АА', 'Чорний легковик');
INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (4, 1, 2, 'ПАЗ АА0000АА', 'Синя вантажівка');




-- 4.3 Отримати колекцію екземплярів об'єктів для одного з об'єктних типів, використовуючи
-- його код.
SELECT 
    CAR.OBJECT_ID,
    CAR.NAME
FROM OBJECTS CAR, OBJTYPE OT 
WHERE 	
    OT.CODE = 'Car' 
	AND OT.OBJECT_TYPE_ID = CAR.OBJECT_TYPE_ID;

-- OBJECT_ID|NAME        |
-- ---------+------------+
--         3|ЗАЗ ВН0000АА|
--         4|ПАЗ АА0000АА|




-- 4.4 Отримати один екземпляр об'єкта заданого імені для одного з об'єктних типів,
-- використовуючи його код.
SELECT 
    CAR.OBJECT_ID,
    CAR.NAME
FROM OBJECTS CAR, OBJTYPE CAR_TYPE
WHERE 
	CAR.NAME = 'ЗАЗ ВН0000АА'
	AND CAR_TYPE.CODE = 'Car'
	AND CAR_TYPE.OBJECT_TYPE_ID = CAR.OBJECT_TYPE_ID;

-- OBJECT_ID|NAME        |
-- ---------+------------+
--         3|ЗАЗ ВН0000АА|