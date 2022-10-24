-- 1.1. Створити таблицю опису об'єктних типів.
CREATE TABLE OBJTYPE (
	OBJECT_TYPE_ID NUMBER(20),
	PARENT_ID      NUMBER(20),
	CODE           VARCHAR2(20),
	NAME           VARCHAR2(200),
	DESCRIPTION    VARCHAR2(1000)
);

ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_PK
	PRIMARY KEY (OBJECT_TYPE_ID);
ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_CODE_UNIQUE
	UNIQUE (CODE);
ALTER TABLE OBJTYPE 
	MODIFY (CODE NOT NULL);
ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJTYPE(OBJECT_TYPE_ID);


-- 1.2 Нехай у лабораторній роботі No1 було створено UML-діаграму концептуальних класів. Для
-- трьох класів з UML-діаграми, пов'язаних між собою, бажано зв'язком «узагальнення», «агрегатна
-- асоціація» та «іменована асоціація», заповнити опис об'єктних типів.
INSERT INTO OBJTYPE (OBJECT_TYPE_ID, PARENT_ID, CODE, NAME, DESCRIPTION) 
	VALUES (1, NULL, 'Owner', 'Власник', 'Інформація про власників автомобілів');
INSERT INTO OBJTYPE (OBJECT_TYPE_ID, PARENT_ID, CODE, NAME, DESCRIPTION) 
	VALUES (2, 1, 'Car', 'Автомобіль', 'Інформація про автомобілі');
INSERT INTO OBJTYPE (OBJECT_TYPE_ID, PARENT_ID, CODE, NAME, DESCRIPTION) 
	VALUES (3, 2, 'ParkingSlot', 'Паркомісце', 'Інформація про заповнення місць стоянки');


-- 1.3 Отримати інформацію про об'єктні типи.
SELECT OBJECT_TYPE_ID, PARENT_ID, CODE, NAME
	FROM OBJTYPE;

-- OBJECT_TYPE_ID|PARENT_ID|CODE       |NAME      |
-- --------------+---------+-----------+----------+
--              3|        2|ParkingSlot|Паркомісце|
--              1|         |Owner      |Власник   |
--              2|        1|Car        |Автомобіль|




-- 1.4 Отримати інформацію про об'єктні типи та можливі зв'язки між ними типу «узагальнення»,
-- «агрегатна асоціація».
SELECT 
    P.OBJECT_TYPE_ID,
    P.CODE,
	C.OBJECT_TYPE_ID AS OBJ_T_ID_LINK, 
    C.CODE AS CODE_LINK
FROM OBJTYPE C, OBJTYPE P
WHERE P.OBJECT_TYPE_ID = C.PARENT_ID(+);

-- OBJECT_TYPE_ID|CODE       |OBJ_T_ID_LINK|CODE_LINK  |
-- --------------+-----------+-------------+-----------+
--              2|Car        |            3|ParkingSlot|
--              1|Owner      |            2|Car        |
--              3|ParkingSlot|             |           |