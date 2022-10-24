-- 2.1. Створити таблицю описів атрибутних типів.
CREATE TABLE ATTRTYPE (
    ATTR_ID      		NUMBER(20),
    OBJECT_TYPE_ID 		NUMBER(20),
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200)
);

ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_PK
	PRIMARY KEY (ATTR_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_REF_FK
	FOREIGN KEY (OBJECT_TYPE_ID_REF) REFERENCES OBJTYPE (OBJECT_TYPE_ID);



-- 2.2 Для раніше використаних класів UML-діаграми заповнити описи атрибутних типів.

INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (1, 1, NULL, 'first_name', 'Імя');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (2, 1, NULL, 'last_name', 'Прізвище');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (3, 1, NULL, 'patronymic', 'По-батькові');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (4, 1, NULL, 'birth_date', 'Дата народження');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (5, 1, NULL, 'pasport', 'Паспорт');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (6, 1, NULL, 'address', 'Адреса проживання');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (7, 1, NULL, 'phone', 'Номер телефону');


INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (8, 2, NULL, 'car_number', 'Номер автомобіля');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (9, 2, NULL, 'brand', 'Марка');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (10, 2, NULL, 'color', 'Колір');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (11, 2, NULL, 'production_year', 'Рік виробництва');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (12, 2, NULL, 'type', 'Тип транспорту');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (13, 2, NULL, 'weight', 'Вага');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (14, 2, 1, 'owner', 'Власник');


INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (15, 3, NULL, 'intended_type', 'Тип транспорту');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (16, 3, NULL, 'reserved_since', 'Зарезервовано з');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (17, 3, NULL, 'reserved_due', 'Зарезервовано до');


INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (18, 2, 3, 'parked_on', 'Транспорт припарковано на...');

-- 2.3 Отримати інформацію про атрибутні типи.
SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME, O_REF.CODE O_REF
FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF ON 
    (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;

-- CODE       |ATTR_ID|CODE           |NAME                        |O_REF      |
-- -----------+-------+---------------+----------------------------+-----------+
-- Owner      |      1|first_name     |Імя                         |           |
-- Owner      |      2|last_name      |Прізвище                    |           |
-- Owner      |      3|patronymic     |По-батькові                 |           |
-- Owner      |      4|birth_date     |Дата народження             |           |
-- Owner      |      5|pasport        |Паспорт                     |           |
-- Owner      |      6|address        |Адреса проживання           |           |
-- Owner      |      7|phone          |Номер телефону              |           |
-- Car        |      8|car_number     |Номер автомобіля            |           |
-- Car        |      9|brand          |Марка                       |           |
-- Car        |     10|color          |Колір                       |           |
-- Car        |     11|production_year|Рік виробництва             |           |
-- Car        |     12|type           |Тип транспорту              |           |
-- Car        |     13|weight         |Вага                        |           |
-- Car        |     14|owner          |Власник                     |Owner      |
-- Car        |     18|parked_on      |Транспорт припарковано на...|ParkingSlot|
-- ParkingSlot|     15|intended_type  |Тип транспорту              |           |
-- ParkingSlot|     16|reserved_since |Зарезервовано з             |           |
-- ParkingSlot|     17|reserved_due   |Зарезервовано до            |           |




-- 2.4 Отримати інформацію про атрибутні типи та можливі зв'язки між ними типу «іменована
-- асоціація».
SELECT 
    O.CODE,
    A.ATTR_ID,
    A.CODE,
    A.NAME,
    O_REF.CODE AS O_REF
FROM OBJTYPE O, ATTRTYPE A 
    LEFT JOIN OBJTYPE O_REF ON (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID, A.ATTR_ID;

-- CODE       |ATTR_ID|CODE           |NAME                        |O_REF      |
-- -----------+-------+---------------+----------------------------+-----------+
-- Owner      |      1|first_name     |Імя                         |           |
-- Owner      |      2|last_name      |Прізвище                    |           |
-- Owner      |      3|patronymic     |По-батькові                 |           |
-- Owner      |      4|birth_date     |Дата народження             |           |
-- Owner      |      5|pasport        |Паспорт                     |           |
-- Owner      |      6|address        |Адреса проживання           |           |
-- Owner      |      7|phone          |Номер телефону              |           |
-- Car        |      8|car_number     |Номер автомобіля            |           |
-- Car        |      9|brand          |Марка                       |           |
-- Car        |     10|color          |Колір                       |           |
-- Car        |     11|production_year|Рік виробництва             |           |
-- Car        |     12|type           |Тип транспорту              |           |
-- Car        |     13|weight         |Вага                        |           |
-- Car        |     14|owner          |Власник                     |Owner      |
-- Car        |     18|parked_on      |Транспорт припарковано на...|ParkingSlot|
-- ParkingSlot|     15|intended_type  |Тип транспорту              |           |
-- ParkingSlot|     16|reserved_since |Зарезервовано з             |           |
-- ParkingSlot|     17|reserved_due   |Зарезервовано до            |           |